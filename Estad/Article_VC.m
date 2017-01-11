//
//  Article_VC.m
//  Estad
//
//  Created by Apple on 17/11/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import "Article_VC.h"
#import "article_CELL.h"
//#import "HomeController.h"
#import "New_Home_VC.h"
#import "News_CELL.h"
#import "articles_CELL.h"
#import "media_CELL.h"
#import "News_local.h"
#import "article_cell2.h"
#import "Article_DETAIL_VC.h"
#import "photos_VC.h"
#import "Videos_VC.h"
#import "ContactUS_VC.h"
#import "About_US_VC.h"
#import "Editorial_board_VC.h"
#import "E_magazine_VC.h"
#import "serch_CELL.h"
#import "NEWS_datail_VC.h"
#import "Report_DETAIL_VC.h"
#import "Interview_DETAIL.h"

#import "SDWebImage/UIImageView+WebCache.h"

@interface Article_VC ()
{
    NSString *str_URL;
    CGRect statusBarFrame1;
    NSArray *list_NEWS;
    NSArray *list_ARTICLES;
    NSArray *list_MEDIA;
    NSString *send_news_TITL;
    NSMutableArray *json_RESULT;
    
    
    NSMutableArray *ID_STR,*ID_model,*ID_nmae;
    
    NSMutableArray *searchResults;
    BOOL isSerching;
}

@end

@implementation Article_VC

@synthesize get_NAV_TITL,menuDraw_width,menyDraw_X,VW_swipe;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self.content_Collection registerClass:[article_CELL class] forCellWithReuseIdentifier:@"article_CELL"];
    
//    UINib *cellNib = [UINib nibWithNibName:@"article_CELL" bundle:nil];
//    [self.content_Collection registerNib:cellNib forCellWithReuseIdentifier:@"article_CELL"];
    
    myCollapseClick.CollapseClickDelegate = self;
    [myCollapseClick reloadCollapseClick];
    
    list_NEWS = [[NSArray alloc]initWithObjects:@"أخبار الدوريات المحلية",@"الدوريات الأخبار العربية",@"أخبار الدوريات العالمية",@"كل الأخبار", @"قطر 2022", @"أسباير زون", nil];
    list_ARTICLES = [[NSArray alloc]initWithObjects:@"محرر بلوق",@"مقالات استاد الدوحة", nil];
    list_MEDIA = [[NSArray alloc]initWithObjects:@"صور" ,@"فيديوهات", nil];
    
    self.navigationItem.hidesBackButton = YES;
    
    [self Decide_API];
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


