//
//  E_magazine_VC.m
//  Estad
//
//  Created by Apple on 15/12/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import "E_magazine_VC.h"
//#import "HomeController.h"
#import "New_Home_VC.h"
#import "About_US_VC.h"
#import "ContactUS_VC.h"
#import "News_CELL.h"
#import "articles_CELL.h"
#import "media_CELL.h"
#import "Article_VC.h"
#import "photos_VC.h"
#import "Videos_VC.h"
#import "News_local.h"
#import "Cell_E_mag_coll.h"
#import "Month_Cell_CSTM.h"
#import "serch_CELL.h"
#import "NEWS_datail_VC.h"
#import "Report_DETAIL_VC.h"
#import "Interview_DETAIL.h"
#import "Article_DETAIL_VC.h"
#import "Magazine_DETAIL.h"
#import "sEttings_VC.h"
#import "Editorial_board_VC.h"

#import "SDWebImage/UIImageView+WebCache.h"

@interface E_magazine_VC ()

@end

@implementation E_magazine_VC
{
    CGRect statusBarFrame1;
    NSArray *list_NEWS;
    NSArray *list_ARTICLES;
    NSArray *list_MEDIA;
    NSString *send_news_TITL;
    
    NSArray *year,*month;
    
    NSString *month_ID;
    
    NSArray *serch_CONTENT;
    NSMutableArray *IMG_S,*DATE_S,*tickt_ID,*PDF_file;
    
    NSDictionary *emagazine_date;
    
    NSMutableArray *ID_STR,*ID_model,*ID_nmae;
    
    NSMutableArray *searchResults;
    BOOL isSerching;
    
    int count_VAL;
}

@synthesize menuDraw_width,menyDraw_X,VW_swipe;


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.COL_contnt registerNib:[UINib nibWithNibName:@"Cell_E_mag_coll" bundle:nil] forCellWithReuseIdentifier:@"CollectionCell"];
    
    myCollapseClick.CollapseClickDelegate = self;
    [myCollapseClick reloadCollapseClick];
    
    
//    _scroll_CNTNT.alwaysBounceVertical = NO;
    
    //    [myCollapseClick openCollapseClickCellAtIndex:1 animated:NO];
    
//    list_NEWS = [[NSArray alloc]initWithObjects:@"أخبار الدوريات المحلية",@"الدوريات الأخبار العربية",@"أخبار الدوريات العالمية",@"كل الأخبار", @"قطر 2022", @"أسباير زون", nil];
    list_NEWS = [[NSArray alloc]initWithObjects:@"اخبار الدوريات المحلية",@"اخبار الدوريات العربية",@"اخبار الدوريات العالمية",@"اخبار رياضية اخرى",@"قطر2022",@"أسباير زون", nil];
//    list_ARTICLES = [[NSArray alloc]initWithObjects:@"محرر بلوق",@"مقالات استاد الدوحة", nil];
    list_ARTICLES = [[NSArray alloc]initWithObjects:@"مقالات رئيس التحرير",@"مقالات استاد الدوحة", nil];
