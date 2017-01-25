//
//  New_Home_VC.m
//  Estad
//
//  Created by Apple on 11/01/17.
//  Copyright © 2017 carmatec. All rights reserved.
//

#import "New_Home_VC.h"
#import "News_CELL.h"
#import "articles_CELL.h"
#import "media_CELL.h"
#import "News_local.h"
#import "Article_VC.h"
#import "photos_VC.h"
#import "Videos_VC.h"
#import "ContactUS_VC.h"
#import "Editorial_board_VC.h"
#import "E_magazine_VC.h"
#import "serch_CELL.h"
#import "NEWS_datail_VC.h"
#import "Report_DETAIL_VC.h"
#import "Interview_DETAIL.h"
#import "Article_DETAIL_VC.h"
#import "About_US_VC.h"
#import "sEttings_VC.h"

#pragma mark - NEWS Cells
#import "BIG_CELL_NEWS.h"
#import "Small_CEL_NWS.h"
#import "LCL_NWS_2.h"

#pragma mark - Image Cache
#import "SDWebImage/UIImageView+WebCache.h"

@interface New_Home_VC ()

@end

@implementation New_Home_VC
{
    NSArray *list_NEWS1;
    NSArray *list_ARTICLES;
    NSArray *list_MEDIA;
    NSString *send_news_TITL;
    
    NSDictionary *contents,*whether;
    
    NSMutableArray *ID_STR,*ID_model,*ID_nmae;
    
    NSMutableArray *searchResults;
    BOOL isSerching;
    
    NSArray *homeNewsSlider,*arabnews,*localNews,*interview,*reports;
    
    NSTimer *timer;
    NSInteger count;
    NSInteger seconds;
}

@synthesize menuDraw_width,menyDraw_X,VW_swipe;

-(void)viewWillAppear:(BOOL)animated
{
    _VW_Serch_BAR.hidden = YES;
    [searchResults removeAllObjects];
    [_list_DATA reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    list_NEWS1 = [[NSArray alloc]initWithObjects:@"أخبار الدوريات المحلية",@"الدوريات الأخبار العربية",@"أخبار الدوريات العالمية",@"كل الأخبار", @"قطر 2022", @"أسباير زون", nil];
    list_ARTICLES = [[NSArray alloc]initWithObjects:@"محرر بلوق",@"مقالات استاد الدوحة", nil];
    list_MEDIA = [[NSArray alloc]initWithObjects:@"صور" ,@"فيديوهات", nil];
    
    myCollapseClick.CollapseClickDelegate = self;
    [myCollapseClick reloadCollapseClick];
    
    [self API_Home_page];
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

#pragma mark - API Integration
-(void) API_Home_page
{
    NSString *dev_TOK = [[NSUserDefaults standardUserDefaults]valueForKey:@"DEV_TOK"];
    if (dev_TOK)
    {
        [self send_TOK];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(tokenAvailableNotification:)
                                                     name:@"NEW_TOKEN_AVAILABLE"
                                                   object:nil];
    }
    
    NSError *error;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@homePage_new",MAIN_URL]];
    NSData *aData = [NSData dataWithContentsOfURL:url];
    
    if (aData) {
        contents = [NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSLog(@"Home page NEw %@",contents);
        [self setup_VIEW];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please chek internet connection settings" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        [self API_Home_page];
    }
}

#pragma mark - Register Push Notification
- (void)tokenAvailableNotification:(NSNotification *)notification {
    NSString *token = (NSString *)notification.object;
    NSLog(@"new token available : %@", token);
    NSError *error;
    NSString *URL_STR = [NSString stringWithFormat:@"http://192.168.0.116/estad/Apis/registerPush"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *post = [NSString stringWithFormat:@"token=%@&type=%@",token,@"ios"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    [request setURL:[NSURL URLWithString:URL_STR]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSLog(@"Datas Posted == %@",post);
    
    NSURLResponse *response;
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (aData)
    {
        NSMutableDictionary *push = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSLog(@"OUT Json Push register %@",push);
    }
}

-(void) send_TOK
{
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"DEV_TOK"];
    NSLog(@"new token available : %@", token);
    NSError *error;
    NSString *URL_STR = [NSString stringWithFormat:@"http://192.168.0.116/estad/Apis/registerPush"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *post = [NSString stringWithFormat:@"token=%@&type=%@",token,@"ios"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    [request setURL:[NSURL URLWithString:URL_STR]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSLog(@"Datas Posted == %@",post);
    
    NSURLResponse *response;
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (aData)
    {
        NSMutableDictionary *push = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSLog(@"OUT Json Push register %@",push);
        
    }
}


#pragma mark - View Customisation
-(void) setup_VIEW
{
    //    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.44 green:0.00 blue:0.24 alpha:1.0]];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.44 green:0.00 blue:0.24 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    // ^-Use UITextAlignmentCenter for older SDKs.
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"الرئيسية", @"");
    [label sizeToFit];
    self.navigationItem.titleView = label;
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -30;
    
    UILabel *lbl_Lbtn1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    lbl_Lbtn1.text = @"";
    lbl_Lbtn1.font = [UIFont fontWithName:@"FontAwesome" size:21.0f];
    lbl_Lbtn1.textColor = [UIColor whiteColor];
    UIButton *BTN_more = [UIButton buttonWithType:UIButtonTypeCustom];
    [BTN_more addSubview:lbl_Lbtn1];
    BTN_more.frame = CGRectMake(0, 0, 40, 40);
    [BTN_more addTarget:self action:@selector(more_ACTION) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar_SYNC = [[UIBarButtonItem alloc] initWithCustomView:BTN_more];
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer,bar_SYNC,Nil]];
    
    UILabel *lbl_btn_srch = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    lbl_btn_srch.text = @"";
    lbl_btn_srch.font = [UIFont fontWithName:@"FontAwesome" size:21.0f];
    lbl_btn_srch.textColor = [UIColor whiteColor];
    UIButton *BTN_srch = [UIButton buttonWithType:UIButtonTypeCustom];
    [BTN_srch addSubview:lbl_btn_srch];
    BTN_srch.frame = CGRectMake(0, 0, 40, 40);
    [BTN_srch addTarget:self action:@selector(SERCH_action) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar_btn_srch = [[UIBarButtonItem alloc]initWithCustomView:BTN_srch];
    
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:bar_btn_srch,Nil]];
    
    int statusbar_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
    self.navigationController.navigationBar.frame = CGRectMake(0,statusbar_HEIGHT,self.navigationController.navigationBar.frame.size.width,self.navigationController.navigationBar.frame.size.height);
    
    
    [_scroll_contNT addSubview:_VW_Contents];
    
    statusbar_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
    menuDraw_width = [UIApplication sharedApplication].statusBarFrame.size.width * 0.80;
    menyDraw_X = self.navigationController.view.frame.size.width; //- menuDraw_width;
    VW_swipe.frame = CGRectMake(self.navigationController.view.frame.size.width, self.view.frame.origin.y + statusbar_HEIGHT, menuDraw_width, self.navigationController.view.frame.size.height);
    
    //    VW_swipe.backgroundColor = [UIColor colorWithRed:0.47 green:0.00 blue:0.25 alpha:1.0];
    //    [self.navigationController.view addSubview:VW_swipe];
    
    _overlayView = [[UIView alloc] initWithFrame:self.navigationController.view.frame];
    _overlayView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    [self.navigationController.view addSubview:_overlayView];
    
    [_overlayView addSubview:VW_swipe];
    _overlayView.hidden = YES;
    
    UISwipeGestureRecognizer *SwipeLEFT = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeRecognizer:)];
    SwipeLEFT.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:SwipeLEFT];
    //    [_overlayView addGestureRecognizer:SwipeLEFT];
    
    UISwipeGestureRecognizer *SwipeRIGHT = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeRight:)];
    SwipeRIGHT.direction = UISwipeGestureRecognizerDirectionRight;
    //    [self.view addGestureRecognizer:SwipeRIGHT];
    [_overlayView addGestureRecognizer:SwipeRIGHT];
    
    
    
    _VW_Serch_BAR = [[UIView alloc] initWithFrame:self.navigationController.view.frame];
    _VW_Serch_BAR.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    [self.navigationController.view addSubview:_VW_Serch_BAR];
    
    CGRect new_FRAME = _VW_Serch.frame;
    new_FRAME.origin.y = 20;
    new_FRAME.size.width = self.navigationController.navigationBar.frame.size.width;
    
    _VW_Serch.frame = new_FRAME;
    
    new_FRAME = _list_DATA.frame;
    new_FRAME.origin.y = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height;
    new_FRAME.size.width = self.navigationController.navigationBar.frame.size.width;
    _list_DATA.frame = new_FRAME;
    
    [_VW_Serch_BAR addSubview:_VW_Serch];
    [_VW_Serch_BAR addSubview:_list_DATA];
    _VW_Serch_BAR.hidden = YES;
    
    _VW_activity = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    CGRect new_FRAME1 = _VW_activity.frame;
    new_FRAME1.size.width = self.navigationController.navigationBar.frame.size.width;
    _VW_activity.frame = new_FRAME1;
    _VW_activity.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    _activityindicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityindicator.center = _VW_activity.center;
    [_VW_activity addSubview:_activityindicator];
    [self.navigationController.view addSubview:_VW_activity];
    
    //    _VW_activity.hidden = YES;
    
    _widget_VW.delegate = self;
    _widget_VW.scrollView.delegate = self;
    
    //    [_widget_VW loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://widgets.datasportsgroup.com/carmatec/today_carmatec.php"]]];
    [_widget_VW loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://widgets.datasportsgroup.com/carmatec/today_carmatec_mobile.php"]]];
//    _widget_VW.scalesPageToFit = YES;
    _widget_VW.opaque = NO;
    _widget_VW.contentMode = UIViewContentModeScaleAspectFit;
    _widget_VW.backgroundColor = [UIColor colorWithRed:0.11 green:0.24 blue:0.50 alpha:1.0];
    
    GADRequest *request = [GADRequest request];
    //                    request.testDevices = @[@"b53627777feeb4f1d2d61a350a80514f"];
    _Ads_banner.adUnitID = @"ca-app-pub-8762774270996921/9236537494";
    _Ads_banner.rootViewController = self;
    [_Ads_banner loadRequest:request];
}

