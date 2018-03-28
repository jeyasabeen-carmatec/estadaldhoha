//
//  video_VC_cell.h
//  Estad
//
//  Created by Apple on 21/11/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface video_VC_cell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *bg_IMG;

@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;

@end
