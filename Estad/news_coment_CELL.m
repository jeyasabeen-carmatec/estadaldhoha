//
//  news_coment_CELL.m
//  Estad
//
//  Created by Apple on 30/11/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import "news_coment_CELL.h"

@implementation news_coment_CELL

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGSize)preferredSize
{
    static NSValue *sizeBox = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Assumption: The XIB file name matches this UIView subclass name.
        NSString* nibName = NSStringFromClass(self);
        UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
        
        // Assumption: The XIB file only contains a single root UIView.
        UIView *rootView = [[nib instantiateWithOwner:nil options:nil] lastObject];
        
        sizeBox = [NSValue valueWithCGSize:rootView.frame.size];
    });
    return [sizeBox CGSizeValue];
}
@end
