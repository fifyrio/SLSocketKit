//
//  AppDelegate.m
//  tableView
//
//  Created by 吴伟 on 14-10-5.
//  Copyright (c) 2014年 com.weizong. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "CTypeViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    CTypeViewController* mainVC = [[CTypeViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    
    self.window.rootViewController = navVC;
    return YES;
}


@end
