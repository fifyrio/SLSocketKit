//
//  SLLoginViewController.m
//  SLSocketKitDemo
//
//  Created by wuw on 2018/1/16.
//  Copyright © 2018年 Will. All rights reserved.
//

#import "SLLoginViewController.h"
#import "SLShareLocationViewController.h"
#import "SLAsyncSocketManager.h"
#import "NSDictionary+SLSocket.h"

@interface SLLoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *createAccountBtn;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (nonatomic, copy) NSString *username;

@end

@implementation SLLoginViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindWithCreateAccountBtn];
    [self bindWithUsernameTextField];    
}

#pragma mark - Actions
- (void)bindWithCreateAccountBtn{
    @weakify(self);
    [[self.createAccountBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        if (!self.username.length) {
            xy_fifo_showStatus(@"请输入您的大名");
            return;
        }

        SLSocketConnectSerializer *connectSeri = [SLSocketConnectSerializer serializerWithHost:HOST port:PORT];
        [[SLAsyncSocketManager sharedInstance] connectWithSerializer:connectSeri completionHandler:^{
            NSDictionary *body = @{@"username":self.username};
            
            SLSocketRequestSerializer *request = [SLSocketRequestSerializer serializerWithVersion:PROTOCOL_VERSION reqType:REQ_TYPE_CREATE_ACCOUNT body:[body sl_dictionaryToJsonString]];
            [[SLAsyncSocketManager sharedInstance] dataTaskWithRequest:request completionHandler:^(NSError *error, id responseDict) {
                if (!error) {
                    if ([responseDict[@"code"] integerValue] == 200) {
                        NSString *userID = responseDict[@"data"][@"userID"];
                        
                        SLShareLocationViewController *vc = [[SLShareLocationViewController alloc] init];
                        vc.mainViewModel.userID = userID;
                        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
                        [self presentViewController:navVC animated:YES completion:nil];
                    }
                    
                }else{
                    //                [[SLAsyncSocketManager sharedInstance] disconnectWithCompletionHandler:nil];
                    xy_fifo_showStatus(error.userInfo[NSLocalizedDescriptionKey]);
                }
            }];
        }];
    }];
}

- (void)bindWithUsernameTextField{
    RAC(self, username) = [self.usernameTextField rac_textSignal];
//    [RACObserve(self.usernameTextField, text) subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
//    [[self.usernameTextField rac_textSignal] subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
}

@end
