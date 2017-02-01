//
//  Cell_E_mag_coll.m
//  Estad
//
//  Created by Apple on 15/12/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import "Cell_E_mag_coll.h"

@implementation Cell_E_mag_coll

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _Img_PIC.image = [UIImage imageNamed:@"Default.jpg"];
}

-(void)prepareForReuse
{
    _Img_PIC.image = [UIImage imageNamed:@"Default.jpg"];
}
@end
