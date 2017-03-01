//
//  Internet_Error.m
//  Estad
//
//  Created by Test User on 22/02/17.
//  Copyright © 2017 carmatec. All rights reserved.
//

#import "Internet_Error.h"

@interface Internet_Error ()

@end

@implementation Internet_Error


-(void) viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

-(void) setup_VIEW
{
//    CGRect new_Frame = [UIScreen mainScreen].bounds;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.44 green:0.00 blue:0.24 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    // ^-Use UITextAlignmentCenter for older SDKs.
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"خطأ في الإتصال", @"");
    [label sizeToFit];
    self.navigationItem.titleView = label;
    
    _VW_Alert.center = self.view.center;
    _VW_Alert.layer.cornerRadius = 5.0f;
    _VW_Alert.layer.masksToBounds = YES;
    _VW_Alert.layer.borderWidth = 2.0f;
    _VW_Alert.backgroundColor = [UIColor whiteColor];
    _VW_Alert.layer.borderColor = [UIColor colorWithRed:0.44 green:0.00 blue:0.24 alpha:1.0].CGColor;
    
//    _lbl_content.center = _VW_Alert.center;
    
    _lbl_titl.backgroundColor = [UIColor colorWithRed:0.44 green:0.00 blue:0.24 alpha:1.0];
    
    _BTN_retry.layer.cornerRadius = 5.0f;
    _BTN_retry.layer.masksToBounds = YES;
    [_BTN_retry addTarget:self action:@selector(retry_btn) forControlEvents:UIControlEventTouchUpInside];
    
    _BTN_cancel.layer.cornerRadius = 5.0f;
    _BTN_cancel.layer.masksToBounds = YES;
    _BTN_cancel.layer.borderWidth = 1.0f;
    _BTN_cancel.layer.borderColor = [UIColor colorWithRed:0.47 green:0.0 blue:0.25 alpha:1.0].CGColor;
    [_BTN_cancel addTarget:self action:@selector(actn_cancel) forControlEvents:UIControlEventTouchUpInside];
}

-(void) actn_cancel
{
    exit(0);
}

-(void) retry_btn
{
    NSData *aData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",FILE_URL]]];
    if (aData)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"يرجى التحقق من إعدادات الاتصال بالإنترنت" delegate:self cancelButtonTitle:nil otherButtonTitles:@"حسنا", nil];
        [alert show];
    }
    
}

@end
