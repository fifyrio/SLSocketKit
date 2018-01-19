//
//  SLShareLocationViewModel.m
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/16.
//  Copyright © 2018年 Will. All rights reserved.
//

#import "SLShareLocationViewModel.h"

@interface SLShareLocationViewModel ()

@end

@implementation SLShareLocationViewModel

- (RACSubject *)timerActionSubject{
    if (_timerActionSubject == nil) {
        _timerActionSubject = [RACSubject subject];
    }
    return _timerActionSubject;
}

- (RACSubject *)locateSuccessSubject{
    if (_locateSuccessSubject == nil) {
        _locateSuccessSubject = [RACSubject subject];
    }
    return _locateSuccessSubject;
}

- (RACSubject *)refreshUsersViewSubject{
    if (_refreshUsersViewSubject == nil) {
        _refreshUsersViewSubject = [RACSubject subject];
    }
    return _refreshUsersViewSubject;
}

- (RACSubject *)refreshMapViewSubject{
    if (_refreshMapViewSubject == nil) {
        _refreshMapViewSubject = [RACSubject subject];
    }
    return _refreshMapViewSubject;
}
@end
