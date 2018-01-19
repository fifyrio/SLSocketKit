//
//  SLSocketConnectSerializer.m
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/18.
//  Copyright © 2018年 Will. All rights reserved.
//

#import "SLSocketConnectSerializer.h"

@implementation SLSocketConnectSerializer

+ (instancetype)serializerWithHost:(NSString *)host port:(uint16_t)port{
    return [[self alloc] initWithHost:host port:port];
}

- (instancetype)initWithHost:(NSString *)host port:(uint16_t)port
{
    self = [super init];
    if (self) {
        _host = host;
        _port = port;
    }
    return self;
}

@end
