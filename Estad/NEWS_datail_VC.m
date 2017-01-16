//
//  NEWS_datail_VC.m
//  Estad
//
//  Created by Apple on 16/11/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import "NEWS_datail_VC.h"
#import "News_local.h"
#import "Add_comment_VC.h"
#import "Comments_VC.h"
#import "HomeController.h"
#import "E_magazine_VC.h"
#import "Editorial_board_VC.h"
#import "ContactUS_VC.h"
#import "Article_VC.h"
#import "photos_VC.h"
#import "Videos_VC.h"
#import "WhatsAppKit.h"
#import <social/social.h>


@interface NEWS_datail_VC ()
{
    NSMutableDictionary *json_DATA;
    NSArray *NewsComment;
}

@end

@implementation NEWS_datail_VC

@synthesize get_titl,get_ID;

@synthesize get_home,get_Article,get_About_US,get_Editorial,get_Emagazine,get_ontact_US;
@synthesize get_Article_TITL,get_News_titl,get_Photo_titl,get_Video_titl;


-(void) viewDidAppear:(BOOL)animated
{
//    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self parse_URL];
    [self setup_VIEW];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.scroll_SCRN layoutIfNeeded];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - View Customise
-(void) setup_VIEW
{
    _overlay_VIW = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    CGRect new_FRAME1 = _overlay_VIW.frame;
    new_FRAME1.size.width = self.navigationController.navigationBar.frame.size.width;
    _overlay_VIW.frame = new_FRAME1;
    _overlay_VIW.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    _share_VW.center = _overlay_VIW.center;
    
    [_overlay_VIW addSubview:_share_VW];
    [self.navigationController.view addSubview:_overlay_VIW];
    
    _overlay_VIW.hidden = YES;
    
     NSLog(@"set up Get home = %@",get_home);
     NSLog(@"Nes titl = %@",get_News_titl);
    
    NSDictionary *temp_dictin = [json_DATA valueForKey:@"result"];
    NSDictionary *news = [temp_dictin valueForKey:@"News"];
    
    NSString *image_url = [NSString stringWithFormat:@"%@",[news valueForKey:@"image"]];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator startAnimating];
    [indicator setCenter:_big_IMAGE.center];
    [_profile_VW addSubview:indicator];
    
    NSString *url_STR = [NSString stringWithFormat:@"%@news/%@",IMAGE_URL,image_url];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSURL* url = [NSURL URLWithString: url_STR];
        
        // Load and decode image --
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        
        // Apply image on the main thread --
        dispatch_sync(dispatch_get_main_queue(), ^{
            [indicator removeFromSuperview];
            _big_IMAGE.image = image;
        });
    });
    
    _lbl_TIME.text = [NSString stringWithFormat:@"%@",[news valueForKey:@"release_time"]];
    _lbl_VIEWRS.text = [NSString stringWithFormat:@"%@",[news valueForKey:@"visitor"]];
    
    NSString *date_STR = [NSString stringWithFormat:@"%@",[temp_dictin valueForKey:@"dateformat"]];
    NSString *title_STR  = [NSString stringWithFormat:@"%@",[news valueForKey:@"title"]];
    NSString *tag = [NSString stringWithFormat:@"Tag : %@",[news valueForKey:@"tags"]];
    NSString *data = [NSString stringWithFormat:@"%@",[news valueForKey:@"content"]];
    
    NSString *HTM_DATA = [self convertHTML:data];
    
    
    NSString *dtail = [NSString stringWithFormat:@"%@\n\n %@\n\n %@\n\n",date_STR,title_STR,tag];
    dtail = [dtail stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
    NSString *test = [dtail stringByAppendingString:@"\t\n"];
    
    NSDictionary *attribs = @{
                              NSForegroundColorAttributeName: self.lbl_date_E.tintColor,
                              NSFontAttributeName: self.lbl_date_E.font
                              };
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString:test
                                           attributes:attribs];
    
    
    NSRange cmp = [dtail rangeOfString:date_STR];
    [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:14.0]}
                            range:cmp];
    
    NSRange titl = [dtail rangeOfString:title_STR];
    [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0],
                                    NSForegroundColorAttributeName : [UIColor colorWithRed:0.47 green:0.0 blue:0.25 alpha:1.0]}
                            range:titl];
    
    NSRange typ = [dtail rangeOfString:tag];
    [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:14.0]}
                            range:typ];
    
    
    self.lbl_date_E.numberOfLines = 0;
    self.lbl_date_E.attributedText = attributedText;
    //self.lbl_CNTNT.adjustsFontSizeToFitWidth = YES;
