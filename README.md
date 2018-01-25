# SLSocketKit
iOS端对socket的封装
![Demo Overview](https://github.com/SoulLights/SLSocketKit/blob/master/Screenshots/screenshots.gif)

## 如何使用
### 客户端
安装pod库，run即可
### 服务端
1. 创建数据库名字为sl_socket_kit的数据库(需要有mysql数据库)
2. 执行```createTable.sql```里的sql语句
3. 执行```python server.py```

### Server目录介绍

- ```createTable.sql```是创建数据库的sql语句

- ```api.py```主要是网络请求的封装
- ```server.py```是服务端启动主程序
- ```client.py```是可以做测试用的客户端程序，可忽略



