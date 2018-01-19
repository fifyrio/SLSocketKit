//
//  SLAsyncSocketManager.m
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/18.
//  Copyright © 2018年 Will. All rights reserved.
//

#import "SLAsyncSocketManager.h"
#import <GCDAsyncSocket.h>

static NSString * const SLAsyncSocketManagerLockName = @"com.alamofire.networking.session.socket.manager.lock";

@interface SLAsyncSocketManager ()<GCDAsyncSocketDelegate>

// 客户端socket
@property (strong, nonatomic) GCDAsyncSocket *clientSocket;

@property (retain, nonatomic) NSMutableDictionary *requestMap;

@property (nonatomic, assign) SLAsyncSocketStatus connectStatus;

@property (readwrite, nonatomic, strong) NSLock *lock;

@property (nonatomic, copy) SocketDidConnectBlock didConnectBlock;

@property (nonatomic, copy) SocketDidDisconnectBlock didDisconnectBlock;

@end

@implementation SLAsyncSocketManager

#pragma mark - Life cycle
+ (instancetype)sharedInstance{
    static SLAsyncSocketManager *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        _requestMap = @{}.mutableCopy;
        _connectStatus = SLAsyncSocketStatusUnconnected;
        _lock = [[NSLock alloc] init];
        _lock.name = SLAsyncSocketManagerLockName;
    }
    return self;
}

#pragma mark - Public
- (void)connectWithSerializer:(SLSocketConnectSerializer *)serializer{
    [self connectWithSerializer:serializer completionHandler:nil];
}

- (void)connectWithSerializer:(SLSocketConnectSerializer *)serializer completionHandler:(SocketDidConnectBlock)completionHandler{
    NSError *error = nil;
    [self.clientSocket connectToHost:serializer.host onPort:serializer.port viaInterface:nil withTimeout:-1 error:&error];
    if (completionHandler) {
        self.didConnectBlock = [completionHandler copy];
    }
}

- (void)dataTaskWithRequest:(SLSocketRequestSerializer *)request completionHandler:(nullable SocketDidReadBlock)completionHandler{
    if (self.connectStatus == SLAsyncSocketStatusUnconnected) {
        if (completionHandler) {
            completionHandler([SLSocketError errorWithErrorCode:SL_NETWORK_DISCONNECTED], nil);
            return;
        }
    }
    
    [self.requestMap setObject:completionHandler forKey:request.sessionID];
    NSData *data = [[request modelToJSON] dataUsingEncoding:NSUTF8StringEncoding];
    [self.clientSocket writeData:data withTimeout:- 1 tag:0];
    
    //开始读取数据
    [self.clientSocket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:10 maxLength:0 tag:0];
}

- (void)disconnectWithCompletionHandler:(SocketDidDisconnectBlock)completionHandler{
    [self.clientSocket disconnect];
    if (completionHandler) {
        self.didDisconnectBlock = completionHandler;
    }
}

#pragma mark - GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    _connectStatus = SLAsyncSocketStatusConnected;
    if (self.didConnectBlock) {
        self.didConnectBlock();
    }
}

/**
 读取数据
 
 @param sock 客户端socket
 @param data 读取到的数据
 @param tag 本次读取的标记
 */

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSError* error;
    NSDictionary* responseObjectDic = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:&error];
    if ([[responseObjectDic allKeys] containsObject:@"sessionID"]) {
        NSString *sessionID = responseObjectDic[@"sessionID"];
        if ([[self.requestMap allKeys] containsObject:sessionID]) {
            SocketDidReadBlock completionHandler = self.requestMap[sessionID];
            if (completionHandler) {
                completionHandler(nil, responseObjectDic);
                [self.lock lock];
                [self.requestMap removeObjectForKey:sessionID];
                [self.lock unlock];
            }
        }
    }
    
    // 读取到服务端数据值后,能再次读取
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    _connectStatus = SLAsyncSocketStatusUnconnected;
    self.clientSocket.delegate = nil;
    self.clientSocket = nil;
    if (self.didDisconnectBlock) {
        self.didDisconnectBlock(err);
    }
}

@end
