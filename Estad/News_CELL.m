//
//  News_CELL.m
//  Estad
//
//  Created by Mac Mini on 15/11/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import "News_CELL.h"

@implementation News_CELL

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        _lbl_content.textColor = [UIColor colorWithRed:0.31 green:0.20 blue:0.44 alpha:0.6];
    }
    else
    {
        _lbl_content.textColor = [UIColor colorWithRed:0.31 green:0.20 blue:0.44 alpha:1.0];
    }

    // Configure the view for the selected state
    UIView * selectedBackgroundView = [[UIView alloc] init];
    [selectedBackgroundView setBackgroundColor:[UIColor colorWithRed:0.89 green:0.88 blue:0.92 alpha:1.0]];
    [self setSelectedBackgroundView:selectedBackgroundView];
}

@end
