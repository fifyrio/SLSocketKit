//
//  CFSocketManager.h
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/11.
//  Copyright © 2018年 Will. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFSocketManager : NSObject

+ (instancetype)manager;

- (void)connectTo:(NSString *)url port:(NSInteger)port;

- (void)connectTo:(NSString *)url port:(NSInteger)port success:(void (^)(void))success failure:(void (^)(void))failure;

- (void)sendData:(NSString *)data;

- (void)sendData:(NSString *)data success:(void (^)(void))success failure:(void (^)(void))failure;

extern void cf_async_main_queue(dispatch_block_t block);

extern void cf_delay_main_queue(int64_t sec, dispatch_block_t block);

@end
