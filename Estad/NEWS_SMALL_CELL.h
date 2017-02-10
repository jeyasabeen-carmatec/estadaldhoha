//
//  NEWS_SMALL_CELL.h
//  Estad
//
//  Created by Apple on 16/11/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NEWS_SMALL_CELL : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *image_VW;
@property (nonatomic, weak) IBOutlet UILabel *label_VW;
@property (nonatomic, weak) IBOutlet UILabel *label_time;
@property (nonatomic, weak) IBOutlet UILabel *label_visitor;

@property (nonatomic, weak) IBOutlet UIView *VW_cvr;

@end
