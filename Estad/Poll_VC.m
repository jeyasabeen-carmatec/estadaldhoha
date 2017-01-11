//
//  Poll_VC.m
//  Estad
//
//  Created by Apple on 19/12/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import "Poll_VC.h"
#import "UIView+Toast.h"

@interface Poll_VC ()
{
    NSString *BTN_STAT,*id_STR;
}

@end

@implementation Poll_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.hidesBackButton = YES;
    [self Setup_VIEW];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - View Customisation
-(void) Setup_VIEW
{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.44 green:0.00 blue:0.24 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -30;
    
    
    UILabel *lbl_btn_srch = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    lbl_btn_srch.text = @"";
    lbl_btn_srch.font = [UIFont fontWithName:@"FontAwesome" size:21.0f];
    lbl_btn_srch.textColor = [UIColor whiteColor];
    UIButton *BTN_srch = [UIButton buttonWithType:UIButtonTypeCustom];
    [BTN_srch addSubview:lbl_btn_srch];
    BTN_srch.frame = CGRectMake(0, 0, 40, 40);
    [BTN_srch addTarget:self action:@selector(Back_ACTN) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar_btn_srch = [[UIBarButtonItem alloc]initWithCustomView:BTN_srch];
    
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:bar_btn_srch,Nil]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    // ^-Use UITextAlignmentCenter for older SDKs.
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"صندوق الاقتراع", @"");
    [label sizeToFit];
    self.navigationItem.titleView = label;
    
    [self API_Question];
    NSString *stat = [[NSUserDefaults standardUserDefaults]valueForKey:@"IDSTR"];
    
    if ([stat isEqualToString:id_STR])
    {
        NSLog(@"Id is %@",stat);
        [self result_API];
    }
    else
    {
        _VW_YES.layer.cornerRadius = 8.5;
        _VW_YES.layer.masksToBounds = YES;
        _VW_YES.layer.borderColor = [UIColor colorWithRed:0.894 green:0.894 blue:0.894 alpha:1].CGColor;
        _VW_YES.layer.borderWidth = 1.5f;
        
        _VW_YES_SUB.layer.backgroundColor = [UIColor colorWithRed:0.737 green:0.596 blue:0.09 alpha:1].CGColor;
        _VW_YES_SUB.layer.cornerRadius = 6.5;
        _VW_YES_SUB.layer.masksToBounds = YES;
        _VW_YES_SUB.layer.borderColor = [UIColor whiteColor].CGColor;
        _VW_YES_SUB.layer.borderWidth = 1.5f;
        
        
        _VW_NO.layer.cornerRadius = 8.5;
        _VW_NO.layer.masksToBounds = YES;
        _VW_NO.layer.borderColor = [UIColor colorWithRed:0.894 green:0.894 blue:0.894 alpha:1].CGColor;
        _VW_NO.layer.borderWidth = 1.5f;
        
        _VW_NO_SUB.layer.backgroundColor = [UIColor colorWithRed:0.737 green:0.596 blue:0.09 alpha:1].CGColor;
        _VW_NO_SUB.layer.cornerRadius = 6.5;
        _VW_NO_SUB.layer.masksToBounds = YES;
        _VW_NO_SUB.layer.borderColor = [UIColor whiteColor].CGColor;
        _VW_NO_SUB.layer.borderWidth = 1.5f;
        
        
        _lbl_Yes.hidden = YES;
        _lbl_NO.hidden = YES;
        
        _lbl_side_Y.hidden = YES;
        _lbl_side_N.hidden = YES;
        
        _VW_PER_S.hidden = YES;
        _VW_PER_N.hidden = YES;
        
        _btn_SUBMIT.layer.cornerRadius = 5.0f;
        _btn_SUBMIT.layer.masksToBounds = YES;
        
        [_btn_SUBMIT addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    }
}
#pragma mark - SUMIT ACTION
-(void) submit
{
    NSLog(@"Submit tapped");
    
    if (!BTN_STAT)
    {
        [self.navigationController.view makeToast:@"Please Select one Option"
                                         duration:2.0
                                         position:CSToastPositionBottom];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:id_STR forKey:@"IDSTR"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self result_API];
    }
}

