//
//  sEttings_VC.h
//  Estad
//
//  Created by Apple on 16/01/17.
//  Copyright © 2017 carmatec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollapseClick.h"

@interface sEttings_VC : UIViewController <CollapseClickDelegate, UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UIView *VW_Home;
    IBOutlet UIView *VW_News;
    IBOutlet UIView *VW_Articles;
    IBOutlet UIView *VW_Media;
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

//@property (nonatomic, strong) IBOutlet UILabel *lbl_disp_contents;
//@property (nonatomic, strong) IBOutlet UIScrollView *scroll_lbl;

#pragma mark - Search
@property (nonatomic, strong) IBOutlet UIView *VW_Serch;
@property (nonatomic, strong) IBOutlet UIView *VW_Serch_BAR;
@property (nonatomic, strong) IBOutlet UISearchBar *serch_BAR;
-(IBAction)BTN_close_SRCHT:(id)sender;
@property (nonatomic, strong) IBOutlet UITableView *list_DATA;


@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityindicator;
@property (strong, nonatomic) IBOutlet UIView *VW_activity;

#pragma mark - Switch Fuctionality
@property (strong, nonatomic) IBOutlet UISwitch *swtch_Notification;
@property (strong, nonatomic) IBOutlet UISwitch *swtch_Notification_sound;

@property (strong, nonatomic) IBOutlet UILabel *lbl_notification;
@property (strong, nonatomic) IBOutlet UILabel *lbl_notification_sound;

@end
