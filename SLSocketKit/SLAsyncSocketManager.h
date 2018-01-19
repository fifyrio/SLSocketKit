//
//  SLAsyncSocketManager.h
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/18.
//  Copyright © 2018年 Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLSocketConnectSerializer.h"
#import "SLSocketRequestSerializer.h"
#import "SLSocketError.h"

typedef NS_ENUM(NSInteger, SLAsyncSocketStatus) {
    SLAsyncSocketStatusUnconnected = -1,// 未连接
    SLAsyncSocketStatusConnected = 1,//连接成功
};

typedef void (^SocketDidConnectBlock)(void);
typedef void (^SocketDidReadBlock)(NSError *error, id data);
typedef void (^SocketDidDisconnectBlock)(NSError *error);

@interface SLAsyncSocketManager : NSObject

+ (instancetype)sharedInstance;

- (void)connectWithSerializer:(SLSocketConnectSerializer *)serializer;

- (void)connectWithSerializer:(SLSocketConnectSerializer *)serializer completionHandler:(SocketDidConnectBlock)completionHandler;

- (void)dataTaskWithRequest:(SLSocketRequestSerializer *)request completionHandler:(SocketDidReadBlock)completionHandler;

- (void)disconnectWithCompletionHandler:(SocketDidDisconnectBlock)completionHandler;

@end
