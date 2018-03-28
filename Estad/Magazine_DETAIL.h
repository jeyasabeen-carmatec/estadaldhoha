//
//  Magazine_DETAIL.h
//  Estad
//
//  Created by Apple on 19/12/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Magazine_DETAIL : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) NSString *get_URL;
@property (nonatomic, strong) IBOutlet UIWebView *display_DOC;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *indicator;

@end
