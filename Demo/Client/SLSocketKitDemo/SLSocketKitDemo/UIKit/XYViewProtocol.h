//
//  XYViewProtocol.h
//  alielie
//
//  Created by wuw on 2017/3/10.
//  Copyright © 2017年 will. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XYViewModelProtocol;

@protocol XYViewProtocol <NSObject>

@optional

- (instancetype)initWithViewModel:(id <XYViewModelProtocol>)viewModel;

/**
 *  添加控件
 *  最好最后加上[self setNeedsUpdateConstraints];和[self updateConstraintsIfNeeded]，以防不调用updateConstraints，但是若view的controller已经调用setNeedsUpdateConstraints和updateConstraintsIfNeeded，则这里可以不用加上这些
 */
- (void)xy_setupViews;

/**
 *  更新约束
 *  一定要在最后调用[super updateConstraints]
 */
- (void)xy_updateConstraints;


/**
 *  绑定
 */
- (void)xy_bindViewModel;

@end