#pragma mark - LOAD DATA
-(void) setup_DATA
{
    [self viewDidLayoutSubviews];
    
    if (contents) {
        homeNewsSlider = [contents valueForKey:@"homeNewsSlider"];
        arabnews = [contents valueForKey:@"arabnews"];
        localNews = [contents valueForKey:@"localNews"];
        interview = [contents valueForKey:@"interview"];
        reports = [contents valueForKey:@"reports"];
        
        [_list_NEWS reloadData];
        [_list_arbNWS reloadData];
        [_list_localNWS reloadData];
        [_list_intrVW reloadData];
        [_list_reports reloadData];
    }
    
    
    
    CGRect main_FRAME = _VW_Contents.frame;
//    CGRect buffer_FRAME = _widget_VW.frame;
    CGRect temp_FRAME = _widget_VW.frame;
    temp_FRAME.size.height = _widget_VW.frame.size.height;
    _widget_VW.frame = temp_FRAME;
    
    temp_FRAME = _list_NEWS.frame;
    temp_FRAME.origin.y = _widget_VW.frame.origin.y + _widget_VW.frame.size.height + 5;
    temp_FRAME.size.height = [self tableViewHeight];
    _list_NEWS.frame = temp_FRAME;
    
    temp_FRAME = _list_arbNWS.frame;
    temp_FRAME.origin.y = _list_NEWS.frame.origin.y + [self tableViewHeight] + 5;
    temp_FRAME.size.height = [self tableViewHeight1];
    _list_arbNWS.frame = temp_FRAME;
    
    temp_FRAME = _list_localNWS.frame;
    temp_FRAME.origin.y = _list_arbNWS.frame.origin.y + [self tableViewHeight1] + 5;
    temp_FRAME.size.height = [self tableViewHeight2];
    _list_localNWS.frame = temp_FRAME;
    
    temp_FRAME = _list_intrVW.frame;
    temp_FRAME.origin.y = _list_localNWS.frame.origin.y + [self tableViewHeight2] + 5;
    temp_FRAME.size.height = [self tableViewHeight3];
    _list_intrVW.frame = temp_FRAME;
    
    temp_FRAME = _list_reports.frame;
    temp_FRAME.origin.y = _list_intrVW.frame.origin.y + [self tableViewHeight3] + 5;
    temp_FRAME.size.height = [self tableViewHeight4];
    _list_reports.frame = temp_FRAME;
    
    temp_FRAME = _Ads_banner.frame;
    temp_FRAME.origin.y = _list_reports.frame.origin.y + [self tableViewHeight4] + 5;
    temp_FRAME.size.height = _Ads_banner.frame.size.height;
    _Ads_banner.frame = temp_FRAME;
    
    main_FRAME.size.height = _Ads_banner.frame.origin.y + _Ads_banner.frame.size.height + 5;
    _VW_Contents.frame = main_FRAME;
//    _scroll_contNT.frame = _VW_Contents.frame;
    _scroll_contNT.contentSize = _VW_Contents.frame.size;
    
    [_activityindicator stopAnimating];
    _VW_activity.hidden = YES;
}

