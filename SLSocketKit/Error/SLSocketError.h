//
//  SLSocketError.h
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/18.
//  Copyright © 2018年 Will. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLSocketError : NSObject

typedef NS_ENUM(NSInteger, SLSocketErrorCode) {
    SL_REQUEST_ERROR = 1001,
    SL_REQUEST_PARAM_ERROR = 1002,
    SL_REQUEST_TIMEOUT = 1003,
    SL_SERVER_MAINTENANCE_UPDATES = 1004,
    SL_AUTHAPPRAISAL_FAILED = 1005,
    SL_NETWORK_DISCONNECTED = 2001,
    SL_LOCAL_REQUEST_TIMEOUT = 2002,
    SL_LOCAL_PARAM_ERROR = 2003,
    SL_JSON_PARSE_ERROR = 2004,
};

+ (NSError *)errorWithErrorCode:(NSInteger)errorCode;

@end
