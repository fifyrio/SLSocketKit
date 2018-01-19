//
//  XYViewController.m
//  alielie
//
//  Created by wuw on 2017/3/10.
//  Copyright © 2017年 will. All rights reserved.
//

#import "XYViewController.h"
#import "XYViewModelProtocol.h"

@interface XYViewController ()

@end

@implementation XYViewController
#pragma mark - Life cycle
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    XYViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController xy_addSubviews];
        [viewController xy_bindViewModel];
    }];
    
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController xy_layoutNavigation];
        [viewController xy_getNewData];
    }];
    
    [[viewController rac_signalForSelector:@selector(updateViewConstraints)] subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController xy_updateViewConstraints];
    }];
    
    return viewController;
}

- (instancetype)initWithViewModel:(id<XYViewModelProtocol>)viewModel {
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //打点统计，比如友盟统计
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //打点统计，比如友盟统计
}

#pragma mark - XYViewControllerProtocol
/**
 *  添加控件
 *  最好最后加上[self.view setNeedsUpdateConstraints]; 和[self.view updateConstraintsIfNeeded]; ，以防不调用updateViewConstraints
 */
- (void)xy_addSubviews {}

/**
 *  更新约束
 *  一定要在最后调用[super updateViewConstraints];
 */
- (void)xy_updateViewConstraints{}

/**
 *  绑定
 */
- (void)xy_bindViewModel {}

/**
 *  设置navation
 */
- (void)xy_layoutNavigation {}

/**
 *  初次获取数据
 */
- (void)xy_getNewData {}

@end
