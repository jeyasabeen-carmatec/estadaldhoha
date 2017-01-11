//
//  HomeController.m
//  Estad
//
//  Created by carmatec on 28/10/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import "HomeController.h"
#import "News_CELL.h"
#import "articles_CELL.h"
#import "media_CELL.h"
#import "News_local.h"
#import "Article_VC.h"
#import "photos_VC.h"
#import "Videos_VC.h"
#import "ContactUS_VC.h"
#import "About_US_VC.h"
#import "Editorial_board_VC.h"
#import "NEWS_datail_VC.h"
#import "Interview_DETAIL.h"
#import "Report_DETAIL_VC.h"
#import "Article_DETAIL_VC.h"
#import "E_magazine_VC.h"

#import "serch_CELL.h"

#import "SDWebImage/UIImageView+WebCache.h"


#pragma mark - Colectionview Customcell

#import "COLL_CELL_1.h"
#import "News_COL_CELL.h"
#import "Intr_COL_Cell.h"
#import "report_Col_CELL.h"
#import "writer_Col_CELL.h"

#pragma mark - POLL
#import "Poll_VC.h"

@interface HomeController ()

@end

@implementation HomeController
{
    CGRect statusBarFrame1;
    NSArray *list_NEWS;
    NSArray *list_ARTICLES;
    NSArray *list_MEDIA;
    NSString *send_news_TITL;
    
    NSString *ft_BAL_ID,*str_FT_BL,*STR_intR_BL,*STR_other_NS;
    
    NSDictionary *contents,*whether;
    NSArray *homeNewsSlider,*latestnews,*homeinterviewslider,*localNews,*reports,*writers,*video,*gallery;
    
    NSMutableArray *News_IMG,*page_IMG_NWS,*IMG_inter,*IMG_Report,*IMG_writer,*IMG_GAL;
    NSMutableArray *title_IMG,*title_NWS,*titl_INTR,*titl_Report,*titl_writer,*titl_GAL;
    NSMutableArray *ID_news,*ID_IMg_nWS,*ID_inTR,*ID_report,*ID_writer;
    
    NSString *lat,*lon;
    
    int index_PHOT;
    
    NSMutableArray *ID_STR,*ID_model,*ID_nmae;

    NSMutableArray *searchResults;
    BOOL isSerching;
}

@synthesize menuDraw_width,menyDraw_X,VW_swipe;

