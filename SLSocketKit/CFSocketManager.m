//
//  CFSocketManager.m
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/11.
//  Copyright © 2018年 Will. All rights reserved.
//

#import "CFSocketManager.h"
#import <arpa/inet.h>
#import <netinet/in.h>
#import <sys/socket.h>

@interface CFSocketManager (){
    int _clientSocket;
}

@property (readwrite, nonatomic, strong) NSOperationQueue *operationQueue;

@property (nonatomic, copy) NSString *url;

@property (nonatomic) NSInteger port;

@end

@implementation CFSocketManager

#pragma mark - Life cycle
+ (instancetype)manager {
    return [[[self class] alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.operationQueue = [[NSOperationQueue alloc] init];
        self.operationQueue.maxConcurrentOperationCount = 1;
        _clientSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    }
    return self;
}

//- (instancetype)initWithURL:(NSString *)url port:(NSInteger)port{
//    self = [super init];
//    if (self) {
//        self.url = url;
//        self.port = port;
//        self.operationQueue = [[NSOperationQueue alloc] init];
//        self.operationQueue.maxConcurrentOperationCount = 1;
//    }
//    return self;
//}

#pragma mark - Public methods
- (void)connectTo:(NSString *)url port:(NSInteger)port{
    [self connectTo:url port:port success:nil failure:nil];
}

- (void)connectTo:(NSString *)url port:(NSInteger)port success:(void (^)(void))success failure:(void (^)(void))failure{
    self.url = url;
    self.port = port;
    
    struct sockaddr_in addr;
    addr.sin_family = AF_INET;//AF_INET ipv4协议
    addr.sin_port=htons(port);//服务器端口    
    addr.sin_addr.s_addr = inet_addr([url UTF8String]);//服务器地址
    int connectResult= connect( _clientSocket, (const struct sockaddr *)&addr, sizeof(addr));//参数二：指向数据结构sockaddr的指针，其中包括目的端口和IP地址，参数三：sockaddr的长度，返回值：int -1失败 、0 成功
    if (connectResult == 0) {
        success?success():nil;
    }else{
        failure?failure():nil;        
    }
}

- (void)sendData:(NSString *)data{
    [self sendData:data success:nil failure:nil];
}

- (void)sendData:(NSString *)data success:(void (^)(void))success failure:(void (^)(void))failure{
    /*
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
        ssize_t sendLen = send( _clientSocket, [data UTF8String], strlen([data UTF8String]), 0);//第二个参数指明一个存放应用程式要发送数据的缓冲区；第三个参数指明实际要发送的数据的字符数；第四个参数一般置0。
        if (sendLen > 0) {
            success?success():nil;
        }else{
            failure?failure():nil;
        }
    }];
    [self.operationQueue addOperation:operation];
     */
    ssize_t sendLen = send( _clientSocket, [data UTF8String], strlen([data UTF8String]), 0);//第二个参数指明一个存放应用程式要发送数据的缓冲区；第三个参数指明实际要发送的数据的字符数；第四个参数一般置0。
    if (sendLen > 0) {
        success?success():nil;
    }else{
        failure?failure():nil;
    }
}

void cf_async_main_queue(dispatch_block_t block) {    
    dispatch_async(dispatch_get_main_queue(), ^{
        block();
    });
}

void cf_delay_main_queue(int64_t sec, dispatch_block_t block){
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(sec * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

@end