//    _lbl_CNTNT.textAlignment = NSTextAlignmentRight;
    [self.lbl_date_E sizeToFit];
    
    [_lbl_date_E setFrame:CGRectMake(8,_lbl_date_E.frame.origin.y,self.view.frame.size.width - 16,_lbl_date_E.frame.size.height )];
    
    //_lbl_CNTNT.scrollEnabled = NO;
    
//    [_lbl_CNTNT loadHTMLString:data baseURL:nil];
    [_lbl_CNTNT loadHTMLString:[NSString stringWithFormat:@"<div style='text-align:right'>%@<div>",HTM_DATA] baseURL:nil];
    
}
-(NSString *)convertHTML:(NSString *)html {
    NSScanner *myScanner;
    NSString *text = nil;
    myScanner = [NSScanner scannerWithString:html];
    while ([myScanner isAtEnd] == NO) {
        [myScanner scanUpToString:@"<" intoString:NULL] ;
        [myScanner scanUpToString:@">" intoString:&text] ;
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return html;
}

#pragma mark - button Actions
-(void) add_COMMENT_VC
{
    NSLog(@"Add comment tapped");
    
    Add_comment_VC *controller = [[Add_comment_VC alloc]initWithNibName:@"Add_comment_VC" bundle:nil];
    controller.get_ID1 = get_ID;
    controller.get_titl1 = get_titl;
    controller.get_Home = @"News Detail";
    controller.get_nav_STAT = @"Hide";
    [self.navigationController pushViewController:controller animated:YES];
}
-(void) read_ALL_comnt
{
    NSLog(@"Read all comment tapped %@",get_home);
    
//    if ([get_home isEqualToString:@"Home"]) {
//        Comments_VC *controller = [[Comments_VC alloc]initWithNibName:@"Comments_VC" bundle:nil];
//        controller.get_ID1 = get_ID;
//        controller.get_titl1 = get_titl;
//        controller.get_home = @"News Detail";
//        [self.navigationController pushViewController:controller animated:YES];
//        
//
//    }
//    else
//    {
        Comments_VC *controller = [[Comments_VC alloc]initWithNibName:@"Comments_VC" bundle:nil];
        controller.get_ID1 = get_ID;
        controller.get_titl1 = get_titl;
        controller.get_home = @"News Detail";
        [self.navigationController pushViewController:controller animated:YES];
//    }
}




/*- (CGSize)jsq_frameSizeForAttributedString:(NSAttributedString *)attributedString maxwidth:(CGFloat)width
{
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef)attributedString);
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), NULL, CGSizeMake(width, CGFLOAT_MAX), NULL);
    CFRelease(framesetter);
    
    CTTypesetterRef typesetter = CTTypesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
    CFIndex offset = 0, length;
    CGFloat y = 0;
    do {
        length = CTTypesetterSuggestLineBreak(typesetter, offset, width);
        CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(offset, length));
        
        CGFloat ascent, descent, leading;
        CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
        
        CFRelease(line);
        
        offset += length;
        y += ascent + descent + leading;
    } while (offset < [attributedString length]);
    
    CFRelease(typesetter);
    
    return CGSizeMake(suggestedSize.width, ceil(y));
}*/

#pragma mark - Button Action
-(IBAction)go_BACK:(id)sender
{
    self.navigationController.navigationBar.hidden = NO;
    
   /* NSLog(@"Nes titl = %@",get_News_titl);
    
    if (get_Emagazine)
    {
        E_magazine_VC *controller = [[E_magazine_VC alloc] initWithNibName:@"E_magazine_VC" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (get_Editorial)
    {
        Editorial_board_VC *controller = [[Editorial_board_VC alloc] initWithNibName:@"Editorial_board_VC" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (get_ontact_US)
    {
        ContactUS_VC *controller = [[ContactUS_VC alloc] initWithNibName:@"ContactUS_VC" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (get_Article)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"article_story" bundle:nil];
        Article_VC *menu_Home_VC = [storyboard instantiateViewControllerWithIdentifier:@"Article_VIEW"];
        menu_Home_VC.get_NAV_TITL = get_titl;
        [self.navigationController pushViewController:menu_Home_VC animated:NO];
    }
    else if (get_News_titl || [get_home isEqualToString:@"News Detail"])
    {
        News_local *controller = [[News_local alloc] initWithNibName:@"News_local" bundle:nil];
        controller.get_NAV_TITL = get_titl;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (get_Photo_titl)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"photoS" bundle:nil];
        photos_VC *menu_Home_VC = [storyboard instantiateViewControllerWithIdentifier:@"photos_VIEW"];
        menu_Home_VC.get_NAV_TITL = get_titl;
        [self.navigationController pushViewController:menu_Home_VC animated:NO];
    }
    else if (get_Video_titl)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"videoS" bundle:nil];
        Videos_VC *menu_Home_VC = [storyboard instantiateViewControllerWithIdentifier:@"videos_VIEW"];
        menu_Home_VC.get_NAV_TITL = get_titl;
        [self.navigationController pushViewController:menu_Home_VC animated:NO];
    }
    else if (get_home)
    {
        HomeController *controller = [[HomeController alloc] initWithNibName:@"HomeController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }*/
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)share_Action:(id)sender
{
    NSLog(@"Share action Tapped");
    _overlay_VIW.hidden = NO;
}

-(void) parse_URL
{
//    json_DATA
//    NSLog(@"Id from prev controller %@",get_ID);
    
    NSString *str_URL = [NSString stringWithFormat:@"%@newsContent/%@",MAIN_URL,get_ID];
    
//    NSLog(@"String Url = %@",str_URL);
    
    NSError *error;
    NSLog(@"str_URL = %@",str_URL);
    NSURL *url = [NSURL URLWithString:str_URL];
    NSData *aData = [NSData dataWithContentsOfURL:url];
    json_DATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
    
//    NSLog(@"Json Response news contents . - %@",json_DATA);
}

#pragma mark _ GEt diff Date
- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    return [difference day];
}

