# Question
- NSUUID有在AFN中使用吗，是唯一的吗
- 如何将GCDAsyncSocket改成block形式的，delegate太不方便，同时如何跟ReactiveCocoa结合，用RACComand方式
- 如何设置请求的唯一识别码，以获取正确的返回结果
- AFNetWorking中的请求设置唯一标识有什么用
- AFImageDownloader的原理是什么，我们如何控制下载图片中的并发
- 比较socket与http的延迟差

# Answer
- 这段代码

```
[self.clientSocket connectToHost:HOST onPort:PORT viaInterface:nil withTimeout:-1 error:&error];
```
<sub>Timeout是-1表示等待无穷大，一直等待</sub>

- 如何设置传递字符串格式，是用json吗？结尾符如何设置？
<sub>设置成```{'verson':'','type':'','body':''}```的json格式，返回的结果结尾用```\r\n\r\n```表示</sub>

- CocoaAsyncSocket如何设置多线程的?

<sub>通过GCD的异步串行队列，避免线程的阻塞

```objectivec
dispatch_async(socketQueue, ^{ @autoreleasepool {//socketQueue就是自定义的串行队列
		//线程处理的内容
	}});
```

</sub>


- 多个设备同时连接socket服务器，只能一个连接成功，如果支持多个？

<sub>运用python里的多线程，每连接一个，创建一个线程来处理</sub>


