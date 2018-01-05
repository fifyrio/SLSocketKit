//
//  CTypeViewController.m
//  tableView
//
//  Created by wuw on 2018/1/5.
//  Copyright © 2018年 Kingnet. All rights reserved.
//

#import "CTypeViewController.h"
#import <arpa/inet.h>
#import <netinet/in.h>
#import <sys/socket.h>

@interface CTypeViewController (){
    int _clientSocket;
}
@property (weak, nonatomic) IBOutlet UIButton *connectBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UITextField *sendTextField;
@property (weak, nonatomic) IBOutlet UILabel *receiveLabel;

@end

@implementation CTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     1.AF_INET: ipv4 执行ip协议的版本
     2.SOCK_STREAM：指定Socket类型,面向连接的流式socket 传输层的协议
     3.IPPROTO_TCP：指定协议。 IPPROTO_TCP 传输方式TCP传输协议
     返回值 大于0 创建成功
     */
    _clientSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    
    [self bindWithConnectBtn];
    [self bindWithSendBtn];
    [self bindWithReceiveLabel];
}

- (void)bindWithConnectBtn{
    @weakify(self);
    [[self.connectBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self connectToServer];
    }];
}

- (void)bindWithSendBtn{
    @weakify(self);
    [[self.sendBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self sendData];
    }];
}

- (void)bindWithReceiveLabel{
    dispatch_queue_t q_con = dispatch_queue_create("CONCURRENT", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(q_con, ^{
        char *buf[1024];
        ssize_t recvLen = recv( _clientSocket, buf, sizeof(buf), 0);
        NSString *recvStr = [[NSString alloc] initWithBytes:buf length:recvLen encoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.receiveLabel.text = recvStr;
        });
    });
}


/**
 连接服务器，服务器用终端'netcat  nc -lk 12345'模拟，需要安装netcat
 */
- (void)connectToServer{
    struct sockaddr_in addr;
    addr.sin_family = AF_INET;//AF_INET ipv4协议
    addr.sin_port=htons(12345);//服务器端口
    addr.sin_addr.s_addr = inet_addr("127.0.0.1");//服务器地址
    int connectResult= connect( _clientSocket, (const struct sockaddr *)&addr, sizeof(addr));//参数二：指向数据结构sockaddr的指针，其中包括目的端口和IP地址，参数三：sockaddr的长度，返回值：int -1失败 、0 成功
    if (connectResult == 0) {
        NSLog(@"连接成功");
        [self.connectBtn setTitle:@"断开连接" forState:UIControlStateNormal];
    }else{
        NSLog(@"连接失败");
    }
}

- (void)sendData{
    const char * str = [self.sendTextField.text UTF8String];
    ssize_t sendLen = send( _clientSocket, str, strlen(str), 0);//第二个参数指明一个存放应用程式要发送数据的缓冲区；第三个参数指明实际要发送的数据的字符数；第四个参数一般置0。
    if (sendLen > 0) {
        NSLog(@"发送成功");
    }else{
        NSLog(@"发送失败");
    }
}

- (void)receiveData{
    char *buf[1024];
    ssize_t recvLen = recv( _clientSocket, buf, sizeof(buf), 0);
    NSLog(@"---->%ld",recvLen);
}

@end
