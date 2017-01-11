//
//  Splash_SCREEN.m
//  Estad
//
//  Created by Apple on 12/12/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import "Splash_SCREEN.h"
//#import "HomeController.h"
#import "New_Home_VC.h"

@interface Splash_SCREEN ()

@end

@implementation Splash_SCREEN

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.hidden = YES;
//    [self.navigationController.navigationBar addSubview:splashView];
    
    _VW_activity = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    CGRect new_FRAME1 = _VW_activity.frame;
    new_FRAME1.size.width = self.navigationController.navigationBar.frame.size.width;
    _VW_activity.frame = new_FRAME1;
    _VW_activity.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _activityindicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityindicator.center = _VW_activity.center;
    [_VW_activity addSubview:_activityindicator];
    [self.navigationController.view addSubview:_VW_activity];
    
    _VW_activity.hidden = YES;
    
    
    [self animate_VC];

}

-(void) animate_VC
{
//    [UIView animateWithDuration:0.5f animations:^{
        CABasicAnimation *TransformAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
        
        TransformAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        TransformAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 1, 0)];
        
        TransformAnim.cumulative = YES; TransformAnim.duration = 2; TransformAnim.repeatCount = 5;
        
        [_splashView.layer addAnimation:TransformAnim forKey:nil];
//    }];
    
//    [self performSelector:@selector(next_VC) withObject:TransformAnim afterDelay:2.0];
//    [self next_VC];
    
//    [UIView animateWithDuration:1.0f
//                          delay:0.0f
//                        options:UIViewAnimationOptionCurveEaseIn
//                     animations:^(void) {
//                         _splashView.frame = CGRectMake(_splashView.frame.origin.x, _splashView.frame.origin.y, _splashView.frame.size.width + 20, _splashView.frame.size.height);
//                     }
//                     completion:NULL];
    
   /* [UIView animateWithDuration:1
                     animations:^{
                         _splashView.transform = CGAffineTransformMakeScale(1.5, 1.5);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:1
                                          animations:^{
                                              _splashView.transform = CGAffineTransformIdentity;
                                          }];
                     }];*/
    
    _VW_activity.hidden = YES;
    [_activityindicator startAnimating];
    [self performSelector:@selector(next_VC) withObject:_activityindicator afterDelay:0.01];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) next_VC
{
    self.navigationController.navigationBar.hidden = NO;
    
//    HomeController *controller = [[HomeController alloc] initWithNibName:@"HomeController" bundle:nil];
    New_Home_VC *controller = [[New_Home_VC alloc] initWithNibName:@"New_Home_VC" bundle:nil];
    [self.navigationController pushViewController:controller animated:NO];
    
    [_activityindicator stopAnimating];
    _VW_activity.hidden = YES;
}

@end
