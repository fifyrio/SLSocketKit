//
//  Common.h
//  XYHiRepairs
//
//  Created by zhoujl on 15/9/23.
//  Copyright © 2015年 Kingnet. All rights reserved.
//

#ifdef DEBUG
#define Log(...) NSLog(__VA_ARGS__)
#else
#define Log(...)
#endif

#define ScreenSize [UIScreen mainScreen].bounds.size
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ScreenW [UIScreen mainScreen].bounds.size.width

#define PhoneNumber @"phoneNumber"
#define UserInfo @"UserInfo"
#define LandedStatus @"LandedStatus"


#define DevidingLineColor [UIColor colorWithRed:(200)/255.0 green:(205)/255.0 blue:(212)/255.0 alpha:1.0]
#define ThemeColor [UIColor colorWithRed:(255)/255.0 green:(80)/255.0 blue:(0)/255.0 alpha:1.0]


#define RandomColor [UIColor colorWithRed:arc4random_uniform(255.0)/256.0 green:arc4random_uniform(255.0)/256.0 blue:arc4random_uniform(255.0)/256.0 alpha:1.0]

#define XY_COLOR(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define XY_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0]


#define GlobalBg [UIColor colorWithRed:239/255.0 green:239/255.0  blue:244/255.0 alpha:1]
//系统版本
#define IS_IOS_8_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IOS_9_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)


#define SelectMobile @"SelectMobile"
#define MobileDidSelectNotification @"MobileDidSelectNotification"
#define WS(weakSelf)                __weak __typeof(&*self)weakSelf = self;
