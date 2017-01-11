//
//  Poll_VC.h
//  Estad
//
//  Created by Apple on 19/12/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Poll_VC : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *lbl_QSTN;
@property (nonatomic, strong) IBOutlet UIButton *btn_SUBMIT;

@property (nonatomic, strong) IBOutlet UIView *VW_YES;
@property (nonatomic, strong) IBOutlet UIView *VW_YES_SUB;
-(IBAction)BTN_YES:(id)sender;

@property (nonatomic, strong) IBOutlet UIView *VW_NO;
@property (nonatomic, strong) IBOutlet UIView *VW_NO_SUB;
-(IBAction)BTN_NO:(id)sender;

#pragma mark - YES/NO
@property (nonatomic, strong) IBOutlet UILabel *lbl_OPTN_YS;
@property (nonatomic, strong) IBOutlet UILabel *lbl_OPTN_NO;
@property (nonatomic, strong) IBOutlet UILabel *lbl_OPTN_til;

@property (nonatomic, strong) IBOutlet UILabel *lbl_Yes;
@property (nonatomic, strong) IBOutlet UILabel *lbl_NO;

@property (nonatomic, strong) IBOutlet UIView *VW_PER_S;
@property (nonatomic, strong) IBOutlet UIView *VW_PER_N;

@property (nonatomic, strong) IBOutlet UILabel *lbl_side_Y;
@property (nonatomic, strong) IBOutlet UILabel *lbl_side_N;

@end
