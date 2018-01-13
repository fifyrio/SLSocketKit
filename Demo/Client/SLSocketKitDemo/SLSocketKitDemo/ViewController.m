//
//  ViewController.m
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/10.
//  Copyright © 2018年 Will. All rights reserved.
//

#import "ViewController.h"
#import "SLLocationManager.h"
#import "CFSocketManager.h"
#import "NSTimer+Addition.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (nonatomic, strong) CFSocketManager *socketManager;
@property (weak, nonatomic) IBOutlet UIButton *connectBtn;
@property (nonatomic, strong) NSTimer *timer;
@end

static NSString * const DEFAULT_TITLE = @"SLSocketKit";

@implementation ViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = DEFAULT_TITLE;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(uploadLocation) userInfo:nil repeats:YES];
    [self.timer pauseTimer];
    
    self.socketManager = [CFSocketManager manager];
}

#pragma mark - 功能模块
- (IBAction)onClickConnect:(id)sender {
    self.title = @"连接中...";
    [self.socketManager connectTo:@"127.0.0.1" port:1200 success:^{
        [self.timer resumeTimer];
        cf_async_main_queue(^{
            [self.connectBtn setTitle:@"断开连接" forState:UIControlStateNormal];
            self.title = @"连接成功";
        });
     
        cf_delay_main_queue(1, ^{
            self.title = DEFAULT_TITLE;
        });
        

    } failure:^{
        cf_async_main_queue(^{
            self.title = @"连接失败";
        });

        cf_delay_main_queue(1, ^{
            self.title = DEFAULT_TITLE;
        });

    }];
}

- (void)uploadLocation{
    //    @weakify(self);
    [[SLLocationManager sharedManager] getLocationWithSuccess:^(double lat, double lng) {
        //        @strongify(self);
        
        //        @weakify(self);
        cf_async_main_queue(^{
            self.locationLabel.text = [NSString stringWithFormat:@"lat:%0.2f,lng:%0.2f", lat, lng];
        });
        
        self.title = @"发送中...";
        [self.socketManager sendData:[NSString stringWithFormat:@"%f\r\n%f\r\n\r\n", lat, lng] success:^{
            cf_async_main_queue(^{
                self.title = @"发送成功";
            });
  
            cf_delay_main_queue(1, ^{
                self.title = DEFAULT_TITLE;
            });
        } failure:^{
            cf_async_main_queue(^{
                self.title = @"发送失败";
            });
   
            cf_delay_main_queue(1, ^{
                self.title = DEFAULT_TITLE;
            });
        }];
    } Failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
}

@end
