//
//  Add_comment_VC.h
//  Estad
//
//  Created by Apple on 19/12/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Add_comment_VC : UIViewController <UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic, strong) NSString *get_titl1;
@property (nonatomic, strong) NSString *get_ID1;
@property (nonatomic, strong) NSString *get_Home;

@property (nonatomic, strong) NSString *get_nav_STAT;

@property (nonatomic, strong) NSArray *get_comments;

@property (nonatomic, strong) IBOutlet UIView *VW_holer;
@property (nonatomic, strong) IBOutlet UITextField *GET_name;
@property (nonatomic, strong) IBOutlet UITextField *GET_email;
@property (nonatomic, strong) IBOutlet UITextView *GET_contents;

@end