-(void) viewWillAppear:(BOOL)animated
{
    //    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.collec_1 registerNib:[UINib nibWithNibName:@"COLL_CELL_1" bundle:nil] forCellWithReuseIdentifier:@"MyCell"];
    
    [self.collec_NEWS registerNib:[UINib nibWithNibName:@"News_COL_CELL" bundle:nil] forCellWithReuseIdentifier:@"NewsCell"];
    
    [self.collec_Interview registerNib:[UINib nibWithNibName:@"Intr_COL_Cell" bundle:nil] forCellWithReuseIdentifier:@"InterviewCELL"];

    [self.collec_Report registerNib:[UINib nibWithNibName:@"report_Col_CELL" bundle:nil] forCellWithReuseIdentifier:@"reportCollectionCell"];
    
    [self.collec_writer registerNib:[UINib nibWithNibName:@"writer_Col_CELL" bundle:nil] forCellWithReuseIdentifier:@"writerCollectionCell"];
    
    myCollapseClick.CollapseClickDelegate = self;
    [myCollapseClick reloadCollapseClick];
    
//    [myCollapseClick openCollapseClickCellAtIndex:1 animated:NO];
    
    list_NEWS = [[NSArray alloc]initWithObjects:@"أخبار الدوريات المحلية",@"الدوريات الأخبار العربية",@"أخبار الدوريات العالمية",@"كل الأخبار", @"قطر 2022", @"أسباير زون", nil];
    list_ARTICLES = [[NSArray alloc]initWithObjects:@"محرر بلوق",@"مقالات استاد الدوحة", nil];
    list_MEDIA = [[NSArray alloc]initWithObjects:@"صور" ,@"فيديوهات", nil];
    
    
    [self API_Home_page];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    _scroll_contNT.contentSize = _VW_Contents.frame.size;
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

-(void)Hide_titl
{
    HomeController *controller = [[HomeController alloc] initWithNibName:@"HomeController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
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
    
    
    _VW_overlay = [[UIView alloc]initWithFrame:self.navigationController.view.frame];
    _VW_overlay.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    _VW_photos.center = _VW_overlay.center;
    [_VW_overlay addSubview:_VW_photos];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [_VW_overlay addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(didSwipe:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [_VW_overlay addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]  initWithTarget:self action:@selector(didSwipe:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [_VW_overlay addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [_VW_overlay addGestureRecognizer:swipeDown];
    
    
    
    [self.navigationController.view addSubview:_VW_overlay];
    _VW_overlay.hidden = YES;
    
    
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
    
    
   _VW_activity.hidden = NO;
    [_activityindicator startAnimating];
    [self performSelector:@selector(setup_DATA) withObject:_activityindicator afterDelay:0.01];
    
    
    [_collec_1 setShowsHorizontalScrollIndicator:NO];
//    [self.collec_1 setContentOffset:self.collec_1.contentOffset animated:NO];
    self.collec_1.bounces  = NO;
    self.collec_1.alwaysBounceVertical = NO;
    self.collec_1.pagingEnabled = YES;
    
    [_collec_NEWS setShowsHorizontalScrollIndicator:NO];
//    [self.collec_NEWS setContentOffset:self.collec_NEWS.contentOffset animated:NO];
    self.collec_NEWS.bounces  = NO;
    self.collec_NEWS.alwaysBounceVertical = NO;
    self.collec_NEWS.pagingEnabled = YES;
    
    [_collec_Report setShowsHorizontalScrollIndicator:NO];
//    [self.collec_Report setContentOffset:self.collec_Report.contentOffset animated:NO];
    self.collec_Report.bounces  = NO;
    self.collec_Report.alwaysBounceVertical = NO;
//    self.collec_Report.pagingEnabled = YES;
    
    [_collec_writer setShowsHorizontalScrollIndicator:NO];
//    [self.collec_writer setContentOffset:self.collec_writer.contentOffset animated:NO];
    self.collec_writer.bounces  = NO;
    self.collec_writer.alwaysBounceVertical = NO;
//    self.collec_writer.pagingEnabled = YES;
    
    [_collec_Interview setShowsHorizontalScrollIndicator:NO];
//    [self.collec_Interview setContentOffset:self.collec_Interview.contentOffset animated:NO];
    self.collec_Interview.bounces  = NO;
    self.collec_Interview.alwaysBounceVertical = NO;
//    self.collec_Interview.pagingEnabled = YES;
//    [self setup_DATA];
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
            
//            NSLog(@"origin x = %f",VW_swipe.frame.origin.x);
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
            return @"مجلة E";
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
            return @"معلومات عنا";
            break;
        case 6:
            return @"اتصل بنا";
            break;
        case 7:
            return @"مجلس التحرير";
            break;
        case 8:
            return @"الأحكام والشروط";
            break;
        case 9:
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
    return [UIColor colorWithRed:0.47 green:0.00 blue:0.25 alpha:1.0];
}

-(UIColor *)colorForTitleLabelAtIndex:(int)index {
    return [UIColor colorWithWhite:1.0 alpha:0.85];
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
    
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
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
}

#pragma mark - Next VC Load
-(void) load_NEWS_VC
{
    News_local *controller = [[News_local alloc] initWithNibName:@"News_local" bundle:nil];
    controller.get_NAV_TITL = send_news_TITL;
    controller.get_News_titl = send_news_TITL;
    [self.navigationController pushViewController:controller animated:YES];
}



#pragma mark - LOAD DATA
-(void) setup_DATA
{
    [_widget_VW loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://widgets.datasportsgroup.com/carmatec/today_carmatec.php"]]];
    _widget_VW.scalesPageToFit = YES;
    
    [_widget_VW1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://widgets.datasportsgroup.com/carmatec/comp_carmatec.php"]]];
    _widget_VW1.scalesPageToFit = YES;
    
    if (contents) {
        NSArray *News = [localNews valueForKey:@"News"];
        _IMG_local_FOOTBALL.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@news/%@",IMAGE_URL,[News valueForKey:@"image"]]]]];
        _lbl_local_FOOTBALL.text = [NSString stringWithFormat:@"%@",[News valueForKey:@"title"]];
        ft_BAL_ID = [News valueForKey:@"id"];
        _lbl_local_FOOTBALL.numberOfLines = 0;
        
        NSArray *arb_FT_BALL = [contents valueForKey:@"arabnews"];
        NSArray *arb_news = [arb_FT_BALL valueForKey:@"News"];
        
        
        @try {
            _IMG_arb_FTBALL.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@news/%@",IMAGE_URL,[arb_news valueForKey:@"image"]]]]];
        } @catch (NSException *exception) {
            _IMG_arb_FTBALL.image = nil;
        }
        
        @try {
            _lbl_arb_FTBALL.text = [NSString stringWithFormat:@"%@",[arb_news valueForKey:@"title"]];
        } @catch (NSException *exception) {
            _lbl_arb_FTBALL.text = @"Not Mentioned";
        }
        
        @try {
            str_FT_BL = [arb_news valueForKey:@"id"];
        } @catch (NSException *exception) {
            NSLog(@"Exception %@",exception);
        }
        
        _lbl_arb_FTBALL.numberOfLines = 0;
        
        NSArray *intr_FTBALL;
        NSArray *Intr_ftBL_nws;
        @try {
            intr_FTBALL = [contents valueForKey:@"internationalNews"];
            @try {
                if ([intr_FTBALL valueForKey:@"News"] != 0) {
                    Intr_ftBL_nws = [intr_FTBALL valueForKey:@"News"];
                }
                
            } @catch (NSException *exception) {
                NSLog(@"Exception %@",exception);
            }
        } @catch (NSException *exception) {
            NSLog(@"Exception %@",exception);
        }
        
        
        
        @try {
            _IMG_INTR_FTBALL.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@news/%@",IMAGE_URL,[Intr_ftBL_nws valueForKey:@"image"]]]]];
        } @catch (NSException *exception) {
            _IMG_INTR_FTBALL.image = nil;
        }
        
        @try {
            _lbl_INTR_FTBALL.text = [NSString stringWithFormat:@"%@",[Intr_ftBL_nws valueForKey:@"title"]];
        } @catch (NSException *exception) {
            _lbl_INTR_FTBALL.text = @"Not Mentioned";
        }
        
        @try {
            STR_intR_BL = [Intr_ftBL_nws valueForKey:@"id"];
        } @catch (NSException *exception) {
            NSLog(@"Exception %@",exception);
        }
        
        _lbl_INTR_FTBALL.numberOfLines = 0;
        STR_intR_BL = [Intr_ftBL_nws valueForKey:@"id"];
        _lbl_INTR_FTBALL.numberOfLines = 0;
        
        NSArray *other_SPRT = [contents valueForKey:@"othersnews"];
        NSArray *other_NWS = [other_SPRT valueForKey:@"News"];
        
        _IMG_OTHR_SPT.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@news/%@",IMAGE_URL,[other_NWS valueForKey:@"image"]]]]];
        _lbl_OTHR_SPT.text = [NSString stringWithFormat:@"%@",[other_NWS valueForKey:@"title"]];
        STR_other_NS = [other_NWS valueForKey:@"id"];
        _lbl_OTHR_SPT.numberOfLines = 0;
        
        NSLog(@"Google Mobile Ads SDK version: %@", [DFPRequest sdkVersion]);
        
        GADRequest *request = [GADRequest request];
        //                    request.testDevices = @[@"b53627777feeb4f1d2d61a350a80514f"];
        _Ads_banner.adUnitID = @"ca-app-pub-8762774270996921/9236537494";
        _Ads_banner.rootViewController = self;
        [_Ads_banner loadRequest:request];
        
        _Ads_banner1.adUnitID = @"ca-app-pub-8762774270996921/9236537494";
        _Ads_banner1.rootViewController = self;
        [_Ads_banner1 loadRequest:request];
        
        if ([video count] != 0)
        {
            NSArray *play_video1 = [[video objectAtIndex:0] valueForKey:@"Video"];
            NSArray *embed_code1 = [[play_video1 valueForKey:@"embed_code"] componentsSeparatedByString:@"/"];
            NSString *video_ID1 = [NSString stringWithFormat:@"%@",[embed_code1 objectAtIndex:[embed_code1 count] - 1]];
            [_playerView loadWithVideoId:video_ID1];
        }
        
        if ([video count] > 1)
        {
            NSArray *play_video2 = [[video objectAtIndex:1] valueForKey:@"Video"];
            NSArray *embed_code2 = [[play_video2 valueForKey:@"embed_code"] componentsSeparatedByString:@"/"];
            NSString *video_ID2 = [NSString stringWithFormat:@"%@",[embed_code2 objectAtIndex:[embed_code2 count] - 1]];
            [_playerView1 loadWithVideoId:video_ID2];
        }
        
        if ([gallery count] != 0)
        {
            //        picture
            NSArray *temp = [[gallery objectAtIndex:0] valueForKey:@"Gallery"];
            _gallery1.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@picture/%@",IMAGE_URL,[temp valueForKey:@"image"]]]]];
        }
        
        if ([gallery count] > 1)
        {
            NSArray *temp = [[gallery objectAtIndex:1] valueForKey:@"Gallery"];
            _gallery2.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@picture/%@",IMAGE_URL,[temp valueForKey:@"image"]]]]];
        }
        
        if ([gallery count] > 2)
        {
            NSArray *temp = [[gallery objectAtIndex:2] valueForKey:@"Gallery"];
            _gallery3.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@picture/%@",IMAGE_URL,[temp valueForKey:@"image"]]]]];
        }
        
        if ([gallery count] > 3)
        {
            NSArray *temp = [[gallery objectAtIndex:3] valueForKey:@"Gallery"];
            _gallery4.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@picture/%@",IMAGE_URL,[temp valueForKey:@"image"]]]]];
        }
    }
    
    [_activityindicator stopAnimating];
    _VW_activity.hidden = YES;
}





#pragma mark : Collection View Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == _collec_1) {
        return [homeNewsSlider count];
    }
    else if (collectionView == _collec_NEWS)
    {
        return [latestnews count];
    }
    else if (collectionView == _collec_Interview)
    {
        return [homeinterviewslider count];
    }
    else if (collectionView == _collec_Report)
    {
        return [reports count];
    }
    else if (collectionView == _collec_writer)
    {
        return [writers count];
    }
    return 5;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == _collec_Interview || collectionView == _collec_Report || collectionView == _collec_writer) {
        return CGSizeMake(230, 160);
    }
    
    return CGSizeMake(self.navigationController.navigationBar.frame.size.width, 250);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _collec_1) {
        
        
        COLL_CELL_1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
        
        
        
//        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        [indicator startAnimating];
//        [indicator setCenter:cell.bg_IMG.center];
//        [cell.contentView addSubview:indicator];
        
        NSString *url_STR = [NSString stringWithFormat:@"%@news/%@",IMAGE_URL,[News_IMG objectAtIndex:indexPath.row]];
        

                        
       [cell.bg_IMG sd_setImageWithURL:[NSURL URLWithString:url_STR]
                                     placeholderImage:[UIImage imageNamed:@"Default.jpg"]];
                        

        
        cell.lbl_NAME.text = [title_IMG objectAtIndex:indexPath.row];
        cell.lbl_NAME.numberOfLines = 0;
        return cell;
    }
    else if (collectionView == _collec_NEWS)
    {
        News_COL_CELL *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewsCell" forIndexPath:indexPath];
//
//        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        [indicator startAnimating];
//        [indicator setCenter:cell.bg_IMG.center];
//        [cell.contentView addSubview:indicator];
        
        NSString *url_STR = [NSString stringWithFormat:@"%@news/%@",IMAGE_URL,[page_IMG_NWS objectAtIndex:indexPath.row]];
        
        [cell.bg_IMG sd_setImageWithURL:[NSURL URLWithString:url_STR]
                       placeholderImage:[UIImage imageNamed:@"Default.jpg"]];
        
        cell.lbl_NAME.text = [title_NWS objectAtIndex:indexPath.row];
        cell.lbl_NAME.numberOfLines = 0;
        
        return cell;
    }
    else if (collectionView == _collec_Interview)
    {
        Intr_COL_Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"InterviewCELL" forIndexPath:indexPath];
        
//        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        [indicator startAnimating];
//        [indicator setCenter:cell.bg_IMG.center];
//        [cell.contentView addSubview:indicator];
        
        NSString *url_STR = [NSString stringWithFormat:@"%@interview/%@",IMAGE_URL,[IMG_inter objectAtIndex:indexPath.row]];
        
        [cell.bg_IMG sd_setImageWithURL:[NSURL URLWithString:url_STR]
                       placeholderImage:[UIImage imageNamed:@"Default.jpg"]];
        
        cell.lbl_NAME.text = [titl_INTR objectAtIndex:indexPath.row];
        cell.lbl_NAME.numberOfLines = 0;
        
        return cell;
    }
    else if (collectionView == _collec_Report)
    {
        report_Col_CELL *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reportCollectionCell" forIndexPath:indexPath];
        
//        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        [indicator startAnimating];
//        [indicator setCenter:cell.bg_IMG.center];
//        [cell.contentView addSubview:indicator];
        
        NSString *url_STR = [NSString stringWithFormat:@"%@report/%@",IMAGE_URL,[IMG_Report objectAtIndex:indexPath.row]];
        
        [cell.bg_IMG sd_setImageWithURL:[NSURL URLWithString:url_STR]
                       placeholderImage:[UIImage imageNamed:@"Default.jpg"]];
        
        cell.lbl_NAME.text = [titl_Report objectAtIndex:indexPath.row];
        cell.lbl_NAME.numberOfLines = 0;
        
        return cell;
    }
    else if (collectionView == _collec_writer)
    {
        writer_Col_CELL *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"writerCollectionCell" forIndexPath:indexPath];
        
//        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        [indicator startAnimating];
//        [indicator setCenter:cell.bg_IMG.center];
//        [cell.contentView addSubview:indicator];
        
        NSString *url_STR = [NSString stringWithFormat:@"%@writer/%@",IMAGE_URL,[IMG_writer objectAtIndex:indexPath.row]];
        
        [cell.bg_IMG sd_setImageWithURL:[NSURL URLWithString:url_STR]
                       placeholderImage:[UIImage imageNamed:@"Default.jpg"]];
        
        cell.lbl_NAME.text = [titl_writer objectAtIndex:indexPath.row];
        cell.lbl_NAME.numberOfLines = 0;
        
        return cell;
    }

     UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*NSDictionary *temp_article = [[json_RESULT objectAtIndex:indexPath.row] valueForKey:@"Article"];
    Article_DETAIL_VC *controller = [[Article_DETAIL_VC alloc] initWithNibName:@"Article_DETAIL_VC" bundle:nil];
    controller.get_titl = get_NAV_TITL;
    controller.get_ID = [temp_article valueForKey:@"id"];
    [self.navigationController pushViewController:controller animated:YES];*/
    
    if (collectionView == _collec_1)
    {
        NEWS_datail_VC *controller = [[NEWS_datail_VC alloc] initWithNibName:@"NEWS_datail_VC" bundle:nil];
        controller.get_home = @"Home";
        controller.get_ID = [ID_news objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if (collectionView == _collec_NEWS)
    {
        NEWS_datail_VC *controller = [[NEWS_datail_VC alloc] initWithNibName:@"NEWS_datail_VC" bundle:nil];
        controller.get_home = @"Home";
        controller.get_ID = [ID_IMg_nWS objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (collectionView == _collec_Interview) {
        Interview_DETAIL *controller = [[Interview_DETAIL alloc] initWithNibName:@"Interview_DETAIL" bundle:nil];
        controller.get_ID = [ID_inTR objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (collectionView == _collec_Report)
    {
        Report_DETAIL_VC *controller = [[Report_DETAIL_VC alloc] initWithNibName:@"Report_DETAIL_VC" bundle:nil];
        controller.get_ID = [ID_report objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (collectionView == _collec_writer)
    {
        Article_DETAIL_VC *controller = [[Article_DETAIL_VC alloc] initWithNibName:@"Article_DETAIL_VC" bundle:nil];
        controller.get_home = @"Home";
        controller.get_ID = [ID_writer objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:controller animated:YES];
    }
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
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@homePage",MAIN_URL]];
    NSData *aData = [NSData dataWithContentsOfURL:url];
    
    if (aData) {
        contents = [NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        
        
        NSLog(@"Contecnts %@",contents);
        homeNewsSlider = [contents valueForKey:@"homeNewsSlider"];
        latestnews = [contents valueForKey:@"latestnews"];
        homeinterviewslider = [contents valueForKey:@"homeinterviewslider"];
        localNews = [contents valueForKey:@"localNews"];
        reports = [contents valueForKey:@"reports"];
        writers = [contents valueForKey:@"writer"];
        video = [contents valueForKey:@"Video"];
        gallery = [contents valueForKey:@"pictureList"];
        
        News_IMG = [[NSMutableArray alloc]init];
        title_IMG = [[NSMutableArray alloc]init];
        ID_news = [[NSMutableArray alloc]init];
        
        for (int i = 0; i < [homeNewsSlider count]; i++) {
            NSDictionary *tmp = [homeNewsSlider objectAtIndex:i];
            NSArray *val = [tmp valueForKey:@"News"];
            NSString *img_URL = [val valueForKey:@"image"];
            NSString *titl = [val valueForKey:@"title"];
            NSString *ID = [val valueForKey:@"id"];
            
            [News_IMG addObject:img_URL];
            [title_IMG addObject:titl];
            [ID_news addObject:ID];
        }
        
        page_IMG_NWS = [[NSMutableArray alloc]init];
        title_NWS = [[NSMutableArray alloc]init];
        ID_IMg_nWS = [[NSMutableArray alloc]init];
        
        for (int j = 0; j < [latestnews count]; j++) {
            NSDictionary *tmp = [latestnews objectAtIndex:j];
            NSArray *val = [tmp valueForKey:@"News"];
            NSString *img_URL = [val valueForKey:@"image"];
            NSString *titl = [val valueForKey:@"title"];
            NSString *ID = [val valueForKey:@"id"];
            
            [page_IMG_NWS addObject:img_URL];
            [title_NWS addObject:titl];
            [ID_IMg_nWS addObject:ID];
        }
        
        IMG_inter = [[NSMutableArray alloc] init];
        titl_INTR = [[NSMutableArray alloc] init];
        ID_inTR = [[NSMutableArray alloc] init];
        
        for (int k = 0; k < [homeinterviewslider count]; k++) {
            NSDictionary *tmp = [homeinterviewslider objectAtIndex:k];
            NSArray *val = [tmp valueForKey:@"Interview"];
            NSString *img_URL = [val valueForKey:@"image"];
            NSString *titl = [val valueForKey:@"title"];
            NSString *id_STR = [val valueForKey:@"id"];
            
            [IMG_inter addObject:img_URL];
            [titl_INTR addObject:titl];
            [ID_inTR addObject:id_STR];
        }
        
        IMG_Report = [[NSMutableArray alloc]init];
        titl_Report = [[NSMutableArray alloc]init];
        ID_report = [[NSMutableArray alloc] init];
        
        for (int l = 0; l < [reports count]; l++) {
            NSDictionary *tmp = [reports objectAtIndex:l];
            NSArray *val = [tmp valueForKey:@"Report"];
            NSString *img_URL = [val valueForKey:@"image"];
            NSString *titl = [val valueForKey:@"title"];
            NSString *id_STR = [val valueForKey:@"id"];
            
            [IMG_Report addObject:img_URL];
            [titl_Report addObject:titl];
            [ID_report addObject:id_STR];
        }
        
        IMG_writer = [[NSMutableArray alloc] init];
        titl_writer = [[NSMutableArray alloc] init];
        ID_writer = [[NSMutableArray alloc] init];
        
        for (int m = 0; m < [writers count]; m++) {
            NSDictionary *tmp = [writers objectAtIndex:m];
            NSArray *val = [tmp valueForKey:@"Writer"];
            NSArray *val1 = [tmp valueForKey:@"Article"];
            NSString *img_URL = [val valueForKey:@"photo"];
            NSString *titl = [val valueForKey:@"name"];
            NSString *id_STR = [val1 valueForKey:@"id"];
            
            [IMG_writer addObject:img_URL];
            [titl_writer addObject:titl];
            [ID_writer addObject:id_STR];
        }
        
        IMG_GAL = [[NSMutableArray alloc]init];
        titl_GAL = [[NSMutableArray alloc]init];
        
        for (int n = 0; n < [gallery count]; n++) {
            NSDictionary *tmp = [gallery objectAtIndex:n];
            NSArray *val = [tmp valueForKey:@"Gallery"];
            NSString *img_URL = [val valueForKey:@"image"];
            NSString *titl = [val valueForKey:@"title"];
            
            [IMG_GAL addObject:img_URL];
            [titl_GAL addObject:titl];
        }
        
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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

#pragma mark - Single Value
-(IBAction)Local_FTBALL:(id)sender
{    
    NEWS_datail_VC *controller = [[NEWS_datail_VC alloc] initWithNibName:@"NEWS_datail_VC" bundle:nil];
    controller.get_home = @"Home";
    controller.get_ID = ft_BAL_ID;
    [self.navigationController pushViewController:controller animated:YES];
}

-(IBAction)ARB_FTBL:(id)sender
{
    NEWS_datail_VC *controller = [[NEWS_datail_VC alloc] initWithNibName:@"NEWS_datail_VC" bundle:nil];
    controller.get_home = @"Home";
    controller.get_ID = str_FT_BL;
    [self.navigationController pushViewController:controller animated:YES];
}

-(IBAction)INTR_FTBL:(id)sender
{
    NEWS_datail_VC *controller = [[NEWS_datail_VC alloc] initWithNibName:@"NEWS_datail_VC" bundle:nil];
    controller.get_home = @"Home";
    controller.get_ID = STR_intR_BL;
    [self.navigationController pushViewController:controller animated:YES];
}

-(IBAction)Other_NWS:(id)sender
{
    NEWS_datail_VC *controller = [[NEWS_datail_VC alloc] initWithNibName:@"NEWS_datail_VC" bundle:nil];
    controller.get_home = @"Home";
    controller.get_ID = STR_other_NS;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Gallery Action
-(IBAction)BTN_gal1:(id)sender
{
    _VW_overlay.hidden = NO;
    
    index_PHOT = 0;
    
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator startAnimating];
    [indicator setCenter:_view_IMAGE.center];
    [_view_IMAGE addSubview:indicator];
    
    NSString *url_STR = [NSString stringWithFormat:@"%@picture/%@",IMAGE_URL,[IMG_GAL objectAtIndex:index_PHOT]];
    _pict_DETAIL.text = [NSString stringWithFormat:@"%@",[titl_GAL objectAtIndex:index_PHOT]];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url_STR] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [indicator removeFromSuperview];
                    
                    _view_IMAGE.image = image;
                    
                });
            }
        }
    }];
    [task resume];
}
-(IBAction)BTN_gal2:(id)sender
{
    _VW_overlay.hidden = NO;
    
    index_PHOT = 1;

    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator startAnimating];
    [indicator setCenter:_view_IMAGE.center];
    [_view_IMAGE addSubview:indicator];
    
    NSString *url_STR = [NSString stringWithFormat:@"%@picture/%@",IMAGE_URL,[IMG_GAL objectAtIndex:index_PHOT]];
    _pict_DETAIL.text = [NSString stringWithFormat:@"%@",[titl_GAL objectAtIndex:index_PHOT]];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url_STR] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [indicator removeFromSuperview];
                    
                    _view_IMAGE.image = image;
                    
                });
            }
        }
    }];
    [task resume];
}
-(IBAction)BTN_gal3:(id)sender
{
    _VW_overlay.hidden = NO;
    
    index_PHOT = 2;
    
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator startAnimating];
    [indicator setCenter:_view_IMAGE.center];
    [_view_IMAGE addSubview:indicator];
    
    NSString *url_STR = [NSString stringWithFormat:@"%@picture/%@",IMAGE_URL,[IMG_GAL objectAtIndex:index_PHOT]];
    _pict_DETAIL.text = [NSString stringWithFormat:@"%@",[titl_GAL objectAtIndex:index_PHOT]];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url_STR] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [indicator removeFromSuperview];
                    
                    _view_IMAGE.image = image;
                    
                });
            }
        }
    }];
    [task resume];
}
-(IBAction)BTN_gal4:(id)sender
{
    _VW_overlay.hidden = NO;
    
    index_PHOT = 3;
    
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator startAnimating];
    [indicator setCenter:_view_IMAGE.center];
    [_view_IMAGE addSubview:indicator];
    
    NSString *url_STR = [NSString stringWithFormat:@"%@picture/%@",IMAGE_URL,[IMG_GAL objectAtIndex:index_PHOT]];
    _pict_DETAIL.text = [NSString stringWithFormat:@"%@",[titl_GAL objectAtIndex:index_PHOT]];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url_STR] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [indicator removeFromSuperview];
                    
                    _view_IMAGE.image = image;
                    
                });
            }
        }
    }];
    [task resume];
}
- (void)didSwipe:(UISwipeGestureRecognizer*)swipe{
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"Swipe Left");
        //        [self.VW_photos shakeWithOptions:SCShakeOptionsDirectionHorizontal | SCShakeOptionsForceInterpolationNone | SCShakeOptionsAtEndContinue force:0.01 duration:0.01 iterationDuration:0.09 completionHandler:nil];
        
        if (index_PHOT != [IMG_GAL count] - 1) {
            index_PHOT = index_PHOT +1;
            [self showFromLeft];
        }
        else if (index_PHOT == [IMG_GAL count] - 1)
        {
            NSLog(@"Index Image = %d",index_PHOT);
            
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [indicator startAnimating];
            [indicator setCenter:_view_IMAGE.center];
            [_view_IMAGE addSubview:indicator];
            
            NSString *url_STR = [NSString stringWithFormat:@"%@picture/%@",IMAGE_URL,[IMG_GAL objectAtIndex:index_PHOT]];
            _pict_DETAIL.text = [NSString stringWithFormat:@"%@",[titl_GAL objectAtIndex:index_PHOT]];
            
            NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url_STR] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (data) {
                    UIImage *image = [UIImage imageWithData:data];
                    if (image) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [indicator removeFromSuperview];
                            
                            _view_IMAGE.image = image;
                            
                        });
                    }
                }
            }];
            [task resume];
        }
        
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"Swipe Right");
        
        if (index_PHOT == 0)
        {
            
            NSLog(@"Index Image = %d",index_PHOT);
            
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [indicator startAnimating];
            [indicator setCenter:_view_IMAGE.center];
            [_view_IMAGE addSubview:indicator];
            
            NSString *url_STR = [NSString stringWithFormat:@"%@picture/%@",IMAGE_URL,[IMG_GAL objectAtIndex:index_PHOT]];
            _pict_DETAIL.text = [NSString stringWithFormat:@"%@",[titl_GAL objectAtIndex:index_PHOT]];
            
            NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url_STR] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (data) {
                    UIImage *image = [UIImage imageWithData:data];
                    if (image) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [indicator removeFromSuperview];
                            
                            _view_IMAGE.image = image;
                            
                        });
                    }
                }
            }];
            [task resume];
        }
        else if (index_PHOT != 0)
        {
            index_PHOT = index_PHOT - 1;
            [self showFromRight];
        }
        
        
        
        
        
        //        [self.VW_photos shakeWithOptions:SCShakeOptionsDirectionHorizontal | SCShakeOptionsForceInterpolationNone | SCShakeOptionsAtEndContinue force:0.01 duration:0.01 iterationDuration:0.09 completionHandler:nil];
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"Swipe Up");
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"Swipe Down");
    }
}
#pragma mark - Presentation
- (void)showFromLeft
{
    NSLog(@"Index Image = %d",index_PHOT);
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator startAnimating];
    [indicator setCenter:_view_IMAGE.center];
    [_view_IMAGE addSubview:indicator];
    
    NSString *url_STR = [NSString stringWithFormat:@"%@picture/%@",IMAGE_URL,[IMG_GAL objectAtIndex:index_PHOT]];
    _pict_DETAIL.text = [NSString stringWithFormat:@"%@",[titl_GAL objectAtIndex:index_PHOT]];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url_STR] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [indicator removeFromSuperview];
                    
                    _view_IMAGE.image = image;
                    
                });
            }
        }
    }];
    [task resume];
    
    self.VW_photos.layer.opacity = 0.0f;
    self.VW_photos.center = CGPointMake(1.5 * self.VW_photos.frame.size.width, self.navigationController.view.center.y);
    self.VW_photos.transform = CGAffineTransformMakeRotation( 60 * M_PI / 180);
    [UIView animateWithDuration:0.5f animations:^{
        self.VW_photos.layer.opacity = 1.0f;
        self.VW_photos.transform = CGAffineTransformMakeRotation(0);
        self.VW_photos.center = self.navigationController.view.center;
    }];
}

