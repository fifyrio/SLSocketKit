//
//  SLLocationModel.m
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/17.
//  Copyright © 2018年 Will. All rights reserved.
//

#import "SLLocationModel.h"

@implementation SLLocationModel

- (instancetype)initWithUserId:(NSString *)userId lat:(double)lat lng:(double)lng
{
    self = [super init];
    if (self) {
        _userId = userId;
        _lat = lat;
        _lng = lng;
    }
    return self;
}

@end