-(void)result_API
{
    _btn_SUBMIT.hidden = YES;
    _lbl_OPTN_YS.hidden = YES;
    _lbl_OPTN_NO.hidden = YES;
    _lbl_OPTN_til.hidden = YES;
    _VW_NO.hidden = YES;
    _VW_YES.hidden = YES;
    
    if (!id_STR)
    {
        id_STR = [[NSUserDefaults standardUserDefaults]valueForKey:@"IDSTR"];
    }
    
    NSError *error;
    NSString *str_URL = [NSString stringWithFormat:@"%@pollSubmit/%@/%@",MAIN_URL,id_STR,BTN_STAT];
    NSLog(@"Url string = %@",str_URL);
    
    NSData *aDATA = [NSData dataWithContentsOfURL:[NSURL URLWithString:str_URL]];
    
    if (aDATA)
    {
        NSMutableDictionary *jsonDATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aDATA options:NSASCIIStringEncoding error:&error];
        NSLog(@"Api response Question = %@",jsonDATA);
        
        NSDictionary *result = [jsonDATA valueForKey:@"result"];
        NSString *yes = [result valueForKey:@"yes"];
        NSString *st_NO = [result valueForKey:@"no"];
        
        _lbl_Yes.hidden = NO;
        _lbl_NO.hidden = NO;
        
        _lbl_side_Y.hidden = NO;
        _lbl_side_N.hidden = NO;
        
        _VW_PER_S.hidden = NO;
        _VW_PER_N.hidden = NO;
        
        
        float percent = [yes floatValue];//10.0;
        float newWIDTH = percent * 2.5f;
        float difference = newWIDTH - 250;
        float newX = _VW_PER_S.frame.origin.x - difference;
        
        CGRect frame1 = _VW_PER_S.frame;
        frame1.origin.x = newX;
        frame1.size.width = newWIDTH;
        
        _VW_PER_S.frame = frame1;
        
        CGRect lbl_FRAME = _lbl_Yes.frame;
        lbl_FRAME.origin.x = _VW_PER_S.frame.origin.x - _lbl_Yes.frame.size.width - 3;
        _lbl_Yes.frame = lbl_FRAME;
        
//        NSString *lbl_TXT = [[NSString stringWithFormat:@"%.2f", percent] floatValue];
        _lbl_Yes.text = [NSString stringWithFormat:@"%.02f", percent];
        
        float percent1 = [st_NO floatValue];//10.0;
        float newWIDTH1 = percent1 * 2.5f;
        float difference1 = newWIDTH1 - 250;
        float newX1 = _VW_PER_N.frame.origin.x - difference1;
        
        CGRect frame11 = _VW_PER_N.frame;
        frame11.origin.x = newX1;
        frame11.size.width = newWIDTH1;
        
        _VW_PER_N.frame = frame11;
        
        CGRect lbl_FRAME1 = _lbl_NO.frame;
        lbl_FRAME1.origin.x = _VW_PER_N.frame.origin.x - _lbl_NO.frame.size.width - 3;
        _lbl_NO.frame = lbl_FRAME1;
        
        _lbl_NO.text = [NSString stringWithFormat:@"%.02f", percent1];
        
    }
}


-(void) Back_ACTN
{
    [[self navigationController]popViewControllerAnimated:NO];
}

