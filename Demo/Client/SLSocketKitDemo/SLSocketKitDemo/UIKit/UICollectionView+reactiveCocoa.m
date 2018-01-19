//
//  UICollectionView+reactiveCocoa.m
//  tableView
//
//  Created by wuw on 2017/8/29.
//  Copyright © 2017年 Kingnet. All rights reserved.
//

#import "UICollectionView+reactiveCocoa.h"

@implementation UICollectionViewCell (reactiveCocoa)

- (void)xy_initWithViewModel:(id<XYViewModelProtocol>)viewModel{
}

@end

@implementation UICollectionView (reactiveCocoa)

- (__kindof UICollectionViewCell *)rac_dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath viewModel:(id)viewModel{
    UICollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell xy_initWithViewModel:viewModel];
    return cell;
}

@end
