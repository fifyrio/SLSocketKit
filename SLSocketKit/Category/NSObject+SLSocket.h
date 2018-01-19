//
//  NSObject+SLSocket.h
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/17.
//  Copyright © 2018年 Will. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SLSocket)

/**
 object转化成json字符串
 
 @return json字符串
 */

- (NSString *)sl_modelToJsonString;

/**
 object转化成json字符串，结尾添加\r\n\r\n，防止粘包
 
 @return json字符串
 */
- (NSString *)sl_modelToJsonStringByAppendEndingSymbol;

@end
