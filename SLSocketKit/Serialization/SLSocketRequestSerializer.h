//
//  SLSocketRequestSerializer.h
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/17.
//  Copyright © 2018年 Will. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLSocketRequestSerializer : NSObject

@property (nonatomic, copy) NSString *version;

@property (nonatomic, copy) NSString *reqType;

@property (nonatomic, copy) NSString *body;

@property (nonatomic, copy) NSString *sessionID;//唯一识别码

+ (instancetype)serializerWithVersion:(NSString *)version reqType:(NSString *)reqType body:(NSString *)body;

- (NSString *)modelToJSON;
@end
