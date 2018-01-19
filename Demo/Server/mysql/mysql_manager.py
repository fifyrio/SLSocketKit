# -*- coding: utf-8 -*-

import MySQLdb
from mysql_settings import MYSQL_HOST, MYSQL_DB, MYSQL_PASSWORD, MYSQL_USER

class MysqlManager(object):
    def __init__(self):
        self.host = MYSQL_HOST
        self.user = MYSQL_USER
        self.password = MYSQL_PASSWORD
        self.db = MYSQL_DB
        self.charset = 'utf8'

    def __connect(self):
        return MySQLdb.connect(host=self.host, user=self.user, passwd=self.password, db=self.db, charset=self.charset)

    def do_insert(self, sql_str, sql_param):
        connect = self.__connect()
        cursor = connect.cursor()
        try:
            cursor.execute(sql_str, sql_param)
            connect.commit()
        except Exception, e:
            print e
            import traceback
            traceback.print_exc()
            # 发生错误时会滚
            connect.rollback()
        finally:
            # 关闭游标连接
            last_id = cursor.lastrowid
            cursor.close()
            # 关闭数据库连接
            connect.close()
            return last_id

    def do_update(self, sql_str, sql_param):
        connect = self.__connect()
        cursor = connect.cursor()
        try:
            cursor.execute(sql_str, sql_param)
            connect.commit()
        except Exception, e:
            print e
            import traceback
            traceback.print_exc()
            # 发生错误时会滚
            connect.rollback()
        finally:
            print 'update success'
            # 关闭游标连接
            cursor.close()
            # 关闭数据库连接
            connect.close()

    def do_count(self, sql_str, sql_param):
        connect = self.__connect()
        cursor = connect.cursor()
        try:
            cursor.execute(sql_str, sql_param)
            connect.commit()
            return cursor.fetchone()
        except Exception, e:
            print e
            import traceback
            traceback.print_exc()
            # 发生错误时会滚
            connect.rollback()
        finally:
            # 关闭游标连接
            cursor.close()
            # 关闭数据库连接
            connect.close()

    def do_query(self, sql_str, sql_param):
        connect = self.__connect()
        cursor = connect.cursor()
        try:
            cursor.execute(sql_str, sql_param)
            return cursor.fetchall()
        except Exception, e:
            print e
            import traceback
            traceback.print_exc()
            # 发生错误时会滚
            connect.rollback()
        finally:
            # 关闭游标连接
            cursor.close()
            # 关闭数据库连接
            connect.close()

    def do_delete(self, sql_str, sql_param):
        connect = self.__connect()
        cursor = connect.cursor()
        try:
            cursor.execute(sql_str, sql_param)
            connect.commit()
        except Exception, e:
            print e
            import traceback
            traceback.print_exc()
            # 发生错误时会滚
            connect.rollback()
        finally:
            # 关闭游标连接
            cursor.close()
            # 关闭数据库连接
            connect.close()





