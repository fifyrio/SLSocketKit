//
//  SLShareLocationViewModel.h
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/16.
//  Copyright © 2018年 Will. All rights reserved.
//

#import "XYViewModel.h"
#import <GCDAsyncSocket.h>
#import "SLLocationModel.h"

typedef NS_ENUM(NSUInteger, SLBottomBtnState) {
    SLBottomBtnStateDefault = 0,//底部按钮处于默认状态，显示共享实时位置
    SLBottomBtnStateSelected,//底部按钮处于选中状态，显示结束共享
};

@interface SLShareLocationViewModel : XYViewModel

@property (nonatomic, copy) NSString *userID;

@property (nonatomic, retain) NSMutableArray <SLLocationModel *>*users;

@property (nonatomic, assign) SLBottomBtnState bottomBtnState;//初始定位

@property (nonatomic, strong) RACSignal *clickBottomBtnSignal;

@property (nonatomic, strong) RACSubject *timerActionSubject;//定时器启动subject

@property (nonatomic, strong) RACSubject *locateSuccessSubject;//定位成功subject;

@property (nonatomic, strong) RACSubject *refreshUsersViewSubject;

@property (nonatomic, strong) RACSubject *refreshMapViewSubject;

@end
