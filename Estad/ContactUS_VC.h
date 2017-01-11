//
//  ContactUS_VC.h
//  Estad
//
//  Created by Apple on 28/11/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollapseClick.h"

@interface ContactUS_VC : UIViewController <CollapseClickDelegate, UITableViewDataSource, UITableViewDelegate>
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

@property (nonatomic, strong) IBOutlet UIView *VW_swipe;
@property (readonly, nonatomic) int menyDraw_X,menuDraw_width;

@property (nonatomic, strong) IBOutlet UIView *overlayView;

@property (nonatomic, strong) IBOutlet UITableView *tbl_NEWS;
@property (nonatomic, strong) IBOutlet UITableView *tbl_ARTICLES;
@property (nonatomic, strong) IBOutlet UITableView *tbl_MEDIA;

@property (nonatomic, strong) IBOutlet UITableView *tbl_contact_US;

#pragma mark - Search
@property (nonatomic, strong) IBOutlet UIView *VW_Serch;
@property (nonatomic, strong) IBOutlet UIView *VW_Serch_BAR;
@property (nonatomic, strong) IBOutlet UISearchBar *serch_BAR;
-(IBAction)BTN_close_SRCHT:(id)sender;
@property (nonatomic, strong) IBOutlet UITableView *list_DATA;

@end