#pragma mark - CollectionView Deligate
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return [json_RESULT count];
}
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0)
    {
        static NSString *identifier = @"cell_article";
        
        article_CELL *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        NSDictionary *temp_article,*temp_writer;
        @try {
            temp_article = [[json_RESULT objectAtIndex:indexPath.row] valueForKey:@"Article"];
        } @catch (NSException *exception) {
            NSLog(@"Exception1 = %@",exception);
        }
        
        @try {
            temp_writer = [[json_RESULT objectAtIndex:indexPath.row] valueForKey:@"Writer"];
        } @catch (NSException *exception) {
            NSLog(@"Exception2 = %@",exception);
        }
        
        
        
//        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        [indicator startAnimating];
//        [indicator setCenter:cell.bg_IMG.center];
//        [cell.contentView addSubview:indicator];
        
        NSString *url_STR = [NSString stringWithFormat:@"%@writer/%@",IMAGE_URL,[temp_writer valueForKey:@"photo"]];
        
        [cell.bg_IMG sd_setImageWithURL:[NSURL URLWithString:url_STR]
                       placeholderImage:[UIImage imageNamed:@"Default.jpg"]];
        
        cell.text_LBL.text = [NSString stringWithFormat:@"%@",[temp_article valueForKey:@"title"]];
        cell.text_LBL.numberOfLines = 2;
        
        cell.text_time.text = [NSString stringWithFormat:@"%@",[temp_article valueForKey:@"release_time"]];
        cell.text_viewers.text = [NSString stringWithFormat:@"%@",[temp_article valueForKey:@"visitor"]];
//        [cell.text_LBL sizeToFit]; release_time
        
        
        
        return cell;
    }
    else
    {
        static NSString *identifier = @"cell2";
        
        article_cell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        NSDictionary *temp_article,*temp_writer;
        @try {
            temp_article = [[json_RESULT objectAtIndex:indexPath.row] valueForKey:@"Article"];
        } @catch (NSException *exception) {
            NSLog(@"Exception1 = %@",exception);
        }
        
        @try {
            temp_writer = [[json_RESULT objectAtIndex:indexPath.row] valueForKey:@"Writer"];
        } @catch (NSException *exception) {
            NSLog(@"Exception2 = %@",exception);
        }
        
        
        
//        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        [indicator startAnimating];
//        [indicator setCenter:cell.bg_IMG.center];
//        [cell.contentView addSubview:indicator];
        
        NSString *url_STR = [NSString stringWithFormat:@"%@writer/%@",IMAGE_URL,[temp_writer valueForKey:@"photo"]];
        
        [cell.bg_IMG sd_setImageWithURL:[NSURL URLWithString:url_STR]
                         placeholderImage:[UIImage imageNamed:@"Default.jpg"]];
        
        
        cell.text_LBL.text = [NSString stringWithFormat:@"%@",[temp_article valueForKey:@"title"]];
        cell.text_LBL.numberOfLines = 3;
//        [cell.text_LBL sizeToFit];
        
        
        cell.text_time.text = [NSString stringWithFormat:@"%@",[temp_article valueForKey:@"release_time"]];
        cell.text_viewers.text = [NSString stringWithFormat:@"%@",[temp_article valueForKey:@"visitor"]];
        
        return cell;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *temp_article = [[json_RESULT objectAtIndex:indexPath.row] valueForKey:@"Article"];
    Article_DETAIL_VC *controller = [[Article_DETAIL_VC alloc] initWithNibName:@"Article_DETAIL_VC" bundle:nil];
    controller.get_titl = get_NAV_TITL;
    controller.get_ID = [temp_article valueForKey:@"id"];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark - UICollectionViewFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    int currentWidth = self.navigationController.navigationBar.frame.size.width;
//    
//    UIEdgeInsets sectionInset = [(UICollectionViewFlowLayout *)collectionView.collectionViewLayout sectionInset];
    int fixedWidth = collectionView.layer.frame.size.width;//currentWidth - (sectionInset.left + sectionInset.right);
    
    if (indexPath.row == 0) {
        return CGSizeMake(fixedWidth - 15, 300);
    }
    else
    {
        CGSize calCulateSizze;
        calCulateSizze.width = fixedWidth/2.0f - 12.0f;
        calCulateSizze.height = 250.0f;
        return calCulateSizze;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 8, 0, 8);
    
    
    
//    UIEdgeInsets UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);

}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5.0;
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