//    list_MEDIA = [[NSArray alloc]initWithObjects:@"صور" ,@"فيديوهات", nil];
    list_MEDIA = [[NSArray alloc]initWithObjects:@"الصور" ,@"الفيديو", nil];
    
    year = [[NSArray alloc]initWithObjects:@"اختر سنة",@"2014",@"2015",@"2016",nil];
    month = [[NSArray alloc]initWithObjects:@"اختر الشهر",@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December",nil];
    
    [self setup_VIEW];
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

-(void) Tap_DTECt :(UITapGestureRecognizer *)sender
{
}

#pragma mark - View Customisation
-(void) setup_VIEW
{
    //    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.44 green:0.00 blue:0.24 alpha:1.0]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tap_DTECt:)];
    [tap setCancelsTouchesInView:NO];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
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
    label.text = NSLocalizedString(@"PDF الجريدة", @"");
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
    
    UILabel *lbl_btn_srch = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    lbl_btn_srch.text = @"";
    lbl_btn_srch.font = [UIFont fontWithName:@"FontAwesome" size:21.0f];
    lbl_btn_srch.textColor = [UIColor whiteColor];
    UIButton *BTN_srch = [UIButton buttonWithType:UIButtonTypeCustom];
    [BTN_srch addSubview:lbl_btn_srch];
    BTN_srch.frame = CGRectMake(0, 0, 40, 40);
    [BTN_srch addTarget:self action:@selector(SERCH_action) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar_btn_srch = [[UIBarButtonItem alloc]initWithCustomView:BTN_srch];
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer,bar_SYNC,bar_btn_srch,Nil]];
    
    
    
//    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:bar_btn_srch,Nil]];
    
    int statusbar_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
    self.navigationController.navigationBar.frame = CGRectMake(0,statusbar_HEIGHT,self.navigationController.navigationBar.frame.size.width,self.navigationController.navigationBar.frame.size.height);
    
    statusbar_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        menuDraw_width = [UIApplication sharedApplication].statusBarFrame.size.width * 0.50;
    }
    else
    {
        menuDraw_width = [UIApplication sharedApplication].statusBarFrame.size.width * 0.80;
    }
    menyDraw_X = self.navigationController.view.frame.size.width; //- menuDraw_width;
    VW_swipe.frame = CGRectMake(self.navigationController.view.frame.size.width, self.view.frame.origin.y + statusbar_HEIGHT, menuDraw_width, self.navigationController.view.frame.size.height);
    
    //    VW_swipe.backgroundColor = [UIColor colorWithRed:0.47 green:0.00 blue:0.25 alpha:1.0];
    //    [self.navigationController.view addSubview:VW_swipe];
    
    _overlayView = [[UIView alloc] initWithFrame:self.navigationController.view.frame];
    _overlayView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    [self.navigationController.view addSubview:_overlayView];
    
    [_overlayView addSubview:VW_swipe];
    _overlayView.hidden = YES;
    
    _VW_activity = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    CGRect new_FRAME1 = _VW_activity.frame;
    new_FRAME1.size.width = self.navigationController.navigationBar.frame.size.width;
    _VW_activity.frame = new_FRAME1;
    _VW_activity.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    _activityindicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityindicator.center = _VW_activity.center;
    [_VW_activity addSubview:_activityindicator];
    [self.navigationController.view addSubview:_VW_activity];
    
    _VW_activity.hidden = YES;
    
    UISwipeGestureRecognizer *SwipeLEFT = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeRecognizer:)];
    SwipeLEFT.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:SwipeLEFT];
    //    [_overlayView addGestureRecognizer:SwipeLEFT];
    
    UISwipeGestureRecognizer *SwipeRIGHT = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeRight:)];
    SwipeRIGHT.direction = UISwipeGestureRecognizerDirectionRight;
    //    [self.view addGestureRecognizer:SwipeRIGHT];
    [_overlayView addGestureRecognizer:SwipeRIGHT];
    
    [self Decide_API];
    
    [_VW_Content addSubview:_COL_contnt];

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
    
    CGRect size_NW = _VW_Content.frame;
    size_NW.size.height = _VW_Content.frame.size.height;
    size_NW.size.width = _scroll_CNTNT.frame.size.width;
    
    _VW_Content.frame = size_NW;
    [_scroll_CNTNT addSubview:_VW_Content];
    _scroll_CNTNT.contentSize = _VW_Content.frame.size;
    
    _list_Year.hidden = YES;
    _list_Month.hidden = YES;
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
            return @"الاخبار";
            break;
            
        case 2:
            return @"المقالات";
            break;
            
        case 3:
            return @"المركز الاعلامي";
            break;
            
        case 4:
            return @"PDF الجريدة";
            break;
        case 5:
            return @"من نحن";
            break;
            
        case 6:
            return @"هيئة التحرير";
            break;
            
        case 7:
            return @"اتصل بنا";
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
            return VW_News;
            break;
        case 2:
            return VW_Articles;
            break;
        case 3:
            return VW_Media;
            break;
        case 4:
            return VW_Emagazine;
            break;
        case 5:
            return VW_About_US;
            break;
        case 6:
            return VW_Editorial;
            break;
        case 7:
            return VW_Contact_US;
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
        //        NSLog(@"Index 0");
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
        [self performSelector:@selector(Load_Home) withObject:_activityindicator afterDelay:0.01];
        
    }
    else if (index == 4)
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
        [self performSelector:@selector(Editorial_FFF) withObject:_activityindicator afterDelay:0.01];
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
        [self performSelector:@selector(Contact_US_PG) withObject:_activityindicator afterDelay:0.01];
        
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

