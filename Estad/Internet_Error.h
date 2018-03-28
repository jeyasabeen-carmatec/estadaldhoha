//
//  Internet_Error.h
//  Estad
//
//  Created by Test User on 22/02/17.
//  Copyright © 2017 carmatec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Internet_Error : UIViewController

@property (nonatomic, retain) IBOutlet UIView *VW_Alert;

@property (nonatomic, retain) IBOutlet UIButton *BTN_cancel;
@property (nonatomic, retain) IBOutlet UIButton *BTN_retry;

@property (nonatomic, retain) IBOutlet UILabel *lbl_titl;
@property (nonatomic, retain) IBOutlet UILabel *lbl_content;

@end
