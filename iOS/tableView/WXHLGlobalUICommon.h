//
//  WXHLGlobalUICommon.h
//  WXMovie
//
//  Created by xiongbiao on 12-12-11.
//  Copyright (c) 2012年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define isIos7      ([[[UIDevice currentDevice] systemVersion] floatValue])
#define StatusbarSize ((isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)?20.f:0.f)

#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

/* { thread } */
#define __async_opt__  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define __async_main__ dispatch_async(dispatch_get_main_queue()


#define WXHL_ROW_HEIGHT                 WXHLkDefaultRowHeight
#define WXHL_TOOLBAR_HEIGHT             WXHLkDefaultPortraitToolbarHeight
#define WXHL_LANDSCAPE_TOOLBAR_HEIGHT   WXHLkDefaultLandscapeToolbarHeight
#define WXHL_TABBAR_HEIGHT              49
#define WXHL_TABBAR_BUTTON_HEIGHT       25
#define WXHL_TABBAR_BUTTON_WIDTH       25

#define WXHL_KEYBOARD_HEIGHT                 WXHLkDefaultPortraitKeyboardHeight
#define WXHL_LANDSCAPE_KEYBOARD_HEIGHT       WXHLkDefaultLandscapeKeyboardHeight
#define WXHL_IPAD_KEYBOARD_HEIGHT            WXHLkDefaultPadPortraitKeyboardHeight
#define WXHL_IPAD_LANDSCAPE_KEYBOARD_HEIGHT  WXHLkDefaultPadLandscapeKeyboardHeight

#define WXHL_IPHONE_WIDTH              320



//安全释放对象
#define RELEASE_SAFELY(__POINTER) { if(__POINTER){[__POINTER release]; __POINTER = nil; }}

/**
 * @返回当前iPhone OS 运行的版本
 */
float WXHLOSVersion();


CGAffineTransform WXHLRotateTransformForOrientation(UIInterfaceOrientation orientation);

/**
 * @返回应用程序物理屏幕大小
 *
 */
CGRect WXHLApplicationBounds();

/**
 * @返回应用程序去掉状态栏高度的大小
 *
 */
CGRect WXHLApplicationFrame();

/**
 * @返回应用程序状态栏的大小
 *
 */
CGRect WXHLApplicationStatusFrame();


