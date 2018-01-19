//
//  XYView.m
//  alielie
//
//  Created by wuw on 2017/3/10.
//  Copyright © 2017年 will. All rights reserved.
//

#import "XYView.h"
#import "XYViewModelProtocol.h"

@implementation XYView
#pragma mark - Life cycle
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    XYView *view = [super allocWithZone:zone];
    
    @weakify(view)
    
    [[view rac_signalForSelector:@selector(updateConstraints)] subscribeNext:^(id x) {
        @strongify(view)
        [view xy_updateConstraints];
    }];
    
    return view;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self xy_setupViews];
        [self xy_bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<XYViewModelProtocol>)viewModel {
    
    self = [super init];
    if (self) {
        [self xy_setupViews];
        [self xy_bindViewModel];
    }
    return self;
}

#pragma mark - XYViewProtocol
/**
 *  添加控件
 *  最好最后加上[self setNeedsUpdateConstraints]和[self updateConstraintsIfNeeded]，以防不调用updateConstraints，但是若view的controller已经调用setNeedsUpdateConstraints和updateConstraintsIfNeeded，则这里可以不用加上这些
 */
- (void)xy_setupViews {}

/**
 *  更新约束
 *  一定要在最后调用[super updateConstraints]
 */
- (void)xy_updateConstraints {}

/**
 *  绑定
 */
- (void)xy_bindViewModel {}

@end
