//
//  SLShareLocationViewController.m
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/16.
//  Copyright © 2018年 Will. All rights reserved.
//

#import "SLShareLocationViewController.h"
#import "SLShareLocationView.h"
#import "SLLocationModel.h"
#import "NSObject+SLSocket.h"
#import "SLSocketRequestSerializer.h"
#import "SLAsyncSocketManager.h"
#import "SLSocketConnectSerializer.h"

@interface SLShareLocationViewController ()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) SLShareLocationView *mainView;

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation SLShareLocationViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Protocol
- (void)xy_addSubviews{
    self.title = @"雾中人";
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"f5f5f5"]];
    [self.view addSubview:self.mainView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    
   
}

- (void)xy_updateViewConstraints{
    WS(weakSelf)
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

- (void)xy_bindViewModel{
    [self bindWithBottomBtn];
    
    [self onListenLocateSuccess];
}

#pragma mark - 功能模块
- (void)bindWithBottomBtn{
    @weakify(self);
    [self.mainViewModel.clickBottomBtnSignal subscribeNext:^(UIButton *button) {
        
        @strongify(self);
        if (self.mainViewModel.bottomBtnState == SLBottomBtnStateDefault) {
            self.mainViewModel.bottomBtnState = SLBottomBtnStateSelected;
            [button setTitle:@"结束共享" forState:UIControlStateNormal];
            
            SLSocketConnectSerializer *connectSeri = [SLSocketConnectSerializer serializerWithHost:HOST port:PORT];
            [[SLAsyncSocketManager sharedInstance] connectWithSerializer:connectSeri];
             
            [self addTimer];
        }else{//断开连接
            self.mainViewModel.bottomBtnState = SLBottomBtnStateDefault;
            [button setTitle:@"共享实时位置" forState:UIControlStateNormal];
            
            @weakify(self);
            [[SLAsyncSocketManager sharedInstance] disconnectWithCompletionHandler:^(NSError *error) {
                if (!error) {
                    @strongify(self);
                    [self.timer invalidate];
                }
            }];
        }
        
    }];
}

/**
 监听定位成功信号
 */
- (void)onListenLocateSuccess{
    @weakify(self);
    [self.mainViewModel.locateSuccessSubject subscribeNext:^(SLLocationModel *model) {
        @strongify(self);
        if (model) {
            SLSocketRequestSerializer *request = [SLSocketRequestSerializer serializerWithVersion:PROTOCOL_VERSION reqType:REQ_TYPE_UPLOAD_LOCATION body:[model sl_modelToJsonString]];
            
            @weakify(self);
            [[SLAsyncSocketManager sharedInstance] dataTaskWithRequest:request completionHandler:^(NSError *error, id responseDict) {
                if (!error) {
                    @strongify(self);
                    if ([responseDict[@"code"] integerValue] == 200) {
                        NSArray *data = responseDict[@"data"];
                        if (data.count) {
                            NSMutableArray *users = [SLLocationModel mj_objectArrayWithKeyValuesArray:data];
                            self.mainViewModel.users = users;
                            [self.mainViewModel.refreshUsersViewSubject sendNext:nil];
                            [self.mainViewModel.refreshMapViewSubject sendNext:nil];
                        }
                    }
                }
            }];
        }
    }];
}

- (void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(longConnectToSocket) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)longConnectToSocket{
    [self.mainViewModel.timerActionSubject sendNext:nil];
}

#pragma mark - Lazy load
- (SLShareLocationView *)mainView{
    if (_mainView == nil) {
        _mainView = [[SLShareLocationView alloc] initWithViewModel:self.mainViewModel];
    }
    return _mainView;
}

- (SLShareLocationViewModel *)mainViewModel{
    if (_mainViewModel == nil) {
        _mainViewModel = [[SLShareLocationViewModel alloc] init];        
    }
    return _mainViewModel;
}

#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
