//
//  article_CELL.h
//  Estad
//
//  Created by Apple on 17/11/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface article_CELL : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *text_LBL;
@property (strong, nonatomic) IBOutlet UIImageView *bg_IMG;

@property (strong, nonatomic) IBOutlet UIView *BG_VW;

@property (strong, nonatomic) IBOutlet UILabel *text_time;
@property (strong, nonatomic) IBOutlet UILabel *text_viewers;

@end