- (void)showFromRight
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator startAnimating];
    [indicator setCenter:_view_IMAGE.center];
    [_view_IMAGE addSubview:indicator];
    
    NSString *url_STR = [NSString stringWithFormat:@"%@picture/%@",IMAGE_URL,[IMG_GAL objectAtIndex:index_PHOT]];
    _pict_DETAIL.text = [NSString stringWithFormat:@"%@",[titl_GAL objectAtIndex:index_PHOT]];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url_STR] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [indicator removeFromSuperview];
                    
                    _view_IMAGE.image = image;
                    
                });
            }
        }
    }];
    [task resume];
    
    self.VW_photos.layer.opacity = 0.0f;
    self.VW_photos.center = CGPointMake(-self.VW_photos.frame.size.width / 2, self.navigationController.view.center.y);
    self.VW_photos.transform = CGAffineTransformMakeRotation(- 60 * M_PI / 180);
    [UIView animateWithDuration:0.5f animations:^{
        self.VW_photos.layer.opacity = 1.0f;
        self.VW_photos.transform = CGAffineTransformMakeRotation(0);
        self.VW_photos.center = self.navigationController.view.center;
    }];
    
}
-(IBAction)close_action:(id)sender
{
    _VW_overlay.hidden = YES;
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
        NSComparisonResult result = [tempStr compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
        if (result == NSOrderedSame) {
            [searchResults addObject:tempStr];
        }
    }
}

#pragma mark - POLL
-(IBAction)BTN_Poll:(id)sender
{    
    Poll_VC *controller = [[Poll_VC alloc] initWithNibName:@"Poll_VC" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

@end


