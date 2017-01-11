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
        _lbl_content.textColor = [UIColor colorWithRed:0.47 green:0.00 blue:0.25 alpha:1.0];
    }
    else
    {
        _lbl_content.textColor = [UIColor colorWithRed:0.87 green:0.56 blue:0.64 alpha:1.0];
    }

    // Configure the view for the selected state
    UIView * selectedBackgroundView = [[UIView alloc] init];
    [selectedBackgroundView setBackgroundColor:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0]];
    [self setSelectedBackgroundView:selectedBackgroundView];
}

@end
