//
//  HomeController.h
//  Estad
//
//  Created by carmatec on 28/10/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIView.h>
#import "CollapseClick.h"

#pragma mark - Display Google ADS
@import GoogleMobileAds;

#pragma mark - Youtube Video
#import "YTPlayerView.h"

@interface HomeController : UIViewController <CollapseClickDelegate, UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate>
{
    IBOutlet UIView *VW_Home;
    IBOutlet UIView *VW_News;
    IBOutlet UIView *VW_Articles;
    IBOutlet UIView *VW_Media;
//    IBOutlet UIView *VW_Pictures;
//    IBOutlet UIView *VW_Videos;
    IBOutlet UIView *VW_About_US;
    IBOutlet UIView *VW_Contact_US;
    IBOutlet UIView *VW_Editorial;
    IBOutlet UIView *VW_Emagazine;
    IBOutlet UIView *VW_Settings;
    IBOutlet CollapseClick *myCollapseClick;
}

@property (strong, nonatomic) IBOutlet DFPBannerView *Ads_banner; // Google ADS
@property (strong, nonatomic) IBOutlet DFPBannerView *Ads_banner1;

@property(nonatomic, strong) IBOutlet YTPlayerView *playerView; //Youtube Video
@property(nonatomic, strong) IBOutlet YTPlayerView *playerView1;

@property (nonatomic, strong) IBOutlet UIView *VW_swipe;
@property (readonly, nonatomic) int menyDraw_X,menuDraw_width;

@property (nonatomic, strong) IBOutlet UIView *overlayView;

@property (nonatomic, strong) IBOutlet UITableView *tbl_NEWS;
@property (nonatomic, strong) IBOutlet UITableView *tbl_ARTICLES;
@property (nonatomic, strong) IBOutlet UITableView *tbl_MEDIA;


@property (nonatomic, strong) IBOutlet UIScrollView *scroll_contNT;

@property (nonatomic, strong) IBOutlet UIView *VW_Contents;

@property (nonatomic, strong) IBOutlet UIWebView *widget_VW;
@property (nonatomic, strong) IBOutlet UIWebView *widget_VW1;

#pragma mark - SIGLE VAL
@property (nonatomic, strong) IBOutlet UIImageView *IMG_local_FOOTBALL;
@property (nonatomic, strong) IBOutlet UILabel *lbl_local_FOOTBALL;
@property (nonatomic, strong) IBOutlet UIImageView *IMG_arb_FTBALL;
@property (nonatomic, strong) IBOutlet UILabel *lbl_arb_FTBALL;
@property (nonatomic, strong) IBOutlet UIImageView *IMG_INTR_FTBALL;
@property (nonatomic, strong) IBOutlet UILabel *lbl_INTR_FTBALL;
@property (nonatomic, strong) IBOutlet UIImageView *IMG_OTHR_SPT;
@property (nonatomic, strong) IBOutlet UILabel *lbl_OTHR_SPT;

#pragma mark - Action Single-VAL
-(IBAction)Local_FTBALL:(id)sender;
-(IBAction)ARB_FTBL:(id)sender;
-(IBAction)INTR_FTBL:(id)sender;
-(IBAction)Other_NWS:(id)sender;

#pragma mark - COllection Views
@property (nonatomic, strong) IBOutlet UICollectionView *collec_1;
@property (nonatomic, strong) IBOutlet UICollectionView *collec_NEWS;
@property (nonatomic, strong) IBOutlet UICollectionView *collec_Interview;
@property (nonatomic, strong) IBOutlet UICollectionView *collec_Report;
@property (nonatomic, strong) IBOutlet UICollectionView *collec_writer;


#pragma mark - Gallery
@property (nonatomic, strong) IBOutlet UIImageView *gallery1;
@property (nonatomic, strong) IBOutlet UIImageView *gallery2;
@property (nonatomic, strong) IBOutlet UIImageView *gallery3;
@property (nonatomic, strong) IBOutlet UIImageView *gallery4;

-(IBAction)BTN_gal1:(id)sender;
-(IBAction)BTN_gal2:(id)sender;
-(IBAction)BTN_gal3:(id)sender;
-(IBAction)BTN_gal4:(id)sender;

@property (nonatomic, strong) IBOutlet UIView *VW_overlay;
@property (nonatomic, strong) IBOutlet UIView *VW_photos;
@property (nonatomic, strong) IBOutlet UIImageView *view_IMAGE;
@property (nonatomic, strong) IBOutlet UILabel *pict_DETAIL;
-(IBAction)close_action:(id)sender;

#pragma mark - Search
@property (nonatomic, strong) IBOutlet UIView *VW_Serch;
@property (nonatomic, strong) IBOutlet UIView *VW_Serch_BAR;
@property (nonatomic, strong) IBOutlet UISearchBar *serch_BAR;
-(IBAction)BTN_close_SRCHT:(id)sender;
//@property (nonatomic, strong) IBOutlet UIView *searchBarView;
@property (nonatomic, strong) IBOutlet UITableView *list_DATA;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityindicator;
@property (strong, nonatomic) IBOutlet UIView *VW_activity;

#pragma mark - Poll
-(IBAction)BTN_Poll:(id)sender;

// IDE Integration Test
@end
