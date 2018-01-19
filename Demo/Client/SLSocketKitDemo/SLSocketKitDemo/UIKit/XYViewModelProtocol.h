//
//  XYViewModelProtocol.h
//  alielie
//
//  Created by wuw on 2017/3/10.
//  Copyright © 2017年 will. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XYViewModelProtocol <NSObject>

@optional

- (instancetype)initWithModel:(id)model;

/**
 *  初始化
 */
- (void)xy_initialize;

@end
