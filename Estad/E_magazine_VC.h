//
//  E_magazine_VC.h
//  Estad
//
//  Created by Apple on 15/12/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollapseClick.h"

@interface E_magazine_VC : UIViewController <CollapseClickDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate,UITextFieldDelegate>
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

@property (nonatomic, strong) IBOutlet UIScrollView *scroll_CNTNT;
@property (nonatomic, strong) IBOutlet UIView *VW_Content;
@property (nonatomic, strong) IBOutlet UICollectionView *COL_contnt;

#pragma mark - Magazine Filter
-(IBAction)BTN_submit:(id)sender;
-(IBAction)BTN_Cancel:(id)sender;
-(IBAction)BTN_Year:(id)sender;
-(IBAction)BTN_Month:(id)sender;

@property (nonatomic, strong) IBOutlet UILabel *lbl_YEar;
@property (nonatomic, strong) IBOutlet UILabel *lbl_Month;

@property (strong, nonatomic) IBOutlet UITextField *txt_SRCH;

@property (strong, nonatomic) IBOutlet UITableView *list_Year;
@property (strong, nonatomic) IBOutlet UITableView *list_Month;

#pragma mark - Search
@property (nonatomic, strong) IBOutlet UIView *VW_Serch;
@property (nonatomic, strong) IBOutlet UIView *VW_Serch_BAR;
@property (nonatomic, strong) IBOutlet UISearchBar *serch_BAR;
-(IBAction)BTN_close_SRCHT:(id)sender;
@property (nonatomic, strong) IBOutlet UITableView *list_DATA;

@end
