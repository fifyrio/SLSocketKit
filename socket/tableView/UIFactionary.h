//
//  UIFactionary.h
//  jiujiu1
//
//  Created by wuwei on 14-10-31.
//  Copyright (c) 2014年 wuwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIFactionary : NSObject

+ (void)setNavigationBar;
+ (void)hideBackBaritem;
+ (UIColor *) colorWithHexString: (NSString *)color;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSString*)getCurrentDate;
@end
