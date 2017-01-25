//
//  News_local.h
//  Estad
//
//  Created by Apple on 15/11/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollapseClick.h"

@import GoogleMobileAds;

@interface News_local : UIViewController <CollapseClickDelegate, UITableViewDataSource, UITableViewDelegate>
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
    IBOutlet UIView *VW_POLL;
    IBOutlet CollapseClick *myCollapseClick;
}

@property (nonatomic, strong) IBOutlet UIView *VW_swipe;
@property (readonly, nonatomic) int menyDraw_X,menuDraw_width;

@property (nonatomic, strong) IBOutlet UIView *overlayView;

@property (nonatomic, strong) IBOutlet UITableView *tbl_NEWS;
@property (nonatomic, strong) IBOutlet UITableView *tbl_ARTICLES;
@property (nonatomic, strong) IBOutlet UITableView *tbl_MEDIA;
@property (nonatomic, strong) IBOutlet UITableView *tbl_CONTENTS;

@property (nonatomic, strong) NSString *get_NAV_TITL;
@property (nonatomic, strong) NSString *get_News_titl;

#pragma mark - Search
@property (nonatomic, strong) IBOutlet UIView *VW_Serch;
@property (nonatomic, strong) IBOutlet UIView *VW_Serch_BAR;
@property (nonatomic, strong) IBOutlet UISearchBar *serch_BAR;
-(IBAction)BTN_close_SRCHT:(id)sender;
@property (nonatomic, strong) IBOutlet UITableView *list_DATA;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityindicator;
@property (strong, nonatomic) IBOutlet UIView *VW_activity;

@end