- (CGFloat)tableViewHeight
{
    [_list_NEWS layoutIfNeeded];
    return [_list_NEWS contentSize].height;
}
- (CGFloat)tableViewHeight1
{
    [_list_arbNWS layoutIfNeeded];
    return [_list_arbNWS contentSize].height;
}
- (CGFloat)tableViewHeight2
{
    [_list_localNWS layoutIfNeeded];
    return [_list_localNWS contentSize].height;
}
- (CGFloat)tableViewHeight3
{
    [_list_intrVW layoutIfNeeded];
    return [_list_intrVW contentSize].height;
}
- (CGFloat)tableViewHeight4
{
    [_list_reports layoutIfNeeded];
    return [_list_reports contentSize].height;
}

#pragma mark - MOre action
-(void) more_ACTION
{
    _overlayView.hidden = NO;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:-5];
    
    CGFloat new_X = 0;
    if (VW_swipe.frame.origin.x < self.view.frame.origin.x)
    {
        new_X = VW_swipe.frame.origin.x + menuDraw_width;
        //                self.navigationController.navigationBar.hidden = YES;
        //        self.navigationController.navigationBar.frame = CGRectMake(0,statusBarFrame1.size.height,VW_swipe.frame.size.width,self.navigationController.navigationBar.frame.size.height);
        
        
        
        
        //        self.content_view.frame = CGRectMake(menu_DRAW.frame.size.width,0,self.view.frame.size.width,self.view.frame.size.height);
    }
    else
    {
        new_X = VW_swipe.frame.origin.x - menuDraw_width;
        //        self.navigationController.navigationBar.hidden = NO;
        //        self.navigationController.navigationBar.frame = CGRectMake(0,statusBarFrame1.size.height,self.navigationController.navigationBar.frame.size.width,self.navigationController.navigationBar.frame.size.height);
        //        self.content_view.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    }
    VW_swipe.frame = CGRectMake(new_X, VW_swipe.frame.origin.y, menuDraw_width, self.view.frame.size.height + self.navigationController.navigationBar.frame.size.height);
    [UIView commitAnimations];
}


#pragma mark - Search Actions
-(void) SERCH_action
{
    NSLog(@"Search tapped");
    _VW_Serch_BAR.hidden = NO;
    [self searcH_API];
}
#pragma mark - Search API
-(void) searcH_API
{
    NSError *error = nil;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@search",MAIN_URL]];
    NSData *aData = [NSData dataWithContentsOfURL:url];
    NSMutableDictionary *json_Response = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
    
    NSLog(@"The out response = %@",json_Response);
    
    NSArray *store_IDS = [json_Response valueForKey:@"search"];
    
    ID_STR = [[NSMutableArray alloc] init];
    ID_model = [[NSMutableArray alloc] init];
    ID_nmae = [[NSMutableArray alloc] init];
    searchResults = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [store_IDS count]; i++)
    {
        NSDictionary *temp = [store_IDS objectAtIndex:i];
        [ID_STR addObject:[temp valueForKey:@"id"]];
        [ID_model addObject:[temp valueForKey:@"model_name"]];
        [ID_nmae addObject:[temp valueForKey:@"name"]];
    }
}

#pragma mark - Serch Logic
- (void)searchTableList {
    NSString *searchString = _serch_BAR.text;
    for (NSString *tempStr in ID_nmae) {
        NSComparisonResult result;
        @try {
            result = [tempStr compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
            if (result == NSOrderedSame) {
                [searchResults addObject:tempStr];
            }
        } @catch (NSException *exception) {
            [searchResults removeAllObjects];
            [_list_DATA reloadData];
        }
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark - Search bar deligate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isSerching = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"Text change - %d",isSerching);
    
    //Remove all objects first.
    [searchResults removeAllObjects];
    
    if([searchText length] != 0) {
        isSerching = YES;
        [self searchTableList];
    }
    else {
        isSerching = NO;
    }
    [_list_DATA reloadData];
}

-(IBAction)BTN_close_SRCHT:(id)sender
{
    [_serch_BAR resignFirstResponder];
    _VW_Serch_BAR.hidden = YES;
}

#pragma mark - Collapse Click Delegate
// Required Methods
-(int)numberOfCellsForCollapseClick {
    return 9;
}

-(NSString *)titleForCollapseClickAtIndex:(int)index {
    switch (index) {
        case 0:
            return @"الرئيسية";
            break;
            
        case 1:
            return @"الجريدة PDF";
            break;
            
        case 2:
            return @"أخبار";
            break;
        case 3:
            return @"مقالات";
            break;
        case 4:
            return @"المركز الاعلامي";
            break;
        case 5:
            return @"من نحن";
            break;
        case 6:
            return @"اتصل بنا";
            break;
        case 7:
            return @"مجلس التحرير";
            break;
        case 8:
            return @"إعدادات";
            break;
            
        default:
            return @"";
            break;
    }
}
//test8View
-(UIView *)viewForCollapseClickContentViewAtIndex:(int)index {
    switch (index) {
        case 0:
            return VW_Home;
            break;
        case 1:
            return VW_Emagazine;
            break;
        case 2:
            return VW_News;
            break;
        case 3:
            return VW_Articles;
            break;
        case 4:
            return VW_Media;
            break;
        case 5:
            return VW_About_US;
            break;
        case 6:
            return VW_Contact_US;
            break;
        case 7:
            return VW_Editorial;
            break;
        case 8:
            return VW_Settings;
            break;
            
        default:
            return VW_Settings;
            break;
    }
}


// Optional Methods

-(UIColor *)colorForCollapseClickTitleViewAtIndex:(int)index {
    return [UIColor colorWithRed:0.91 green:0.90 blue:0.93 alpha:1.0];
}

-(UIColor *)colorForTitleLabelAtIndex:(int)index {
    return [UIColor colorWithRed:0.27 green:0.21 blue:0.36 alpha:1.0];
}

-(UIColor *)colorForTitleArrowAtIndex:(int)index {
    return [UIColor clearColor];
}

-(void)didClickCollapseClickCellAtIndex:(int)index isNowOpen:(BOOL)open
{
    NSLog(@"%d and it's open:%@", index, (open ? @"YES" : @"NO"));
    [_tbl_NEWS reloadData];
    [_tbl_ARTICLES reloadData];
    [_tbl_MEDIA reloadData];
    if (index == 0) {
        NSLog(@"Index 0");
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:-5];
        
        int statusbar_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
        statusbar_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
        VW_swipe.frame = CGRectMake(self.navigationController.view.frame.size.width, self.navigationController.view.frame.origin.y + statusbar_HEIGHT, menuDraw_width, self.navigationController.view.frame.size.height);
        
        [UIView commitAnimations];
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:-5];
        _overlayView.hidden = YES;
        [UIView commitAnimations];
    }
    else if (index == 1)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:-5];
        
        int statusbar_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
        statusbar_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
        VW_swipe.frame = CGRectMake(self.navigationController.view.frame.size.width, self.navigationController.view.frame.origin.y + statusbar_HEIGHT, menuDraw_width, self.navigationController.view.frame.size.height);
        
        [UIView commitAnimations];
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:-5];
        _overlayView.hidden = YES;
        [UIView commitAnimations];
        
        _VW_activity.hidden = NO;
        [_activityindicator startAnimating];
        [self performSelector:@selector(E_magazene_VC) withObject:_activityindicator afterDelay:0.01];
        //        [self E_magazene_VC];
    }
    else if (index == 5)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:-5];
        
        int statusbar_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
        statusbar_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
        VW_swipe.frame = CGRectMake(self.navigationController.view.frame.size.width, self.navigationController.view.frame.origin.y + statusbar_HEIGHT, menuDraw_width, self.navigationController.view.frame.size.height);
        
        [UIView commitAnimations];
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:-5];
        _overlayView.hidden = YES;
        [UIView commitAnimations];
        
        
        _VW_activity.hidden = NO;
        [_activityindicator startAnimating];
        [self performSelector:@selector(About_US_VC_LC) withObject:_activityindicator afterDelay:0.01];
        
    }
    else if (index == 6)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:-5];
        
        int statusbar_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
        statusbar_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
        VW_swipe.frame = CGRectMake(self.navigationController.view.frame.size.width, self.navigationController.view.frame.origin.y + statusbar_HEIGHT, menuDraw_width, self.navigationController.view.frame.size.height);
        
        [UIView commitAnimations];
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:-5];
        _overlayView.hidden = YES;
        [UIView commitAnimations];
        
        _VW_activity.hidden = NO;
        [_activityindicator startAnimating];
        [self performSelector:@selector(Contact_US_PG) withObject:_activityindicator afterDelay:0.01];
        
    }
    else if (index == 7)
    {
        //        Editorial_board_VC
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:-5];
        
        int statusbar_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
        statusbar_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
        VW_swipe.frame = CGRectMake(self.navigationController.view.frame.size.width, self.navigationController.view.frame.origin.y + statusbar_HEIGHT, menuDraw_width, self.navigationController.view.frame.size.height);
        
        [UIView commitAnimations];
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:-5];
        _overlayView.hidden = YES;
        [UIView commitAnimations];
        
        _VW_activity.hidden = NO;
        [_activityindicator startAnimating];
        [self performSelector:@selector(Editorial_FFF) withObject:_activityindicator afterDelay:0.01];
        
        
    }
    else if (index == 8)
    {
        //        Editorial_board_VC
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:-5];
        
        int statusbar_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
        statusbar_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
        VW_swipe.frame = CGRectMake(self.navigationController.view.frame.size.width, self.navigationController.view.frame.origin.y + statusbar_HEIGHT, menuDraw_width, self.navigationController.view.frame.size.height);
        
        [UIView commitAnimations];
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:-5];
        _overlayView.hidden = YES;
        [UIView commitAnimations];
        
        _VW_activity.hidden = NO;
        [_activityindicator startAnimating];
        [self performSelector:@selector(load_Settings) withObject:_activityindicator afterDelay:0.01];
        
        
    }
}