#pragma mark - UTC
-(NSString *)getUTCFormateDate:(NSDate *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    return dateString;
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
    CGRect frame = aWebView.frame;
    frame.size.height = 1;
    aWebView.frame = frame;
    CGSize fittingSize = [aWebView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    aWebView.frame = frame;
    
    NSLog(@"size: %f, %f", fittingSize.width, fittingSize.height);
    
    _add_COMMENT.layer.cornerRadius = 5.0f;
    
    _add_COMMENT.layer.masksToBounds = YES;
    _add_COMMENT.layer.borderWidth = 1.0f;
    _add_COMMENT.layer.borderColor = [UIColor colorWithRed:0.47 green:0.0 blue:0.25 alpha:1.0].CGColor;
    
    [_add_COMMENT addTarget:self action:@selector(add_COMMENT_VC) forControlEvents:UIControlEventTouchUpInside];
    
    [_hold_BTN addSubview:_add_COMMENT];
    
    
    
    _view_COMMENT.layer.cornerRadius = 5.0f;
    _view_COMMENT.layer.masksToBounds = YES;
    
    [_view_COMMENT addTarget:self action:@selector(read_ALL_comnt) forControlEvents:UIControlEventTouchUpInside];
    [_hold_BTN addSubview:_view_COMMENT];
    
    float exp_height = _lbl_date_E.frame.origin.y + _lbl_date_E.frame.size.height - 30;
    
    CGRect g_frame = _lbl_CNTNT.frame;
    g_frame.origin.y = exp_height;
    _lbl_CNTNT.frame = g_frame;
    
    _lbl_CNTNT.scrollView.scrollEnabled = NO;
    
    CGRect new_frame = self.lbl_CNTNT.frame;
    new_frame.size.height = self.lbl_CNTNT.frame.origin.y + fittingSize.height;
    
    CGRect content_frame = _coment_VW.frame;
    content_frame.origin.y = new_frame.size.height;
    
    NSLog(@"array value = %@",json_DATA);
    
    
    NSDictionary *new = [json_DATA valueForKey:@"result"];
    NewsComment = [new valueForKey:@"NewsComment"];
    
    
    //    _lbl_comnt_STAT.text = @"Com sdfsdof sdfdsf djbfd gdjfg dfgkjdfgCom sdfsdof sdfdsf djbfd gdjfg dfgkjdfgCom sdfsdof sdfdsf djbfd gdjfg dfgkjdfgCom sdfsdof sdfdsf djbfd gdjfg dfgkjdfgCom sdfsdof sdfdsf djbfd gdjfg dfgkjdfgCom sdfsdof sdfdsf djbfd gdjfg dfgkjdfg";
    
    
    if ([NewsComment count]== 0) {
//        _lbl_comnt_STAT.text = @"لم يذكر";
        _lbl_CMNT_date.hidden = YES;
        _lbl_CMNT_head.hidden = YES;
        _lbl_comnt_STAT.hidden = YES;
    }
    else
    {
        _lbl_comnt_STAT.text = [[NewsComment objectAtIndex:0]valueForKey:@"comment"];
    }
    
    
    _lbl_comnt_STAT.numberOfLines =0;
    //    _lbl_comnt_STAT.textAlignment = NSTextAlignmentLeft;
    [_lbl_comnt_STAT sizeToFit];
    [_lbl_comnt_STAT setFrame:CGRectMake(8,_lbl_comnt_STAT.frame.origin.y,self.view.frame.size.width - 16,_lbl_comnt_STAT.frame.size.height)];
    
    content_frame.size.height = _lbl_comnt_STAT.frame.origin.y + _lbl_comnt_STAT.frame.size.height + 20;
    
    _coment_VW.frame = content_frame;
    
    new_frame = _main_VW.frame;
    new_frame.origin.y = 20;
    new_frame.size.height = self.coment_VW.frame.origin.y + self.coment_VW.frame.size.height;
    
    _main_VW.frame = new_frame;
    
    [_main_VW addSubview:_coment_VW];
    
    
    
    CGRect newframe11 = _main_VW.frame;
    newframe11.size.height = _coment_VW.frame.origin.y + _coment_VW.frame.size.height;
    _main_VW.frame = newframe11;
    
    CGRect frame_new = _scroll_SCRN.frame;
    frame_new.origin.y = frame_new.origin.y - 20;
    _scroll_SCRN.frame = frame_new;
    
    
    [_scroll_SCRN addSubview:_main_VW];
    _scroll_SCRN.contentSize = _main_VW.frame.size;
}

-(IBAction)close_Action:(id)sender
{
    _overlay_VIW.hidden = YES;
}
-(IBAction)whatsAPP_Action:(id)sender
{
    NSString *str_URL = [NSString stringWithFormat:@"%@newsContent/%@",MAIN_URL,get_ID];
    if ([WhatsAppKit isWhatsAppInstalled]) {
        [WhatsAppKit launchWhatsAppWithMessage:str_URL];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Whatsapp Not installed" delegate:sender cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    _overlay_VIW.hidden = YES;
}
-(IBAction)FB_SHARE:(id)sender
{
    NSString *str_URL = [NSString stringWithFormat:@"%@newsContent/%@",MAIN_URL,get_ID];
    
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [controller setInitialText:str_URL];
    [self presentViewController:controller animated:YES completion:nil];
    
    _overlay_VIW.hidden = YES;
}

-(IBAction)Tweet_BTN:(id)sender
{
    NSString *str_URL = [NSString stringWithFormat:@"%@newsContent/%@",MAIN_URL,get_ID];
    
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [controller setInitialText:str_URL];
    [self presentViewController:controller animated:YES completion:nil];
    
    _overlay_VIW.hidden = YES;
}
-(IBAction)GooglPLS:(id)sender
{
    NSString *str_URL = [NSString stringWithFormat:@"%@newsContent/%@",MAIN_URL,get_ID];
    NSURL *share = [NSURL URLWithString:str_URL];
    NSURLComponents* urlComponents = [[NSURLComponents alloc]
                                      initWithString:@"https://plus.google.com/share"];
    urlComponents.queryItems = @[[[NSURLQueryItem alloc]
                                  initWithName:@"url"
                                  value:[share absoluteString]]];
    NSURL* url = [urlComponents URL];
    
    [[UIApplication sharedApplication] openURL:url];
    
    _overlay_VIW.hidden = YES;
}

@end
