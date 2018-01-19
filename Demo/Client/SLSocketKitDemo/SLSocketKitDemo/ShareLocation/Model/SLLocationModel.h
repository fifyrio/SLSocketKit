//
//  SLLocationModel.h
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/17.
//  Copyright © 2018年 Will. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLLocationModel : NSObject

- (instancetype)initWithUserId:(NSString *)userId lat:(double)lat lng:(double)lng;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, assign) double lat;

@property (nonatomic, assign) double lng;

@property (nonatomic, copy) NSString *userName;

@end
