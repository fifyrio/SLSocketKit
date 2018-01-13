//
//  SLLocationManager.h
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/11.
//  Copyright © 2018年 Will. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SLLocationSuccess) (double lat, double lng);
typedef void(^SLLocationFailed) (NSError *error);

@interface SLLocationManager : NSObject

+ (SLLocationManager *) sharedManager;

- (void) getLocationWithSuccess:(SLLocationSuccess)success Failure:(SLLocationFailed)failure;

- (void) stop ;

@end
