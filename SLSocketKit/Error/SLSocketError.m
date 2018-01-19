//
//  SLSocketError.m
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/18.
//  Copyright © 2018年 Will. All rights reserved.
//

#import "SLSocketError.h"

@implementation SLSocketError

+ (NSError *)errorWithErrorCode:(NSInteger)errorCode{
    NSString *errorMessage;
    switch (errorCode) {
        case SL_REQUEST_ERROR:
            errorMessage = @"请求失败";
            break;
        case SL_REQUEST_PARAM_ERROR:
            errorMessage = @"入参错误";
            break;
        case SL_REQUEST_TIMEOUT:
            errorMessage = @"请求超时";
            break;
        case SL_SERVER_MAINTENANCE_UPDATES:
            errorMessage = @"用户状态丢失";            
            break;
        case SL_AUTHAPPRAISAL_FAILED:
            errorMessage = @"Token 失效";
            break;
        case SL_NETWORK_DISCONNECTED:
            errorMessage = @"网络断开";
            break;
        case SL_LOCAL_REQUEST_TIMEOUT:
            errorMessage = @"本地请求超时";
            break;
        case SL_LOCAL_PARAM_ERROR:
            errorMessage = @"本地入参错误";
            break;
        case SL_JSON_PARSE_ERROR:
            errorMessage = @"JSON 解析错误";
            break;
        
        default:
            break;
    }
    return [NSError errorWithDomain:NSURLErrorDomain
                               code:errorCode
                           userInfo:@{ NSLocalizedDescriptionKey: errorMessage }];
}

@end
