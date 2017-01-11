//
//  Comments_VC.h
//  Estad
//
//  Created by Apple on 19/12/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Comments_VC : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSString *get_titl1;
@property (nonatomic, strong) NSString *get_ID1;
@property (nonatomic, strong) NSString *get_home;

@property (nonatomic, strong) IBOutlet UITableView *tbl_comments;

@end