-(void) Load_Home
{
    New_Home_VC *controller = [[New_Home_VC alloc] initWithNibName:@"New_Home_VC" bundle:nil];
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
        return [list_NEWS count];
    }
    else if (tableView == _tbl_ARTICLES)
    {
        return [list_ARTICLES count];
    }
    else if (tableView == _tbl_MEDIA)
    {
        return [list_MEDIA count];
    }
    else if (tableView == _list_Month)
    {
        return [month count];
    }
    else if (tableView == _list_Year)
    {
        return [year count];
    }
    else if (tableView == _list_DATA)
    {
        return [searchResults count];
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
        cell.lbl_content.text = [list_NEWS objectAtIndex:indexPath.row];
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
    else if (tableView == _list_Year)
    {
        static NSString *simpleTableIdentifier = @"SimpleTableCell";
        Month_Cell_CSTM *cell = (Month_Cell_CSTM *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Month_Cell_CSTM" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.lbl_Name.text = [year objectAtIndex:indexPath.row];
        return cell;
    }
    else if (tableView == _list_Month)
    {
        static NSString *simpleTableIdentifier = @"SimpleTableCell";
        Month_Cell_CSTM *cell = (Month_Cell_CSTM *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Month_Cell_CSTM" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.lbl_Name.text = [month objectAtIndex:indexPath.row];
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
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = @"";
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _list_DATA)
    {
        return 53;
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
        send_news_TITL = [list_NEWS objectAtIndex:indexPath.row];
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
    else if (tableView == _list_Month)
    {
        _lbl_Month.text = [month objectAtIndex:indexPath.row];
        _list_Month.hidden = YES;
        month_ID = [NSString stringWithFormat:@"%d",(int)indexPath.row];
    }
    else if (tableView == _list_Year)
    {
        _lbl_YEar.text = [year objectAtIndex:indexPath.row];
        _list_Year.hidden = YES;
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
            controller.get_Emagazine = @"Emagazine";
            controller.get_ID = index_ID;
            [self.navigationController pushViewController:controller animated:YES];
        }
        else if ([model_Name isEqualToString:@"Report"])
        {
            Report_DETAIL_VC *controller = [[Report_DETAIL_VC alloc] initWithNibName:@"Report_DETAIL_VC" bundle:nil];
            controller.get_Emagazine = @"Emagazine";
            controller.get_ID = index_ID;
            [self.navigationController pushViewController:controller animated:YES];
        }
        else if ([model_Name isEqualToString:@"Interview"])
        {
            Interview_DETAIL *controller = [[Interview_DETAIL alloc] initWithNibName:@"Interview_DETAIL" bundle:nil];
            controller.get_Emagazine = @"Emagazine";
            controller.get_ID = index_ID;
            [self.navigationController pushViewController:controller animated:YES];
        }
        else
        {
            Article_DETAIL_VC *controller = [[Article_DETAIL_VC alloc] initWithNibName:@"Article_DETAIL_VC" bundle:nil];
            controller.get_Emagazine = @"Emagazine";
            controller.get_ID = index_ID;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}


#pragma mark - Next VC Load
-(void) load_NEWS_VC
{
    News_local *controller = [[News_local alloc] initWithNibName:@"News_local" bundle:nil];
    controller.get_NAV_TITL = send_news_TITL;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark : Collection View Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == _COL_contnt) {
        return [IMG_S count];
    }
    return 5;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    int fixedWidth = collectionView.layer.frame.size.width;
    CGSize calCulateSizze;
    calCulateSizze.width = fixedWidth/2.0f - 8.0f;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        calCulateSizze.height = 450.0f;
    }
    else
    {
        calCulateSizze.height = 250.0f;
    }
    
    return calCulateSizze;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

        Cell_E_mag_coll *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    
//        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        [indicator startAnimating];
//        [indicator setCenter:cell.Img_PIC.center];
//        [cell.contentView addSubview:indicator];
       NSString *str_url = [[NSUserDefaults standardUserDefaults] valueForKey:@"aws_url"];

        NSString *url_STR = [NSString stringWithFormat:@"%@files/emagazine/coverphoto/%@",str_url,[IMG_S objectAtIndex:indexPath.row]];
        
        [cell.Img_PIC sd_setImageWithURL:[NSURL URLWithString:url_STR]
                   placeholderImage:[UIImage imageNamed:@"Default.jpg"]];
    
        cell.lbl_date.text = [DATE_S objectAtIndex:indexPath.row];
        cell.lbl_issue_Num.text = [NSString stringWithFormat:@"#%@",[tickt_ID objectAtIndex:indexPath.row]];
        return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str_url = [[NSUserDefaults standardUserDefaults] valueForKey:@"aws_url"];

    NSString *post_URL = [NSString stringWithFormat:@"%@files/emagazine/magazine/%@",str_url,[PDF_file objectAtIndex:indexPath.row]];
    Magazine_DETAIL *controller = [[Magazine_DETAIL alloc] initWithNibName:@"Magazine_DETAIL" bundle:nil];
    controller.get_URL = post_URL;
    [self.navigationController pushViewController:controller animated:YES];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 1, 0, 1);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}


#pragma mark - Content View Resized
-(void) viewDidLayoutSubviews
{
    _scroll_CNTNT.contentSize = _VW_Content.frame.size;
}


-(IBAction)BTN_submit:(id)sender
{
    NSLog(@"Submit");
    [_txt_SRCH resignFirstResponder];
    [self Decide_API];
}
-(IBAction)BTN_Cancel:(id)sender
{
    month_ID = @"0";
    _lbl_Month.text = [month objectAtIndex:0];
    _lbl_YEar.text = @"اختر سنة";
    _txt_SRCH.text = @"";
    [_txt_SRCH resignFirstResponder];
    [self Decide_API];
    NSLog(@"Cancel");
}
-(IBAction)BTN_Year:(id)sender
{
    NSLog(@"Year");
    _list_Month.hidden = YES;
    if (_list_Year.hidden == YES)
    {
        _list_Year.hidden = NO;
    }
    else
    {
        _list_Year.hidden = NO;
    }
    
}
-(IBAction)BTN_Month:(id)sender
{
    NSLog(@"Month");
    _list_Year.hidden = YES;
    if (_list_Month.hidden == YES)
    {
        _list_Month.hidden = NO;
    }
    else
    {
        _list_Month.hidden = YES;
    }
}

#pragma mark - Tap Gesture

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
        
    if ([touch.view isDescendantOfView:_tbl_NEWS]) {
        return NO;
    }
    else if ([touch.view isDescendantOfView:_tbl_ARTICLES]) {
        return NO;
    }
    else if ([touch.view isDescendantOfView:_tbl_MEDIA]) {
        return NO;
    }
    else if ([touch.view isDescendantOfView:_list_Year]) {
        return NO;
    }
    else if ([touch.view isDescendantOfView:_list_Month]) {
        return NO;
    }
    else if ([touch.view isDescendantOfView:_list_DATA]) {
        return NO;
    }
    
    //    UIView* view = sender.view;
    CGPoint loc = [touch locationInView:self.view];
    
    if (!CGRectContainsPoint(_tbl_NEWS.frame,loc) || !CGRectContainsPoint(_tbl_ARTICLES.frame,loc) || !CGRectContainsPoint(_tbl_MEDIA.frame,loc)|| !CGRectContainsPoint(_list_Year.frame,loc)|| !CGRectContainsPoint(_list_Month.frame,loc))
    {
        _list_Year.hidden = YES;
        _list_Month.hidden = YES;
        return YES;
    }
    return YES;
}

