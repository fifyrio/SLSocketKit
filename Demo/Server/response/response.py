# -*- coding: utf-8 -*-
import json
from six import string_types

class Response(object):

    @classmethod
    def json_response(cls, code, data, mes, session_id=''):
        """
        封装返回结果的json
        :param code:
        :param data:
        :param mes:
        :param session_id:
        :return:
        """
        dic = {
            'code': code,
            'data': data,
            'mes': mes,
            'sessionID': session_id
        }

        return json.dumps(dic) + '\r\n\r\n'


