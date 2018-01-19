//
//  SLSocketConnectSerializer.h
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/18.
//  Copyright © 2018年 Will. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLSocketConnectSerializer : NSObject

+ (instancetype)serializerWithHost:(NSString *)host port:(uint16_t)port;

/**
 *  通信地址
 */
@property (nonatomic, strong) NSString *host;
/**
 *  通信端口号
 */
@property (nonatomic, assign) uint16_t port;

@end
