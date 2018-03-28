//
//  Comments_VC.m
//  Estad
//
//  Created by Apple on 19/12/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import "Comments_VC.h"
#import "news_coment_CELL.h"
#import "NEWS_datail_VC.h"
#import "Article_DETAIL_VC.h"
#import "Interview_DETAIL.h"
#import "Report_DETAIL_VC.h"
#import "HomeController.h"
#import "Add_comment_VC.h"

@interface Comments_VC ()
{
//    NSMutableDictionary *json_DATA;
    NSMutableDictionary *get_comments;
    
    NSMutableArray *arr_CMT,*arr_ID,*arr_Name;
    NSDictionary *time_ago;
}

@end

@implementation Comments_VC

@synthesize get_titl1,get_ID1,get_home;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    for (UIViewController *controller in self.navigationController.viewControllers)
    {
        NSLog(@"View controller is %@",controller);
    }
    
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

#pragma mark - View Customisation
-(void) setup_VIEW
{
    NSLog(@"ID = %@ Home = %@ Title = %@",get_ID1,get_home,get_titl1);
        
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.44 green:0.00 blue:0.24 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero] ;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    // ^-Use UITextAlignmentCenter for older SDKs.
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"جميع التعليقات", @"");
    [label sizeToFit];
    self.navigationItem.titleView = label;
    
    
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
    
    UILabel *lbl_coment = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    lbl_coment.text = @"";
    lbl_coment.font = [UIFont fontWithName:@"FontAwesome" size:21.0f];
    lbl_coment.textColor = [UIColor whiteColor];
    UIButton *BTN_coment = [UIButton buttonWithType:UIButtonTypeCustom];
    [BTN_coment addSubview:lbl_coment];
    BTN_coment.frame = CGRectMake(0, 0, 40, 40);
    [BTN_coment addTarget:self action:@selector(leave_COMMENT) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar_SYNC = [[UIBarButtonItem alloc] initWithCustomView:BTN_coment];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -30;
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer,bar_SYNC,Nil]];
    
    int statusbar_HEIGHT = [UIApplication sharedApplication].statusBarFrame.size.height;
    self.navigationController.navigationBar.frame = CGRectMake(0,statusbar_HEIGHT,self.navigationController.navigationBar.frame.size.width,self.navigationController.navigationBar.frame.size.height);
    
    [self Decide_API];
}


#pragma mark - Decide API
-(void) Decide_API
{
    if ([get_home isEqualToString:@"News Detail"])
    {
        NSString *url_STRc = [NSString stringWithFormat:@"%@newsComments/%@",MAIN_URL,get_ID1];
        NSLog(@"Url Posted = %@",url_STRc);
        [self Api_Comments:url_STRc];
    }
    if ([get_home isEqualToString:@"Article Detail"]) {
        NSString *url_STRc = [NSString stringWithFormat:@"%@articleComments/%@",MAIN_URL,get_ID1];
        NSLog(@"Url Posted = %@",url_STRc);
        [self Api_Comments:url_STRc];
    }
    if ([get_home isEqualToString:@"Interview Detail"]) {
        NSString *url_STRc = [NSString stringWithFormat:@"%@interviewComments/%@",MAIN_URL,get_ID1];
        NSLog(@"Url Posted = %@",url_STRc);
        [self Api_Comments:url_STRc];
    }
    if ([get_home isEqualToString:@"Report Detail"])
    {
        NSString *url_STRc = [NSString stringWithFormat:@"%@reportsComments/%@",MAIN_URL,get_ID1];
        NSLog(@"Url Posted = %@",url_STRc);
        [self Api_Comments:url_STRc];
    }
}


