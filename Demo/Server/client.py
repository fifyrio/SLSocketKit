# -*- coding: utf-8 -*-

import socket
import time

if __name__ == "__main__":
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect(('127.0.0.1', 9999))

    # 接收欢迎消息:
    print s.recv(1024)

    for mes in ['Will', 'Arenas', 'Carter']:
        s.send(mes)
        print s.recv(1024)
        time.sleep(1)

    # 关闭连接:
    s.send('exit')
    s.close()


