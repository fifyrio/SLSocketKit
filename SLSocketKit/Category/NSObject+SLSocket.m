//
//  NSObject+SLSocket.m
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/17.
//  Copyright © 2018年 Will. All rights reserved.
//

#import "NSObject+SLSocket.h"
#import "NSDictionary+SLSocket.h"
#import <objc/runtime.h>

@implementation NSObject (SLSocket)

/**
 object转化成json字符串
 
 @return
 */
- (NSString *)sl_modelToJsonString{
    return [[self sl_dictionaryWithPropertiesOfObject] sl_dictionaryToJsonString];
}


/**
 object转化成json字符串，结尾添加\r\n\r\n，防止粘包

 @return
 */
- (NSString *)sl_modelToJsonStringByAppendEndingSymbol{
    return [[self sl_modelToJsonString] stringByAppendingString:@"\r\n\r\n"];
}

- (NSDictionary *)sl_dictionaryWithPropertiesOfObject{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        id value = [self valueForKey:key];
        if (value == nil) {
            // nothing to do here
        }else if ([value isKindOfClass:[NSNumber class]]
                  || [value isKindOfClass:[NSString class]]
                  || [value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSArray class]]){
            [dict setObject:value forKey:key];
        }else if ([value isKindOfClass:[NSMutableArray class]] || [value isKindOfClass:[NSMutableString class]] || [value isKindOfClass:[NSMutableDictionary class]]){
            [dict setObject:[value copy] forKey:key];
        }else {
            NSLog(@"Invalid type for %@ (%@)", NSStringFromClass([self class]), key);
        }
    }
    
    free(properties);
    
    return [NSDictionary dictionaryWithDictionary:dict];
}

@end
