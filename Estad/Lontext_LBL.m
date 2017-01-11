//
//  Lontext_LBL.m
//  UnoHire
//
//  Created by carmatec on 23/08/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import "Lontext_LBL.h"

@implementation Lontext_LBL

- (void)drawTextInRect:(CGRect)rect {
    if (self.text) {
        CGSize labelStringSize = [self.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame), CGFLOAT_MAX)
                                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                      attributes:@{NSFontAttributeName:self.font}
                                                         context:nil].size;
        [super drawTextInRect:CGRectMake(0, 0, ceilf(CGRectGetWidth(self.frame)),ceilf(labelStringSize.height))];
    } else {
        [super drawTextInRect:rect];
    }
}

- (void)prepareForInterfaceBuilder {
    [super prepareForInterfaceBuilder];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor blackColor].CGColor;
}

@end
