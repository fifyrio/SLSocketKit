# -*- coding: utf-8 -*-

from mysql.mysql_manager import MysqlManager

def createAccount(username):
    """
    创建账户
    :param username:
    :return:
    """
    mysql_manager = MysqlManager()
    sql = "INSERT INTO `user` (`username`) VALUES (%s);"
    params = (username, )
    return mysql_manager.do_insert(sql, params)

def updateUserLocation(body):
    """
    更新数据库里用户位置
    :param body:
    :return:
    """
    mysql_manager = MysqlManager()
    user_id = body['userId']
    lat = body['lat']
    lng = body['lng']
    sql = "UPDATE user SET lat=%s, lng=%s, isOnline=1 WHERE userId = %s"
    params = (lat, lng, user_id)
    mysql_manager.do_update(sql, params)

def queryCurrentUsers():
    """
    返回当前在线的用户列表
    :return:
    """
    mysql_manager = MysqlManager()
    sql = "SELECT userId, username, lat, lng FROM `user` WHERE isOnline = 1"
    params = ()
    results = mysql_manager.do_query(sql, params)
    data_list = []
    for result in results:
        data = {
            'userId': result[0],
            'userName': result[1],
            'lat': result[2],
            'lng': result[3]
        }
        data_list.append(data)
    return data_list

def logOff(body):
    """
    退出登录
    :param body:
    :return:
    """
    pass