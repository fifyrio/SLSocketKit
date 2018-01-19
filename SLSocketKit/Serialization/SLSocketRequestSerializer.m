//
//  SLSocketRequestSerializer.m
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/17.
//  Copyright © 2018年 Will. All rights reserved.
//

#import "SLSocketRequestSerializer.h"

@interface SLSocketRequestSerializer ()



@end

@implementation SLSocketRequestSerializer


+ (instancetype)serializerWithVersion:(NSString *)version reqType:(NSString *)reqType body:(NSString *)body{
    return [[self alloc] initWithVersion:version reqType:reqType body:body];
}

- (instancetype)initWithVersion:(NSString *)version reqType:(NSString *)reqType body:(NSString *)body
{
    self = [super init];
    if (self) {
        _version = version;
        _reqType = reqType;
        _body = body;
        _sessionID = [[NSUUID UUID] UUIDString];
    }
    return self;
}

- (NSString *)modelToJSON{
    return [NSString stringWithFormat:@"{\"version\":\"%@\",\"reqType\":%@,\"sessionID\":\"%@\",\"body\":%@}\r\n\r\n", _version, _reqType, _sessionID, _body];
}

@end
