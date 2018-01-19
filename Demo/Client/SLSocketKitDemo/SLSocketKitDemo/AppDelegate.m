//
//  AppDelegate.m
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/10.
//  Copyright © 2018年 Will. All rights reserved.
//

#import "AppDelegate.h"
#import "SLLoginViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //高德3d地图
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    [AMapServices sharedServices].apiKey = GEO_KEY;
    
    SLLoginViewController* loginVC = [[SLLoginViewController alloc] init];
    self.window.rootViewController = loginVC;
    return YES;
}





@end
