//
//  AppDelegate.m
//  Estad
//
//  Created by carmatec on 28/10/16.
//  Copyright © 2016 carmatec. All rights reserved.
//

#import "AppDelegate.h"
#import "Splash_SCREEN.h"
#import "HomeController.h"
//#import <FBSDKCoreKit/FBSDKCoreKit.h>

@import GoogleMobileAds;

@interface AppDelegate ()

@end

@implementation AppDelegate

//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation {
//    return [[FBSDKApplicationDelegate sharedInstance] application:application
//                                                          openURL:url
//                                                sourceApplication:sourceApplication
//                                                       annotation:annotation];
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
   [GADMobileAds configureWithApplicationID:@"ca-app-pub-8762774270996921~1852871497"];
//    [[FBSDKApplicationDelegate sharedInstance] application:application
//                             didFinishLaunchingWithOptions:launchOptions];
    
    // Make this interesting.
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
//    self.viewController = [[HomeController alloc] initWithNibName:@"HomeController" bundle:nil];
//    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    Splash_SCREEN *PUSH_VC = [[Splash_SCREEN alloc]initWithNibName:@"Splash_SCREEN" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:PUSH_VC];
    self.window.rootViewController = navController;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 20)];
        view.backgroundColor = [UIColor colorWithRed:0.35 green:0.01 blue:0.19 alpha:1.0];
        [self.window.rootViewController.view addSubview:view];
    }
    
//    if([[UIDevice currentDevice] systemVersion].floatValue >= 8.0)
//    {
        UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
//    }
//    else
//    {
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge)];
//    }

    return YES;
}


#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:   (UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString   *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"])
    {
        
    }
    else if ([identifier isEqualToString:@"answerAction"])
    {
        
    }
    
    NSLog(@"User info appdeliigate = %@",userInfo);
}
#endif

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"Did Register for Remote Notifications with Device Token (%@)", deviceToken);
    
    //    NSString *tmp = [NSString stringWithFormat:@"%@",deviceToken]
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"APNS ID 0 o O" message:tmp delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //    [alert show];
    
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSUInteger lenthtotes = [token length];
    NSUInteger req = 64;
    if (lenthtotes == req) {
        NSLog(@"uploaded token: %@", token);
        
        [[NSUserDefaults standardUserDefaults]setObject:token forKey:@"DEV_TOK"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSNotification *notif = [NSNotification notificationWithName:@"NEW_TOKEN_AVAILABLE" object:token];
        [[NSNotificationCenter defaultCenter] postNotification:notif];
    }
    
    
    
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"APNS ID 1" message:@"Test1 Fail" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //    [alert show];
    //
    NSLog(@"Did Fail to Register for Remote Notifications");
    NSLog(@"%@, %@", error, error.localizedDescription);
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
//    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
