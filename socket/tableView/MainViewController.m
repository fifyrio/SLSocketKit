//
//  MainViewController.m
//  tableView
//
//  Created by 吴伟 on 15/10/9.
//  Copyright © 2015年 com.weizong. All rights reserved.
//

#import "MainViewController.h"
#import <GCDAsyncSocket.h>

#define HOST @"192.168.0.1"
#define PORT 8080

@interface MainViewController ()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *socket;

@end

@implementation MainViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _socket = [[GCDAsyncSocket alloc] initWithSocketQueue:dispatch_get_main_queue()];
    NSError *err = nil;
    [_socket connectToHost:HOST onPort:PORT error:&err];
    
}

#pragma mark - Initialize

#pragma mark - Actions
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"");
}

#pragma mark - Getters

#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