-(void) load_Settings
{
    sEttings_VC *controller = [[sEttings_VC alloc] initWithNibName:@"sEttings_VC" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
    
    _VW_activity.hidden = YES;
    [_activityindicator stopAnimating];
}

-(void) E_magazene_VC
{
    E_magazine_VC *controller = [[E_magazine_VC alloc] initWithNibName:@"E_magazine_VC" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
    
    _VW_activity.hidden = YES;
    [_activityindicator stopAnimating];
}

-(void) About_US_VC_LC
{
    About_US_VC *controller = [[About_US_VC alloc] initWithNibName:@"About_US_VC" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
    
    _VW_activity.hidden = YES;
    [_activityindicator stopAnimating];
}

-(void) Contact_US_PG
{
    ContactUS_VC *controller = [[ContactUS_VC alloc] initWithNibName:@"ContactUS_VC" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
    
    _VW_activity.hidden = YES;
    [_activityindicator stopAnimating];
}

-(void) Editorial_FFF
{
    Editorial_board_VC *controller = [[Editorial_board_VC alloc] initWithNibName:@"Editorial_board_VC" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
    
    _VW_activity.hidden = YES;
    [_activityindicator stopAnimating];
}

#pragma mark - Tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tbl_NEWS) {
        return [list_NEWS1 count];
    }
    else if (tableView == _tbl_ARTICLES)
    {
        return [list_ARTICLES count];
    }
    else if (tableView == _tbl_MEDIA)
    {
        return [list_MEDIA count];
    }
    else if (tableView == _list_DATA)
    {
        return [searchResults count];
    }
    else if (tableView == _list_NEWS)
    {
        return [homeNewsSlider count];
    }
    else if (tableView == _list_arbNWS)
    {
        return [arabnews count];
    }
    else if (tableView == _list_localNWS)
    {
        return 1;
    }
    else if (tableView == _list_intrVW)
    {
        return [interview count];
    }
    else if (tableView == _list_reports)
    {
        if ([reports count] > 5)
        {
            return 5;
        }
        else
        {
            return [reports count];
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //articles_CELL
    if (tableView == _tbl_NEWS)
    {
        static NSString *simpleTableIdentifier = @"SimpleTableCell";
        News_CELL *cell = (News_CELL *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"News_CELL" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.lbl_content.text = [list_NEWS1 objectAtIndex:indexPath.row];
        return cell;
    }
    else if (tableView == _tbl_ARTICLES)
    {
        static NSString *simpleTableIdentifier = @"SimpleTableCell";
        articles_CELL *cell = (articles_CELL *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"articles_CELL" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.lbl_content.text = [list_ARTICLES objectAtIndex:indexPath.row];
        return cell;
    }
    else if (tableView == _tbl_MEDIA)
    {
        static NSString *simpleTableIdentifier = @"SimpleTableCell";
        media_CELL *cell = (media_CELL *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"media_CELL" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.lbl_content.text = [list_MEDIA objectAtIndex:indexPath.row];
        return cell;
    }
    else if (tableView == _list_DATA)
    {
        static NSString *simpleTableIdentifier = @"SimpleTableCell";
        serch_CELL *cell = (serch_CELL *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"serch_CELL" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.lbl_NME.text = [searchResults objectAtIndex:indexPath.row];
        cell.lbl_NME.numberOfLines = 2;
        return cell;
    }
    else if (tableView == _list_NEWS)
    {
        if (indexPath.row == 0)
        {
            static NSString *simpleTableIdentifier = @"SimpleTableCell";
            BIG_CELL_NEWS *cell = (BIG_CELL_NEWS *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BIG_CELL_NEWS" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            NSDictionary *temp_DICTN = [homeNewsSlider objectAtIndex:indexPath.row];
            NSDictionary *dict_VAL = [temp_DICTN valueForKey:@"News"];
            //        cell.lbl_NME.text = [searchResults objectAtIndex:indexPath.row];
            //        cell.lbl_NME.numberOfLines = 2;
            
            NSString *url_STR = [NSString stringWithFormat:@"%@news/%@",IMAGE_URL,[dict_VAL valueForKey:@"image"]];
            
            [cell.image_CNT sd_setImageWithURL:[NSURL URLWithString:url_STR]
                            placeholderImage:[UIImage imageNamed:@"Default.jpg"]];
            cell.lbl_TITL.text = [dict_VAL valueForKey:@"title"];
            cell.lbl_CNT.text = [dict_VAL valueForKey:@"summary"];
            cell.lbl_CNT.numberOfLines = 2;
            
            return cell;
        }
        else
        {
            static NSString *simpleTableIdentifier = @"SimpleTableCell";
            Small_CEL_NWS *cell = (Small_CEL_NWS *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Small_CEL_NWS" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            NSDictionary *temp_DICTN = [homeNewsSlider objectAtIndex:indexPath.row];
            NSDictionary *dict_VAL = [temp_DICTN valueForKey:@"News"];
            //        cell.lbl_NME.text = [searchResults objectAtIndex:indexPath.row];
            //        cell.lbl_NME.numberOfLines = 2;
            
            NSString *url_STR = [NSString stringWithFormat:@"%@news/%@",IMAGE_URL,[dict_VAL valueForKey:@"image"]];
            
            [cell.image_CNT sd_setImageWithURL:[NSURL URLWithString:url_STR]
                              placeholderImage:[UIImage imageNamed:@"Default.jpg"]];
            cell.lbl_TITL.text = [dict_VAL valueForKey:@"title"];
            cell.lbl_CNT.text = [dict_VAL valueForKey:@"summary"];
            cell.lbl_CNT.numberOfLines = 4;
            return cell;
        }
        
    }
    else if (tableView == _list_arbNWS)
    {
        static NSString *simpleTableIdentifier = @"SimpleTableCell";
        BIG_CELL_NEWS *cell = (BIG_CELL_NEWS *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BIG_CELL_NEWS" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        //        cell.lbl_NME.text = [searchResults objectAtIndex:indexPath.row];
        //        cell.lbl_NME.numberOfLines = 2;
//        NSDictionary *temp_DICTN = [arabnews objectAtIndex:indexPath.row];
        NSDictionary *dict_VAL = [arabnews valueForKey:@"News"];
        //        cell.lbl_NME.text = [searchResults objectAtIndex:indexPath.row];
        //        cell.lbl_NME.numberOfLines = 2;
        
        NSString *url_STR = [NSString stringWithFormat:@"%@news/%@",IMAGE_URL,[dict_VAL valueForKey:@"image"]];
        
        [cell.image_CNT sd_setImageWithURL:[NSURL URLWithString:url_STR]
                          placeholderImage:[UIImage imageNamed:@"Default.jpg"]];
        cell.lbl_TITL.text = [dict_VAL valueForKey:@"title"];
        cell.lbl_CNT.text = [dict_VAL valueForKey:@"summary"];
        cell.lbl_CNT.numberOfLines = 2;
        
        return cell;
    }
    else if (tableView == _list_localNWS)
    {
        if ([localNews count] == 1)
        {
            static NSString *simpleTableIdentifier = @"SimpleTableCell";
            BIG_CELL_NEWS *cell = (BIG_CELL_NEWS *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BIG_CELL_NEWS" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            //        cell.lbl_NME.text = [searchResults objectAtIndex:indexPath.row];
            //        cell.lbl_NME.numberOfLines = 2;
            NSDictionary *temp_DICTN = [localNews objectAtIndex:indexPath.row];
            NSDictionary *dict_VAL = [temp_DICTN valueForKey:@"News"];
            //        cell.lbl_NME.text = [searchResults objectAtIndex:indexPath.row];
            //        cell.lbl_NME.numberOfLines = 2;
            
            NSString *url_STR = [NSString stringWithFormat:@"%@news/%@",IMAGE_URL,[dict_VAL valueForKey:@"image"]];
            
            [cell.image_CNT sd_setImageWithURL:[NSURL URLWithString:url_STR]
                              placeholderImage:[UIImage imageNamed:@"Default.jpg"]];
            cell.lbl_TITL.text = [dict_VAL valueForKey:@"title"];
            cell.lbl_CNT.text = [dict_VAL valueForKey:@"summary"];
            cell.lbl_CNT.numberOfLines = 2;
            
            return cell;
        }
        else
        {
            static NSString *simpleTableIdentifier = @"SimpleTableCell";
            LCL_NWS_2 *cell = (LCL_NWS_2 *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LCL_NWS_2" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            NSDictionary *temp_DICTN = [localNews objectAtIndex:indexPath.row];
            NSDictionary *dict_VAL = [temp_DICTN valueForKey:@"News"];
            //        cell.lbl_NME.text = [searchResults objectAtIndex:indexPath.row];
            //        cell.lbl_NME.numberOfLines = 2;
            
            NSString *url_STR = [NSString stringWithFormat:@"%@news/%@",IMAGE_URL,[dict_VAL valueForKey:@"image"]];
            
            [cell.image_CNT1 sd_setImageWithURL:[NSURL URLWithString:url_STR]
                              placeholderImage:[UIImage imageNamed:@"Default.jpg"]];
            cell.lbl_TITL1.text = [dict_VAL valueForKey:@"title"];
            cell.lbl_CNT1.text = [dict_VAL valueForKey:@"summary"];
            cell.lbl_CNT1.numberOfLines = 4;
            [cell.btn1 addTarget:self action:@selector(local_news0) forControlEvents:UIControlEventTouchUpInside];
            
            
            NSDictionary *temp_DICTN1 = [localNews objectAtIndex:indexPath.row + 1];
            NSDictionary *dict_VAL1 = [temp_DICTN1 valueForKey:@"News"];
            //        cell.lbl_NME.text = [searchResults objectAtIndex:indexPath.row];
            //        cell.lbl_NME.numberOfLines = 2;
            
            NSString *url_STR1 = [NSString stringWithFormat:@"%@news/%@",IMAGE_URL,[dict_VAL1 valueForKey:@"image"]];
            
            [cell.image_CNT2 sd_setImageWithURL:[NSURL URLWithString:url_STR1]
                               placeholderImage:[UIImage imageNamed:@"Default.jpg"]];
            cell.lbl_TITL2.text = [dict_VAL valueForKey:@"title"];
            cell.lbl_CNT2.text = [dict_VAL valueForKey:@"summary"];
            cell.lbl_CNT2.numberOfLines = 4;
            [cell.btn2 addTarget:self action:@selector(local_news1) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }
    }
    else if (tableView == _list_intrVW)
    {
        if (indexPath.row == 0)
        {
            static NSString *simpleTableIdentifier = @"SimpleTableCell";
            BIG_CELL_NEWS *cell = (BIG_CELL_NEWS *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BIG_CELL_NEWS" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            NSDictionary *temp_DICTN = [interview objectAtIndex:indexPath.row];
            NSDictionary *dict_VAL = [temp_DICTN valueForKey:@"Interview"];
            
            NSString *url_STR = [NSString stringWithFormat:@"%@interview/%@",IMAGE_URL,[dict_VAL valueForKey:@"image"]];
            
            [cell.image_CNT sd_setImageWithURL:[NSURL URLWithString:url_STR]
                              placeholderImage:[UIImage imageNamed:@"Default.jpg"]];
            cell.lbl_TITL.text = [dict_VAL valueForKey:@"title"];
            cell.lbl_CNT.text = [dict_VAL valueForKey:@"summary"];
            cell.lbl_CNT.numberOfLines = 2;
            return cell;
        }
        else
        {
            static NSString *simpleTableIdentifier = @"SimpleTableCell";
            Small_CEL_NWS *cell = (Small_CEL_NWS *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Small_CEL_NWS" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            NSDictionary *temp_DICTN = [interview objectAtIndex:indexPath.row];
            NSDictionary *dict_VAL = [temp_DICTN valueForKey:@"Interview"];
            //        cell.lbl_NME.text = [searchResults objectAtIndex:indexPath.row];
            //        cell.lbl_NME.numberOfLines = 2;
            
            NSString *url_STR = [NSString stringWithFormat:@"%@interview/%@",IMAGE_URL,[dict_VAL valueForKey:@"image"]];
            
            [cell.image_CNT sd_setImageWithURL:[NSURL URLWithString:url_STR]
                              placeholderImage:[UIImage imageNamed:@"Default.jpg"]];
            cell.lbl_TITL.text = [dict_VAL valueForKey:@"title"];
            cell.lbl_CNT.text = [dict_VAL valueForKey:@"summary"];
            cell.lbl_CNT.numberOfLines = 4;
            return cell;
        }
    }
    else if (tableView == _list_reports)
    {
        if (indexPath.row == 0)
        {
            static NSString *simpleTableIdentifier = @"SimpleTableCell";
            BIG_CELL_NEWS *cell = (BIG_CELL_NEWS *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BIG_CELL_NEWS" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            NSDictionary *temp_DICTN = [reports objectAtIndex:indexPath.row];
            NSDictionary *dict_VAL = [temp_DICTN valueForKey:@"Report"];
            
            NSString *url_STR = [NSString stringWithFormat:@"%@report/%@",IMAGE_URL,[dict_VAL valueForKey:@"image"]];
            
            [cell.image_CNT sd_setImageWithURL:[NSURL URLWithString:url_STR]
                              placeholderImage:[UIImage imageNamed:@"Default.jpg"]];
            cell.lbl_TITL.text = [dict_VAL valueForKey:@"title"];
            cell.lbl_CNT.text = [dict_VAL valueForKey:@"summary"];
            cell.lbl_CNT.numberOfLines = 2;
            return cell;
        }
        else if (indexPath.row == 4 && [reports count] > 5)
        {
            static NSString *simpleTableIdentifier = @"SimpleTableCell";
            LCL_NWS_2 *cell = (LCL_NWS_2 *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LCL_NWS_2" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            NSDictionary *temp_DICTN = [reports objectAtIndex:indexPath.row];
            NSDictionary *dict_VAL = [temp_DICTN valueForKey:@"Report"];
            //        cell.lbl_NME.text = [searchResults objectAtIndex:indexPath.row];
            //        cell.lbl_NME.numberOfLines = 2;
            
            NSString *url_STR = [NSString stringWithFormat:@"%@report/%@",IMAGE_URL,[dict_VAL valueForKey:@"image"]];
            
            [cell.image_CNT1 sd_setImageWithURL:[NSURL URLWithString:url_STR]
                               placeholderImage:[UIImage imageNamed:@"Default.jpg"]];
            cell.lbl_TITL1.text = [dict_VAL valueForKey:@"title"];
            cell.lbl_CNT1.text = [dict_VAL valueForKey:@"summary"];
            cell.lbl_CNT1.numberOfLines = 4;
            [cell.btn1 addTarget:self action:@selector(local_reports0) forControlEvents:UIControlEventTouchUpInside];
            
            
            NSDictionary *temp_DICTN1 = [reports objectAtIndex:indexPath.row + 1];
            NSDictionary *dict_VAL1 = [temp_DICTN1 valueForKey:@"Report"];
            //        cell.lbl_NME.text = [searchResults objectAtIndex:indexPath.row];
            //        cell.lbl_NME.numberOfLines = 2;
            
            NSString *url_STR1 = [NSString stringWithFormat:@"%@report/%@",IMAGE_URL,[dict_VAL1 valueForKey:@"image"]];
            
            [cell.image_CNT2 sd_setImageWithURL:[NSURL URLWithString:url_STR1]
                               placeholderImage:[UIImage imageNamed:@"Default.jpg"]];
            cell.lbl_TITL2.text = [dict_VAL valueForKey:@"title"];
            cell.lbl_CNT2.text = [dict_VAL valueForKey:@"summary"];
            cell.lbl_CNT2.numberOfLines = 4;
            [cell.btn2 addTarget:self action:@selector(local_reports1) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        else
        {
            static NSString *simpleTableIdentifier = @"SimpleTableCell";
            Small_CEL_NWS *cell = (Small_CEL_NWS *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Small_CEL_NWS" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            NSDictionary *temp_DICTN = [reports objectAtIndex:indexPath.row];
            NSDictionary *dict_VAL = [temp_DICTN valueForKey:@"Report"];
            
            NSString *url_STR = [NSString stringWithFormat:@"%@report/%@",IMAGE_URL,[dict_VAL valueForKey:@"image"]];
            
            [cell.image_CNT sd_setImageWithURL:[NSURL URLWithString:url_STR]
                              placeholderImage:[UIImage imageNamed:@"Default.jpg"]];
            cell.lbl_TITL.text = [dict_VAL valueForKey:@"title"];
            cell.lbl_CNT.text = [dict_VAL valueForKey:@"summary"];
            cell.lbl_CNT.numberOfLines = 4;
            return cell;
        }
    }
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    //    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _list_DATA)
    {
        return 53;
    }
    else if (tableView == _list_NEWS)
    {
        if (indexPath.row == 0) {
            return 264;
        }
        else
        {
            return 106;
        }
    }
    else if (tableView == _list_arbNWS)
    {
        return 264;
    }
    else if (tableView == _list_localNWS)
    {
        if ([localNews count] == 1)
        {
            return 264;
        }
        else
        {
            return 169;
        }
    }
    else if (tableView == _list_intrVW)
    {
        if (indexPath.row == 0) {
            return 264;
        }
        else
        {
            return 106;
        }
    }
    else if (tableView == _list_reports)
    {
        if (indexPath.row == 0)
        {
            return 264;
        }
        else if (indexPath.row == 4 && [reports count] > 5)
        {
            return 169;
        }
        else
        {
            return 106;
        }
    }
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"Tap detected at index path %ld",(long)indexPath.row);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:-5];
    
    int statusbar_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
    statusbar_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
    VW_swipe.frame = CGRectMake(self.navigationController.view.frame.size.width, self.navigationController.view.frame.origin.y + statusbar_HEIGHT, menuDraw_width, self.navigationController.view.frame.size.height);
    
    [UIView commitAnimations];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:-5];
    _overlayView.hidden = YES;
    [UIView commitAnimations];
    
    if (tableView == _tbl_NEWS)
    {
        //        [_tbl_NEWS release];
        //        [_tbl_MEDIA release];
        //        [_tbl_ARTICLES release];
        //        [VW_swipe release];
        //        [myCollapseClick release];
        //        [self.navigationController.view release];
        send_news_TITL = [list_NEWS1 objectAtIndex:indexPath.row];
        [self load_NEWS_VC];
    }
    else if (tableView == _tbl_ARTICLES)
    {
        //        Article_VC *controller = [[Article_VC alloc] initWithNibName:@"Article_VC" bundle:nil];
        //        controller.get_NAV_TITL = [list_ARTICLES objectAtIndex:indexPath.row];
        //        [self.navigationController pushViewController:controller animated:YES];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"article_story" bundle:nil];
        Article_VC *menu_Home_VC = [storyboard instantiateViewControllerWithIdentifier:@"Article_VIEW"];
        menu_Home_VC.get_NAV_TITL = [list_ARTICLES objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:menu_Home_VC animated:NO];
    }
    else if (tableView == _tbl_MEDIA)
    {
        if (indexPath.row == 0)
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"photoS" bundle:nil];
            photos_VC *menu_Home_VC = [storyboard instantiateViewControllerWithIdentifier:@"photos_VIEW"];
            menu_Home_VC.get_NAV_TITL = [list_MEDIA objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:menu_Home_VC animated:NO];
        }
        else
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"videoS" bundle:nil];
            Videos_VC *menu_Home_VC = [storyboard instantiateViewControllerWithIdentifier:@"videos_VIEW"];
            menu_Home_VC.get_NAV_TITL = [list_MEDIA objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:menu_Home_VC animated:NO];
        }
    }
    else if (tableView == _list_DATA)
    {
        _VW_Serch_BAR.hidden = YES;
        [_serch_BAR resignFirstResponder];
        
        NSString *serch_DTATA = [searchResults objectAtIndex:indexPath.row];
        int index = (int)[ID_nmae indexOfObject:serch_DTATA];
        
        //        NSString *selected_name = [ID_nmae objectAtIndex:index];
        NSString *index_ID = [ID_STR objectAtIndex:index];
        NSString *model_Name = [ID_model objectAtIndex:index];
        
        //        NSLog(@"Selected Name %@ Index is %@ Value is %@",selected_name,index_ID,model_Name);
        if ([model_Name isEqualToString:@"News"])
        {
            NEWS_datail_VC *controller = [[NEWS_datail_VC alloc] initWithNibName:@"NEWS_datail_VC" bundle:nil];
            controller.get_home = @"News Detail";
            controller.get_ID = index_ID;
            [self.navigationController pushViewController:controller animated:YES];
        }
        else if ([model_Name isEqualToString:@"Report"])
        {
            Report_DETAIL_VC *controller = [[Report_DETAIL_VC alloc] initWithNibName:@"Report_DETAIL_VC" bundle:nil];
            controller.get_home = @"Report Detail";
            controller.get_ID = index_ID;
            [self.navigationController pushViewController:controller animated:YES];
        }
        else if ([model_Name isEqualToString:@"Interview"])
        {
            Interview_DETAIL *controller = [[Interview_DETAIL alloc] initWithNibName:@"Interview_DETAIL" bundle:nil];
            controller.get_home = @"Interview Detail";
            controller.get_ID = index_ID;
            [self.navigationController pushViewController:controller animated:YES];
        }
        else
        {
            Article_DETAIL_VC *controller = [[Article_DETAIL_VC alloc] initWithNibName:@"Article_DETAIL_VC" bundle:nil];
            controller.get_home = @"Article Detail";
            controller.get_ID = index_ID;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
    else if (tableView == _list_NEWS)
    {
        NSDictionary *temp_DICTN = [homeNewsSlider objectAtIndex:indexPath.row];
        NSDictionary *dict_VAL = [temp_DICTN valueForKey:@"News"];
        
        NEWS_datail_VC *controller = [[NEWS_datail_VC alloc] initWithNibName:@"NEWS_datail_VC" bundle:nil];
        controller.get_home = @"Home";
        controller.get_ID = [dict_VAL valueForKey:@"id"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (tableView == _list_arbNWS)
    {
        NSDictionary *temp_DICTN = [arabnews objectAtIndex:indexPath.row];
        NSDictionary *dict_VAL = [temp_DICTN valueForKey:@"News"];
        
        NEWS_datail_VC *controller = [[NEWS_datail_VC alloc] initWithNibName:@"NEWS_datail_VC" bundle:nil];
        controller.get_home = @"Home";
        controller.get_ID = [dict_VAL valueForKey:@"id"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (tableView == _list_localNWS)
    {
        if ([localNews count] == 1) {
            NSDictionary *temp_DICTN = [localNews objectAtIndex:0];
            NSDictionary *dict_VAL = [temp_DICTN valueForKey:@"News"];
            
            NEWS_datail_VC *controller = [[NEWS_datail_VC alloc] initWithNibName:@"NEWS_datail_VC" bundle:nil];
            controller.get_home = @"Home";
            controller.get_ID = [dict_VAL valueForKey:@"id"];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
    else if (tableView == _list_intrVW)
    {
        NSDictionary *temp_DICTN = [interview objectAtIndex:indexPath.row];
        NSDictionary *dict_VAL = [temp_DICTN valueForKey:@"Interview"];
        
        Interview_DETAIL *controller = [[Interview_DETAIL alloc] initWithNibName:@"Interview_DETAIL" bundle:nil];
        controller.get_ID = [dict_VAL valueForKey:@"id"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (tableView == _list_reports)
    {
        if (indexPath.row == 4 && [reports count] > 5)
        {
            
        }
        else
        {
            NSDictionary *temp_DICTN = [reports objectAtIndex:indexPath.row];
            NSDictionary *dict_VAL = [temp_DICTN valueForKey:@"Report"];
            
            Report_DETAIL_VC *controller = [[Report_DETAIL_VC alloc] initWithNibName:@"Report_DETAIL_VC" bundle:nil];
            controller.get_ID = [dict_VAL valueForKey:@"id"];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}

#pragma mark - Next VC Load
-(void) load_NEWS_VC
{
    News_local *controller = [[News_local alloc] initWithNibName:@"News_local" bundle:nil];
    controller.get_NAV_TITL = send_news_TITL;
    controller.get_News_titl = send_news_TITL;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) SwipeRecognizer:(UISwipeGestureRecognizer *)sender
{
    _overlayView.hidden = NO;
    if ( sender.direction | UISwipeGestureRecognizerDirectionLeft )
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:-5];
        
        CGFloat new_X = 0;
        if (VW_swipe.frame.origin.x < self.view.frame.origin.x)
        {
            new_X = VW_swipe.frame.origin.x + menuDraw_width;
        }
        else
        {
            new_X = VW_swipe.frame.origin.x - menuDraw_width;
        }
        VW_swipe.frame = CGRectMake(new_X, VW_swipe.frame.origin.y, menuDraw_width, self.view.frame.size.height + self.navigationController.navigationBar.frame.size.height);
        [UIView commitAnimations];
    }
}

- (void) SwipeRight :(UISwipeGestureRecognizer *)sender
{
    if ( sender.direction | UISwipeGestureRecognizerDirectionRight )
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:-5];
        
        int statusbar_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
        statusbar_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
        VW_swipe.frame = CGRectMake(self.navigationController.view.frame.size.width, self.navigationController.view.frame.origin.y + statusbar_HEIGHT, menuDraw_width, self.navigationController.view.frame.size.height);
        
        [UIView commitAnimations];
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:-5];
        _overlayView.hidden = YES;
        [UIView commitAnimations];
        
    }
}

-(void)viewDidLayoutSubviews
{
    _scroll_contNT.contentSize = _VW_Contents.frame.size;
    CGRect frame = _widget_VW.frame;
    frame.size.height = _widget_VW.scrollView.contentSize.height;
    _widget_VW.frame = frame;
    
//    [self setup_DATA];
}


#pragma mark - Custom Cell Button Actions
-(void)local_news0
{
    NSDictionary *temp_DICTN = [localNews objectAtIndex:0];
    NSDictionary *dict_VAL = [temp_DICTN valueForKey:@"News"];
    
    NEWS_datail_VC *controller = [[NEWS_datail_VC alloc] initWithNibName:@"NEWS_datail_VC" bundle:nil];
    controller.get_home = @"Home";
    controller.get_ID = [dict_VAL valueForKey:@"id"];
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)local_news1
{
    NSDictionary *temp_DICTN = [localNews objectAtIndex:1];
    NSDictionary *dict_VAL = [temp_DICTN valueForKey:@"News"];
    
    NEWS_datail_VC *controller = [[NEWS_datail_VC alloc] initWithNibName:@"NEWS_datail_VC" bundle:nil];
    controller.get_home = @"Home";
    controller.get_ID = [dict_VAL valueForKey:@"id"];
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)local_reports0
{
    NSLog(@"Tapped reports 0");
    NSDictionary *temp_DICTN = [reports objectAtIndex:4];
    NSDictionary *dict_VAL = [temp_DICTN valueForKey:@"Report"];
    
    Report_DETAIL_VC *controller = [[Report_DETAIL_VC alloc] initWithNibName:@"Report_DETAIL_VC" bundle:nil];
    controller.get_ID = [dict_VAL valueForKey:@"id"];
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)local_reports1
{
    NSLog(@"Tapped reports 1");
    NSDictionary *temp_DICTN = [reports objectAtIndex:5];
    NSDictionary *dict_VAL = [temp_DICTN valueForKey:@"Report"];
    
    Report_DETAIL_VC *controller = [[Report_DETAIL_VC alloc] initWithNibName:@"Report_DETAIL_VC" bundle:nil];
    controller.get_ID = [dict_VAL valueForKey:@"id"];
    [self.navigationController pushViewController:controller animated:YES];
}


/*- (BOOL)webView:(UIWebView*)webView
shouldStartLoadWithRequest:(NSURLRequest*)request
 navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = [request URL];
    if (navigationType == UIWebViewNavigationTypeOther) {
        if ([[url scheme] isEqualToString:@"ready"]) {
            float contentHeight = [[url host] floatValue];
            CGRect fr = _widget_VW.frame;
            fr.size = CGSizeMake(_widget_VW.frame.size.width, contentHeight);
            _widget_VW.frame = fr;
            return NO;
        } 
    }
 
    return YES; 
}*/

- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
    NSString *fontSize=@"50";
    NSString *jsString = [[NSString alloc]      initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'",[fontSize intValue]];
    [_widget_VW stringByEvaluatingJavaScriptFromString:jsString];

    
    CGRect frame1 = _widget_VW.frame;
    frame1.size.height = 60;
    _widget_VW.frame = frame1;
    [_widget_VW sizeToFit];
    CGRect frame = _widget_VW.frame;
    frame.size.height = 1;
    _widget_VW.frame = frame;
    CGSize fittingSize = [_widget_VW sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    _widget_VW.frame = frame;
    NSLog(@"size: %f, %f", fittingSize.width, fittingSize.height);

    [self setup_DATA];
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *fontSize=@"50";
    NSString *jsString = [[NSString alloc]      initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'",[fontSize intValue]];
    [_widget_VW stringByEvaluatingJavaScriptFromString:jsString];
    
//    CGRect frame1 = _widget_VW.frame;
//    frame1.size.height = 60;
//    _widget_VW.frame = frame1;
//    [_widget_VW sizeToFit];

    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSLog(@"User tapped a link.");
//        [_widget_VW sizeToFit];
        
//        NSString *height = [_widget_VW stringByEvaluatingJavaScriptFromString:@"document.getElementById('content').offsetHeight;"];
//        NSLog(@"Height :: %@",height);
        
//        [_widget_VW setSuppressesIncrementalRendering:YES];
        
//        CGRect frame = _widget_VW.frame;
//        _widget_VW.setNeedsUpdateConstraints;
//        _widget_VW.frame = frame;
        
        
        
        
        seconds = 1;
        count = 0;
        
        
        
        // 3
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                 target:self
                                               selector:@selector(subtractTime)
                                               userInfo:nil
                                                repeats:YES];
        
        
        
        
        
//        [self scrollViewDidScroll:_widget_VW.scrollView];
        
        return YES;
    }

    return YES;
}
- (void)subtractTime {
    // 1
    seconds--;
    
    // 2
    if (seconds == 0) {
        [timer invalidate];
        
        CGRect frame = _widget_VW.frame;
        frame.size.height = 1;
        _widget_VW.frame = frame;
        CGSize fittingSize = [_widget_VW sizeThatFits:CGSizeZero];
        frame.size = fittingSize;
        _widget_VW.frame = frame;
        NSLog(@"size: %f, %f", fittingSize.width, fittingSize.height);

        
        [self setup_DATA];
    }
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"teetet ");
}


@end
