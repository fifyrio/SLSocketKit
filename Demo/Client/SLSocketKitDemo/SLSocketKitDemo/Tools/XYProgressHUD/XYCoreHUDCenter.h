//
//  XYCoreHUDCenter.h
//  XYHiRepairs
//
//  Created by wuw on 2017/3/23.
//  Copyright © 2017年 Kingnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYCoreHUDCenter : NSObject

#pragma mark - singleton,如果只是显示一次，用单例；若是短时间多次显示，用下面的非单例方法哦
extern void xy_showStatus(NSString *status);

extern void xy_showStatusWithDuration(NSString *status, NSTimeInterval duration);

extern void xy_showLoadingWithDuration(NSTimeInterval duration);

extern void xy_showLoadingIndefinitely(void);

extern void xy_dismissLoading(void);


#pragma mark - not singleton,use FIFO(First in, first out)
extern void xy_fifo_showStatus(NSString *status);

extern void xy_fifo_showStatusWithDuration(NSString *status, NSTimeInterval duration);

extern void xy_fifo_showLoadingIndefinitelyWithTag(NSInteger tag);

extern void xy_fifo_showLoadingIndefinitelyWithStatus(NSInteger tag, NSString *status);

extern void xy_fifo_dismissLoadingWithTag(NSInteger tag);

extern void xy_fifo_dismissLoadingWithTagAndDelay(NSInteger tag, NSTimeInterval delay);

@end
