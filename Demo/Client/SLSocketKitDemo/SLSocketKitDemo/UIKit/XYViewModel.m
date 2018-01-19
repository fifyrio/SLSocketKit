//
//  XYViewModel.m
//  alielie
//
//  Created by wuw on 2017/3/10.
//  Copyright © 2017年 will. All rights reserved.
//

#import "XYViewModel.h"

@implementation XYViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    XYViewModel *viewModel = [super allocWithZone:zone];
    
    if (viewModel) {
        
        [viewModel xy_initialize];
    }
    return viewModel;
}


#pragma mark - XYViewModelProtocol
- (instancetype)initWithModel:(id)model {
    
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)xy_initialize{}
@end