#pragma mark - Api Comments
-(void) Api_Comments : (NSString *) url_STRc
{
    NSError *error = nil;
    NSURL *url = [NSURL URLWithString:url_STRc];
    NSData *aData = [NSData dataWithContentsOfURL:url];
    
    get_comments = (NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
   
    time_ago = [get_comments valueForKey:@"time_ago"];
    NSLog(@"values count = %lu\n Time ago = %@",(unsigned long)[get_comments count],time_ago);
    
    arr_CMT = [[NSMutableArray alloc] init];
    arr_Name = [[NSMutableArray alloc] init];
    arr_ID = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [get_comments count]-1 ; i++)
    {
        NSDictionary *temp = [get_comments valueForKey:[NSString stringWithFormat:@"%d",i]];
        NSDictionary *values = [temp valueForKey:@"Comment"];
        [arr_CMT addObject:[values valueForKey:@"comment"]];
        [arr_Name addObject:[values valueForKey:@"name"]];
        [arr_ID addObject:[values valueForKey:@"id"]];
    }
    
    [_tbl_comments reloadData];
}

#pragma mark - Navigation Controller Actions
-(void) back_ACTION
{
    NSLog(@"Back action");
    self.navigationController.navigationBar.hidden = YES;
    
    [self.navigationController popViewControllerAnimated:NO];
    
    /*for (UIViewController *controller in self.navigationController.viewControllers)
    {
        NSLog(@"View controller is %@",controller);
        if ([controller isKindOfClass:[NEWS_datail_VC class]])
        {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
        else
        {
            for (UIViewController *controller in self.navigationController.viewControllers)
            {
                if ([controller isKindOfClass:[Article_DETAIL_VC class]])
                {
                    [self.navigationController popToViewController:controller animated:YES];
                    break;
                }
                else
                {
                    for (UIViewController *controller in self.navigationController.viewControllers)
                    {
                        if ([controller isKindOfClass:[Interview_DETAIL class]])
                        {
                            [self.navigationController popToViewController:controller animated:YES];
                            break;
                        }
                        else
                        {
                            for (UIViewController *controller in self.navigationController.viewControllers)
                            {
                                if ([controller isKindOfClass:[Report_DETAIL_VC class]])
                                {
                                    [self.navigationController popToViewController:controller animated:YES];
                                    break;
                                }
                                else
                                {
                                    for (UIViewController *controller in self.navigationController.viewControllers)
                                    {
                                        if ([controller isKindOfClass:[HomeController class]])
                                        {
                                            [self.navigationController popToViewController:controller animated:YES];
                                            break;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
*/
    
}
-(void) leave_COMMENT
{
    NSLog(@"Leave Comment");
    
//    Add_comment_VC
    
    Add_comment_VC *controller = [[Add_comment_VC alloc]initWithNibName:@"Add_comment_VC" bundle:nil];
    controller.get_ID1 = get_ID1;
    controller.get_titl1 = get_titl1;
    controller.get_Home = get_home;
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - Tableview Data
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [get_comments count]-1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    news_coment_CELL *cell = (news_coment_CELL *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"news_coment_CELL" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSString *strte = [arr_CMT objectAtIndex:indexPath.row];
    NSDictionary *attribs = @{
                              NSForegroundColorAttributeName: [UIColor blackColor],
                              NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:15.0]
                              };
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString:strte
                                           attributes:attribs];
    
    cell.label_coment.attributedText = attributedText;
    cell.label_coment.numberOfLines = 0;
    [cell.label_coment sizeToFit];
    
    cell.label_name.text = [NSString stringWithFormat:@"%@ | %@",[arr_Name objectAtIndex:indexPath.row],[time_ago valueForKey:[arr_ID objectAtIndex:indexPath.row]]];
    
    
    [cell.label_coment setFrame:CGRectMake(cell.label_coment.frame.origin.x,cell.label_coment.frame.origin.y,300,cell.label_coment.frame.size.height)];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *strte = [arr_CMT objectAtIndex:indexPath.row];
    
    NSDictionary *attribs = @{
                              NSForegroundColorAttributeName: [UIColor blackColor],
                              NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:15.0]
                              };
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString:strte
                                           attributes:attribs];
    
    CGFloat width = 300;
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    size.height = ceilf(size.height);
    size.width  = ceilf(size.width);
    return size.height + 70;
}

@end
