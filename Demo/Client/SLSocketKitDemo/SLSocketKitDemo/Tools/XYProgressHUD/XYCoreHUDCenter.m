//
//  XYCoreHUDCenter.m
//  XYHiRepairs
//
//  Created by wuw on 2017/3/23.
//  Copyright © 2017年 Kingnet. All rights reserved.
//

#import "XYCoreHUDCenter.h"
#import "XYProgressHUD.h"

static NSTimeInterval const kCoreHUDCenterDefaultDuration = 1;

@implementation XYCoreHUDCenter

#pragma mark - singleton

void xy_showStatus(NSString *status){
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [XYProgressHUD setDefaultStyle:XYProgressHUDStyleDark];
            [XYProgressHUD showStatus:status duration:kCoreHUDCenterDefaultDuration];
        });
    }else{
        [XYProgressHUD setDefaultStyle:XYProgressHUDStyleDark];
        [XYProgressHUD showStatus:status duration:kCoreHUDCenterDefaultDuration];
    }
}

void xy_showStatusWithDuration(NSString *status, NSTimeInterval duration){
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [XYProgressHUD setDefaultStyle:XYProgressHUDStyleDark];
            [XYProgressHUD showStatus:status duration:duration];
        });
    }else{
        [XYProgressHUD setDefaultStyle:XYProgressHUDStyleDark];
        [XYProgressHUD showStatus:status duration:duration];
    }
}

void xy_showLoadingIndefinitely(void){
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [XYProgressHUD setDefaultStyle:XYProgressHUDStyleCustom];
            [XYProgressHUD setBackgroundColor:[UIColor clearColor]];
            [XYProgressHUD showLoadingIndefinitely];
        });
    }else{
        [XYProgressHUD setDefaultStyle:XYProgressHUDStyleCustom];
        [XYProgressHUD setBackgroundColor:[UIColor clearColor]];
        [XYProgressHUD showLoadingIndefinitely];
    }
}

void xy_showLoadingWithDuration(NSTimeInterval duration){
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [XYProgressHUD setDefaultStyle:XYProgressHUDStyleCustom];
            [XYProgressHUD setBackgroundColor:[UIColor clearColor]];
            [XYProgressHUD showLoadingWithDuration:duration];
        });
    }else{
        [XYProgressHUD setDefaultStyle:XYProgressHUDStyleCustom];
        [XYProgressHUD setBackgroundColor:[UIColor clearColor]];
        [XYProgressHUD showLoadingWithDuration:duration];
    }
}

void xy_dismissLoading(void){
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [XYProgressHUD dismissLoading];
        });
    }else{
        [XYProgressHUD dismissLoading];
    }
}

#pragma mark - not singleton,use FIFO(First in, first out)
void xy_fifo_showStatus(NSString *status){
    XYProgressHUD *hud = [XYProgressHUD initHUD];
    [hud setDefaultStyle:XYProgressHUDStyleDark];
    [hud fifo_showStatus:status duration:kCoreHUDCenterDefaultDuration];        
}

void xy_fifo_showStatusWithDuration(NSString *status, NSTimeInterval duration){
    XYProgressHUD *hud = [XYProgressHUD initHUD];
    [hud setDefaultStyle:XYProgressHUDStyleDark];
    [hud fifo_showStatus:status duration:duration];
}

void xy_fifo_showLoadingIndefinitelyWithTag(NSInteger tag){
    XYProgressHUD *hud = [XYProgressHUD initHUDWithTag:tag];
    [hud setDefaultStyle:XYProgressHUDStyleCustom];
    [hud fifo_showLoadingIndefinitely];
}

void xy_fifo_showLoadingIndefinitelyWithStatus(NSInteger tag, NSString *status){
    XYProgressHUD *hud = [XYProgressHUD initHUDWithTag:tag];
    [hud setDefaultStyle:XYProgressHUDStyleLight];
    [hud fifo_showLoadingIndefinitelyWithStatus:status];
}

void xy_fifo_dismissLoadingWithTag(NSInteger tag){
    XYProgressHUD *theHUD = [XYProgressHUD getHUDWithTag:tag];
    if (theHUD) {
        [theHUD fifo_dismissLoading];
    }
}

void xy_fifo_dismissLoadingWithTagAndDelay(NSInteger tag, NSTimeInterval delay){
    XYProgressHUD *theHUD = [XYProgressHUD getHUDWithTag:tag];
    if (theHUD) {
        [theHUD fifo_dismissLoadingWithDelay:delay];
    }
}

@end
