//
//  XYViewControllerProtocol.h
//  alielie
//
//  Created by wuw on 2017/3/10.
//  Copyright © 2017年 will. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XYViewModelProtocol;

@protocol XYViewControllerProtocol <NSObject>

@optional
- (instancetype)initWithViewModel:(id <XYViewModelProtocol>)viewModel;

/**
 *  添加控件
 *  最好最后加上[self.view setNeedsUpdateConstraints]; 和[self.view updateConstraintsIfNeeded]; ，以防不调用updateViewConstraints
 */
- (void)xy_addSubviews;

/**
 *  更新约束
 * 一定要在最后调用[super updateViewConstraints];
 */
- (void)xy_updateViewConstraints;

/**
 *  绑定
 */
- (void)xy_bindViewModel;

/**
 *  设置navation
 */
- (void)xy_layoutNavigation;

/**
 *  初次获取数据
 */
- (void)xy_getNewData;

@end
