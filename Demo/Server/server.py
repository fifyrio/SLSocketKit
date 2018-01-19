# -*- coding: utf-8 -*-

import socket
import threading
import time
from response.response import Response
import json
from api.api import createAccount, updateUserLocation, queryCurrentUsers

REQ_TYPE_CREATE_ACCOUNT = 1
REQ_TYPE_UPLOAD_LOCATION = 2

def tcplink(sock, addr):
    print 'connected to %s:%s...!' % addr
    sock.send(Response.json_response(200, [], 'success', ''))
    while True:
        data = sock.recv(1024)
        time.sleep(1)
        if data == 'exit' or not data:
            break
        json_obj = json.loads(data)
        session_id = json_obj['sessionID']
        if json_obj['reqType'] == REQ_TYPE_UPLOAD_LOCATION:
            updateUserLocation(json_obj['body'])
            new_data = queryCurrentUsers()
            str = Response.json_response(200, new_data, 'success', session_id)
            sock.send(str)
            print "send -- %s" % str
        elif json_obj['reqType'] == REQ_TYPE_CREATE_ACCOUNT:
            body = json_obj['body']
            insert_id = createAccount(body['username'])
            data = {'userID': insert_id}
            str = Response.json_response(200, data, 'success', session_id)
            sock.send(str)
            print "send -- %s" % str
        # print "send -- Hello %s" % data
        # sock.send('Hello %s' % data)
    sock.close()
    print '%s:%s closed!' % addr



if __name__ == "__main__":
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    # 监听端口:
    s.bind(('127.0.0.1', 9999))

    s.listen(5)
    print 'Waiting for connection...'

    while True:
        sock, addr = s.accept()
        t = threading.Thread(target=tcplink, args=(sock, addr))
        t.start()

