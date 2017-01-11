//
//  CollapseClickCell.m
//  CollapseClick
//
//  Created by Ben Gordon on 2/28/13.
//  Copyright (c) 2013 Ben Gordon. All rights reserved.
//

#import "CollapseClickCell.h"

@implementation CollapseClickCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (CollapseClickCell *)newCollapseClickCellWithTitle:(NSString *)title index:(int)index content:(UIView *)content {
    NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"CollapseClickCell" owner:nil options:nil];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    
    CollapseClickCell *cell = [[CollapseClickCell alloc] initWithFrame:CGRectMake(0, 0, screenWidth, kCCHeaderHeight)];
    cell = [views objectAtIndex:0];
    
    // Initialization Here
    cell.TitleLabel.text = title;
    cell.index = index;
    cell.TitleButton.tag = index;
    cell.ContentView.frame = CGRectMake(cell.ContentView.frame.origin.x, cell.ContentView.frame.origin.y, cell.ContentView.frame.size.width, content.frame.size.height);
    
    
    cell.line1.hidden = YES;
    cell.line2.hidden = YES;
    
//    if (index < 2)
//    {
//        cell.line1.hidden = YES;
//        cell.line2.hidden = YES;
//    }
    
    if (index == 0 || index == 1 || index > 4) {
        cell.TitleArrow.hidden = YES;
    }
    
    cell.Arrow.textColor = [UIColor whiteColor];
    
    [cell.ContentView addSubview:content];
    
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