#pragma mark - BUTTON YES/NO
-(IBAction)BTN_YES:(id)sender
{
    _VW_YES.layer.cornerRadius = 8.5;
    _VW_YES.layer.masksToBounds = YES;
    _VW_YES.layer.borderColor = [UIColor colorWithRed:0.894 green:0.894 blue:0.894 alpha:1].CGColor;
    _VW_YES.layer.borderWidth = 1.5f;
    
    _VW_YES_SUB.layer.backgroundColor = [UIColor colorWithRed:0.737 green:0.596 blue:0.09 alpha:1].CGColor;
    _VW_YES_SUB.layer.cornerRadius = 6.5;
    _VW_YES_SUB.layer.masksToBounds = YES;
    _VW_YES_SUB.layer.borderColor = [UIColor whiteColor].CGColor;
    _VW_YES_SUB.layer.borderWidth = 1.5f;
    
    _VW_NO.layer.cornerRadius = 8.5;
    _VW_NO.layer.masksToBounds = YES;
    _VW_NO.layer.borderColor = [UIColor colorWithRed:0.894 green:0.894 blue:0.894 alpha:1].CGColor;
    _VW_NO.layer.borderWidth = 1.5f;
    
    _VW_NO_SUB.layer.backgroundColor = [UIColor colorWithRed:0.33 green:1.00 blue:0.10 alpha:1.0].CGColor;
    _VW_NO_SUB.layer.cornerRadius = 6.5;
    _VW_NO_SUB.layer.masksToBounds = YES;
    _VW_NO_SUB.layer.borderColor = [UIColor whiteColor].CGColor;
    _VW_NO_SUB.layer.borderWidth = 1.5f;
    
    BTN_STAT = @"no";
    
    NSLog(@"NO Tapped");
}
-(IBAction)BTN_NO:(id)sender
{
    _VW_NO.layer.cornerRadius = 8.5;
    _VW_NO.layer.masksToBounds = YES;
    _VW_NO.layer.borderColor = [UIColor colorWithRed:0.894 green:0.894 blue:0.894 alpha:1].CGColor;
    _VW_NO.layer.borderWidth = 1.5f;
    
    _VW_NO_SUB.layer.backgroundColor = [UIColor colorWithRed:0.737 green:0.596 blue:0.09 alpha:1].CGColor;
    _VW_NO_SUB.layer.cornerRadius = 6.5;
    _VW_NO_SUB.layer.masksToBounds = YES;
    _VW_NO_SUB.layer.borderColor = [UIColor whiteColor].CGColor;
    _VW_NO_SUB.layer.borderWidth = 1.5f;
    
    
    _VW_YES.layer.cornerRadius = 8.5;
    _VW_YES.layer.masksToBounds = YES;
    _VW_YES.layer.borderColor = [UIColor colorWithRed:0.894 green:0.894 blue:0.894 alpha:1].CGColor;
    _VW_YES.layer.borderWidth = 1.5f;
    
    _VW_YES_SUB.layer.backgroundColor = [UIColor colorWithRed:0.33 green:1.00 blue:0.10 alpha:1.0].CGColor;
    _VW_YES_SUB.layer.cornerRadius = 6.5;
    _VW_YES_SUB.layer.masksToBounds = YES;
    _VW_YES_SUB.layer.borderColor = [UIColor whiteColor].CGColor;
    _VW_YES_SUB.layer.borderWidth = 1.5f;
    
    BTN_STAT = @"yes";
    
    NSLog(@"YES Tapped");
}

#pragma mark - GEt QUESTION
-(void) API_Question
{
    NSError *error = nil;
    NSString *url_STR = [NSString stringWithFormat:@"%@pollQuestions",MAIN_URL];
    NSLog(@"url = %@",url_STR);
    
    NSData *aDATA = [NSData dataWithContentsOfURL:[NSURL URLWithString:url_STR]];
    
    if (aDATA)
    {
        NSMutableDictionary *jsonDATA = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aDATA options:NSASCIIStringEncoding error:&error];
        NSLog(@"Api response Question = %@",jsonDATA);
        
        NSDictionary *temp = [jsonDATA valueForKey:@"result"];
        NSDictionary *result = [temp valueForKey:@"Poll"];
        id_STR = [result valueForKey:@"id"];
        _lbl_QSTN.text = [result valueForKey:@"question"];
        _lbl_QSTN.numberOfLines = 0;
    }
    else
    {
        _lbl_QSTN.text = @"Not Mentioned";
    }
}

@end