#pragma mark - View Customisation
-(void) setup_VIEW
{
    //    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.44 green:0.00 blue:0.24 alpha:1.0]];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.44 green:0.00 blue:0.24 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    
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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    // ^-Use UITextAlignmentCenter for older SDKs.
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(get_NAV_TITL, @"");
    [label sizeToFit];
    self.navigationItem.titleView = label;
//    [label release];
    
    int statusbar_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
    self.navigationController.navigationBar.frame = CGRectMake(0,statusbar_HEIGHT,self.navigationController.navigationBar.frame.size.width,self.navigationController.navigationBar.frame.size.height);
    
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
        
        if (_overlayView.hidden == NO)
        {
            _overlayView.hidden = YES;
        }
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
        
//        HomeController *controller = [[HomeController alloc] initWithNibName:@"HomeController" bundle:nil];
        New_Home_VC *controller = [[New_Home_VC alloc] initWithNibName:@"New_Home_VC" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
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
        
        E_magazine_VC *controller = [[E_magazine_VC alloc] initWithNibName:@"E_magazine_VC" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
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
        
        About_US_VC *controller = [[About_US_VC alloc] initWithNibName:@"About_US_VC" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
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
        
        ContactUS_VC *controller = [[ContactUS_VC alloc] initWithNibName:@"ContactUS_VC" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
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
        
        Editorial_board_VC *controller = [[Editorial_board_VC alloc] initWithNibName:@"Editorial_board_VC" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
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
    NSLog(@"Tap detected at index path %ld",(long)indexPath.row);
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
            controller.get_Article = @"Article";
            controller.get_ID = index_ID;
            controller.get_titl = get_NAV_TITL;
            [self.navigationController pushViewController:controller animated:YES];
        }
        else if ([model_Name isEqualToString:@"Report"])
        {
            Report_DETAIL_VC *controller = [[Report_DETAIL_VC alloc] initWithNibName:@"Report_DETAIL_VC" bundle:nil];
            controller.get_Article = @"Article";
            controller.get_ID = index_ID;
            controller.get_titl = get_NAV_TITL;
            [self.navigationController pushViewController:controller animated:YES];
        }
        else if ([model_Name isEqualToString:@"Interview"])
        {
            Interview_DETAIL *controller = [[Interview_DETAIL alloc] initWithNibName:@"Interview_DETAIL" bundle:nil];
            controller.get_Article = @"Article";
            controller.get_ID = index_ID;
            controller.get_titl = get_NAV_TITL;
            [self.navigationController pushViewController:controller animated:YES];
        }
        else
        {
            Article_DETAIL_VC *controller = [[Article_DETAIL_VC alloc] initWithNibName:@"Article_DETAIL_VC" bundle:nil];
            controller.get_ID = index_ID;
            controller.get_titl = get_NAV_TITL;
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


#pragma mark -Api INtegration
-(void) Decide_API
{
    if ([get_NAV_TITL isEqualToString:@"محرر بلوق"]) {
//        NSLog(@"Call News local patrols API");
        str_URL = [NSString stringWithFormat:@"%@articleList/1/20/%@",MAIN_URL,[self getUTCFormateDate:[NSDate date]]];
        [self get_DATA];
    }
    else if ([get_NAV_TITL isEqualToString:@"مقالات استاد الدوحة"])
    {
//        NSLog(@"Call News Arabic periodicals API");
        str_URL = [NSString stringWithFormat:@"%@articleList/2/20/%@",MAIN_URL,[self getUTCFormateDate:[NSDate date]]];
        [self get_DATA];
    }
}
-(void) get_DATA
{
    NSError *error;
//    NSLog(@"str_URL = %@",str_URL);
    NSURL *url = [NSURL URLWithString:str_URL];
    NSData *aData = [NSData dataWithContentsOfURL:url];
    NSMutableDictionary *json_DICTIN = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
    
    //    NSLog(@"Ou json response = %@",[json_DICTIN valueForKey:@"result"]);
    
    NSString *str = [NSString stringWithFormat:@"%@",[json_DICTIN valueForKey:@"result"]];
    
    if ([str isEqualToString:@"0"]) {
        json_RESULT = [[NSMutableArray alloc]init];
    }
    else
    {
        json_RESULT = [[NSMutableArray alloc]init];
        json_RESULT = [json_DICTIN valueForKey:@"result"];
    }
}

#pragma mark - UTC
-(NSString *)getUTCFormateDate:(NSDate *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //    NSString *dateString = [dateFormatter stringFromDate:localDate];
    return @"2016-05-05";
    //    return dateString;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.content_Collection.collectionViewLayout invalidateLayout];
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

@end