#pragma mark - Text Field Deligate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_txt_SRCH resignFirstResponder];
    return YES;
}


#pragma mark - Api Section
-(void) Decide_API
{
    NSString *str_MONTH,*str_YEAR,*str_TICKT;
    str_MONTH = month_ID;
    str_YEAR = _lbl_YEar.text;
    str_TICKT = _txt_SRCH.text;
    if ([month_ID isEqualToString:@"0"]||!month_ID)
    {
        str_MONTH = @"null";
    }
    
    if ([str_YEAR isEqualToString:@"اختر سنة"])
    {
        str_YEAR = @"null";
    }
    
    if (str_TICKT.length == 0)
    {
        str_TICKT = @"null";
    }
    
    count_VAL = 0;
    
    NSLog(@"Coading Status \nMontn = %@\nYear = %@\nTicket = %@",str_MONTH,str_YEAR,str_TICKT);
    
    
    NSString *url = [NSString stringWithFormat:@"%@emagazinesList/%@/%@/%@",MAIN_URL,str_TICKT,str_MONTH,str_YEAR];
    [self parse_API:url];
}

-(void) parse_API : (NSString *) Get_URL
{
//    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:Get_URL];
    
    // Asynchronously API is hit here
   /* NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                if (error)
                                                {
                                                    NSLog(@"Error %@",error);
                                                }
                                                else {
                                                   NSMutableDictionary *json_DATA  = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                    serch_CONTENT = [json_DATA valueForKey:@"result"];
                                                    }
                                            }];
    [dataTask resume];*/
    
    if (count_VAL == 0)
    {
        [IMG_S removeAllObjects];
        [DATE_S removeAllObjects];
        [tickt_ID removeAllObjects];
        [PDF_file removeAllObjects];
        
        IMG_S = [[NSMutableArray alloc] init];
        DATE_S = [[NSMutableArray alloc] init];
        tickt_ID = [[NSMutableArray alloc]init];
        PDF_file = [[NSMutableArray alloc] init];
    }
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSMutableDictionary *json_DATA  = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSString *check = [NSString stringWithFormat:@"%@",[json_DATA valueForKey:@"emagazine_date"]];
    
    if ([check isEqualToString:@"<null>"]) {
        _COL_contnt.hidden = YES;
    }
    else
    {
        serch_CONTENT = [json_DATA valueForKey:@"result"];
        emagazine_date = [json_DATA valueForKey:@"emagazine_date"];
            for (int i = 0; i < [serch_CONTENT count]; i++)
            {
                NSDictionary *temp_DICTN = [[serch_CONTENT objectAtIndex:i]valueForKey:@"Emagazine"];
                [IMG_S addObject:[temp_DICTN valueForKey:@"cover_photo"]];
//                [ID_S addObject:];
                [DATE_S addObject:[emagazine_date valueForKey:[temp_DICTN valueForKey:@"id"]]];
                [tickt_ID addObject:[temp_DICTN valueForKey:@"issue_no"]];
                [PDF_file addObject:[temp_DICTN valueForKey:@"magazine"]];
            }
        
//        for (int j = 0; j< [emagazine_date count]; j++)
//        {
//            dates_DISP = [emagazine_date valueForKey:[ID_S objectAtIndex:j]];
//        }
            _COL_contnt.hidden = NO;
            [_COL_contnt reloadData];
    }
    
    NSLog(@"The json Data = %@",serch_CONTENT);
}



#pragma mark - Search Actions
-(void) SERCH_action
{
    NSLog(@"Search tapped");
    _VW_Serch_BAR.hidden = NO;
    [self searcH_API];
}

-(IBAction)BTN_close_SRCHT:(id)sender
{
    [_serch_BAR resignFirstResponder];
    _VW_Serch_BAR.hidden = YES;
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

#pragma mark - Pagination Functionality
- (void)scrollViewDidEndDragging:(UIScrollView *)aScrollView
                  willDecelerate:(BOOL)decelerate
{
    CGPoint loffset = self.COL_contnt.contentOffset;
    CGRect bounds = aScrollView.bounds;
    CGSize size = aScrollView.contentSize;
    UIEdgeInsets inset = aScrollView.contentInset;
    float y = loffset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    
    float reload_distance = 50;
    if(y > h + reload_distance)
    {
        count_VAL = count_VAL + 10;
        if ([serch_CONTENT count] == 10)
        {
            NSString *url = [NSString stringWithFormat:@"%@emagazinesList/%d/",MAIN_URL,count_VAL];
            [self parse_API:url];
        }
        
    }
}

@end
