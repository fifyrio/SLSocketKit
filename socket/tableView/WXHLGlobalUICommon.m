//
//  WXHLGlobalUICommon.m
//  WXMovie
//
//  Created by xiongbiao on 12-12-11.
//  Copyright (c) 2012年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "WXHLGlobalUICommon.h"

const CGFloat WXHLkDefaultRowHeight = 44;
              
const CGFloat WXHLkDefaultPortraitToolbarHeight   = 44;
const CGFloat WXHLkDefaultLandscapeToolbarHeight  = 33;

const CGFloat WXHLkDefaultPortraitKeyboardHeight      = 216;
const CGFloat WXHLkDefaultLandscapeKeyboardHeight     = 160;
const CGFloat WXHLkDefaultPadPortraitKeyboardHeight   = 264;
const CGFloat WXHLkDefaultPadLandscapeKeyboardHeight  = 352;

const CGFloat WXHLkGroupedTableCellInset = 9;
const CGFloat WXHLkGroupedPadTableCellInset = 42;

const CGFloat WXHLkDefaulWXHLransitionDuration      = 0.3;
const CGFloat WXHLkDefaultFasWXHLransitionDuration  = 0.2;
const CGFloat WXHLkDefaultFlipTransitionDuration  = 0.7;



///////////////////////////////////////////////////////////////////////////////////////////////////
float WXHLOSVersion()
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

CGRect WXHLApplicationBounds()
{
    return [UIScreen mainScreen].bounds;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
CGRect WXHLApplicationFrame() {
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    return CGRectMake(0, 0, frame.size.width, frame.size.height);
}

CGRect WXHLApplicationStatusFrame(){
    CGRect frame = [[UIApplication sharedApplication] statusBarFrame];
    return CGRectMake(0, 0, frame.size.width, frame.size.height);
}



