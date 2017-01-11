//
//  Magazine_DETAIL.m
//  Estad
//
//  Created by Apple on 19/12/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import "Magazine_DETAIL.h"

@interface Magazine_DETAIL ()

@end

@implementation Magazine_DETAIL

@synthesize get_URL;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"Get url Value = %@",get_URL);
    
    [self SetUP_VIEW];
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

-(void) SetUP_VIEW
{
    NSURL *url = [NSURL URLWithString:get_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_indicator startAnimating];
    [_indicator setCenter:self.view.center];
    [_display_DOC addSubview:_indicator];
    [_indicator startAnimating];
    
    [_display_DOC loadRequest:request];
    
}

#pragma mark - UIWebViewDelegate -

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_indicator stopAnimating];
    _indicator.hidden = YES;
}


-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_indicator stopAnimating];
    _indicator.hidden = YES;
}

@end
