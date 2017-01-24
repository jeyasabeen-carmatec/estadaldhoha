//
//  Report_DETAIL_VC.h
//  Estad
//
//  Created by Apple on 14/12/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lontext_LBL.h"

@interface Report_DETAIL_VC : UIViewController <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *lbl_CNTNT;
@property (nonatomic, weak) IBOutlet UILabel *lbl_date_E;
@property (nonatomic, weak) IBOutlet UIView *profile_VW;
@property (nonatomic, weak) IBOutlet UIScrollView *scroll_SCRN;
@property (nonatomic, weak) IBOutlet UIView *main_VW;
@property (nonatomic, weak) IBOutlet UIView *coment_VW;

@property (nonatomic, strong) NSString *get_titl;
@property (nonatomic, strong) NSString *get_ID;
@property (nonatomic, strong) NSString *get_Article_TITL;
@property (nonatomic, strong) NSString *get_News_titl;
@property (nonatomic, strong) NSString *get_Photo_titl;
@property (nonatomic, strong) NSString *get_Video_titl;

@property (nonatomic, strong) NSString *get_home;
@property (nonatomic, strong) NSString *get_Emagazine;
@property (nonatomic, strong) NSString *get_Editorial;
@property (nonatomic, strong) NSString *get_About_US;
@property (nonatomic, strong) NSString *get_ontact_US;
@property (nonatomic, strong) NSString *get_Article;


@property (nonatomic, weak) IBOutlet UIImageView *big_IMAGE;
@property (nonatomic, weak) IBOutlet UILabel *lbl_TIME;
@property (nonatomic, weak) IBOutlet UILabel *lbl_VIEWRS;

-(IBAction)go_BACK:(id)sender;

@property (nonatomic, weak) IBOutlet UIButton *add_COMMENT;
@property (nonatomic, weak) IBOutlet UIButton *view_COMMENT;


@property (nonatomic, weak) IBOutlet UIView *hold_BTN;
@property (nonatomic, weak) IBOutlet UILabel *lbl_comnt_STAT;

-(IBAction)share_Action:(id)sender;

@property (nonatomic, strong) IBOutlet UIView *overlay_VIW;
@property (nonatomic, strong) IBOutlet UIView *share_VW;

-(IBAction)close_Action:(id)sender;
-(IBAction)whatsAPP_Action:(id)sender;
-(IBAction)FB_SHARE:(id)sender;
-(IBAction)Tweet_BTN:(id)sender;
-(IBAction)GooglPLS:(id)sender;

@property (nonatomic, strong) IBOutlet UILabel *lbl_CMNT_head;
@property (nonatomic, strong) IBOutlet UILabel *lbl_CMNT_date;

@end
