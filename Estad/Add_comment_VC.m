//
//  Add_comment_VC.m
//  Estad
//
//  Created by Apple on 19/12/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import "Add_comment_VC.h"
#import "NEWS_datail_VC.h"

@interface Add_comment_VC ()
{
    UIToolbar *keybord_TOOLBAR;
}

@end

@implementation Add_comment_VC
@synthesize get_ID1,get_titl1,get_comments,get_Home,get_nav_STAT;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationItem setHidesBackButton:YES];
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
    label.text = NSLocalizedString(@"Leave A Comment", @"");
    [label sizeToFit];
    self.navigationItem.titleView = label;
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -30;
    
    UILabel *lbl_coment = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    lbl_coment.text = @"";
    lbl_coment.font = [UIFont fontWithName:@"FontAwesome" size:21.0f];
    lbl_coment.textColor = [UIColor whiteColor];
    UIButton *BTN_coment = [UIButton buttonWithType:UIButtonTypeCustom];
    [BTN_coment addSubview:lbl_coment];
    BTN_coment.frame = CGRectMake(0, 0, 40, 40);
    [BTN_coment addTarget:self action:@selector(leave_COMMENT) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar_SYNC = [[UIBarButtonItem alloc] initWithCustomView:BTN_coment];
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer,bar_SYNC,Nil]];
    
    UILabel *lbl_back = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    lbl_back.text = @"";
    lbl_back.font = [UIFont fontWithName:@"FontAwesome" size:21.0f];
    lbl_back.textColor = [UIColor whiteColor];
    UIButton *BTN_back = [UIButton buttonWithType:UIButtonTypeCustom];
    [BTN_back addSubview:lbl_back];
    BTN_back.frame = CGRectMake(0, 0, 40, 40);
    
    [BTN_back addTarget:self action:@selector(back_ACTION) forControlEvents:UIControlEventTouchUpInside];

    
    UIBarButtonItem *bar_btn_back = [[UIBarButtonItem alloc]initWithCustomView:BTN_back];
    
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:bar_btn_back,Nil]];
    
    int statusbar_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
    self.navigationController.navigationBar.frame = CGRectMake(0,statusbar_HEIGHT,self.navigationController.navigationBar.frame.size.width,self.navigationController.navigationBar.frame.size.height);
    
    _VW_holer.backgroundColor = [UIColor clearColor];
    _VW_holer.layer.borderWidth = 1.0f;
    _VW_holer.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    _VW_holer.layer.masksToBounds = NO;
    _VW_holer.layer.cornerRadius = 5.0f;
    
    keybord_TOOLBAR = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    //    keybord_TOOLBAR.barStyle = UIBarStyleBlackTranslucent;
    keybord_TOOLBAR.backgroundColor = [UIColor colorWithRed:0.922 green:0.922 blue:0.922 alpha:1];
    keybord_TOOLBAR.items = [NSArray arrayWithObjects:
                             [[UIBarButtonItem alloc]initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(cancel_TOOLBAR)],
                             [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                             [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done_TOOLBAR)],
                             nil];
    [keybord_TOOLBAR sizeToFit];
    _GET_contents.inputAccessoryView = keybord_TOOLBAR;
    
}

#pragma mark - TOOL BAR ACTIONS
-(void) cancel_TOOLBAR
{
    [_GET_contents resignFirstResponder];
    _GET_contents.text = @"";
//    _GET_addr.textColor = [UIColor colorWithRed:0.835 green:0.835 blue:0.835 alpha:1];
}

-(void) done_TOOLBAR
{
    [_GET_contents resignFirstResponder];
//    NSString *temp_str = [NSString stringWithFormat:@"%@",_GET_contents.text];
//    if (temp_str.length == 0)
//    {
//        _GET_addr.text = @"Address";
//        _GET_addr.textColor = [UIColor colorWithRed:0.835 green:0.835 blue:0.835 alpha:1];
//    }
//    else if ([temp_str isEqualToString:@"Address"])
//    {
//        _GET_addr.text = @"Address";
//        _GET_addr.textColor = [UIColor colorWithRed:0.835 green:0.835 blue:0.835 alpha:1];
//    }
//    else
//    {
//        _GET_addr.textColor = [UIColor blackColor];
//    }
}


#pragma mark - Navigation Controller Actions
-(void) back_ACTION
{
    NSLog(@"Back action");
//
    
    if (get_nav_STAT) {
        self.navigationController.navigationBar.hidden = YES;
    }
    
    [[self navigationController] popViewControllerAnimated:NO];
}


-(void) leave_COMMENT
{
    NSLog(@"The Model = %@ Id = %@",get_Home,get_ID1);
    
    NSString *model_ID;
    
    if ([get_Home isEqualToString:@"News Detail"])
    {
        model_ID = @"1";
    }
    else if ([get_Home isEqualToString:@"Article Detail"])
    {
        model_ID = @"2";
    }
    else if ([get_Home isEqualToString:@"Interview Detail"])
    {
        model_ID = @"3";
    }
    else if ([get_Home isEqualToString:@"Report Detail"])
    {
        model_ID = @"4";
    }
    
//    http://192.64.84.166/estad/Apis/addComments?name=test&email=test@gmail.com&comment=comment&id=78&modelId=1
    
    NSString *name = [NSString stringWithFormat:@"%@",_GET_name.text];
    NSString *email = [NSString stringWithFormat:@"%@",_GET_email.text];
    NSString *comment = [NSString stringWithFormat:@"%@",_GET_contents.text];
    
    NSString *url_STR = [NSString stringWithFormat:@"%@addComments?name=%@&email=%@&comment=%@&id=%@&modelId=%@",MAIN_URL,name,email,comment,get_ID1,model_ID];
    url_STR = [url_STR stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSLog(@"Post Url %@",url_STR);
    
    NSError *error = nil;
//    NSURL *url = [NSURL URLWithString:url_STR];
    NSData *aData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url_STR]];
    
    if (aData)
    {
        NSMutableDictionary *out_JSON = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        
        NSString *suc = [out_JSON valueForKey:@"success"];
        
        int stat = [suc intValue];
        
        if (stat == 1)
             {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Success" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                 [alert show];
             }
        [self back_ACTION];
    }
    
}

#pragma masrk - Text field Deligate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

#pragma mark - Textview Deligate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    //Keyboard becomes visible
    [UIView beginAnimations:nil context:NULL];
    // [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(0,-80,self.view.frame.size.width,self.view.frame.size.height);
    [UIView commitAnimations];
    //    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    //keyboard will hide
    [UIView beginAnimations:nil context:NULL];
    // [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(0,self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height,self.view.frame.size.width ,self.view.frame.size.height);
    [UIView commitAnimations];
}

@end
