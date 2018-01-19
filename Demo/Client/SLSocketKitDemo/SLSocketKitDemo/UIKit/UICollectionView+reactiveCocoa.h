//
//  UICollectionView+reactiveCocoa.h
//  tableView
//
//  Created by wuw on 2017/8/29.
//  Copyright © 2017年 Kingnet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYViewProtocol.h"

@interface UICollectionViewCell (reactiveCocoa)

- (void)xy_initWithViewModel:(id)viewModel;

@end

@interface UICollectionView (reactiveCocoa)

- (__kindof UICollectionViewCell *)rac_dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath viewModel:(id)viewModel;

@end
