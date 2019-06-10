import requests
from cfg import vcode
from pprint import pprint
import json

class Teacherlib:
    Turl='http://ci.ytesting.com/ci.ytesting.com/api/3school/teachers'
    #列出老师
    def listteacher(self,subjectid):
        if subjectid != None:
            params = {
                'vcode': vcode,
                'action': 'search_with_pagenation',
                'gradeid': int(subjectid)
            }
        else:
            params = {
                'vcode': vcode,
                 'action': 'search_with_pagenation',
            }

        response = requests.get(self.Turl, params=params)
        # 获取结果，返回给调用者
        self.retDict = response.json()
        pprint(self.retDict, indent=2)
        return self.retDict
    #添加老师
    #username	必填	登录名
    # realname	必填	真实姓名
    # subjectid	必填	教授学科ID号
    # classlist	必填	教授班级ID列表，是json格式的字符串
    # phonenumber	必填	电话号码
    # email	必填	邮箱
    # idcardnumber	必填	身份证号
    def addteacher(self,username,realname,subjectid,classlist,phonenumber,email,idcardnumber):
        payload = {
            'vcode': vcode,
            'action': 'add',
            'username': username,
            'realname': realname,
            'subjectid': int(subjectid),
            'classlist': {json.dumps(classlist)},
            'phonenumber': int(phonenumber),
            'email': email,
            'idcardnumber':int(idcardnumber)

        }
        request = requests.post(self.Turl, data=payload)
        redir = request.json()
        pprint(redir, indent=2)
        return redir

    # 删除班级
    # classid	必填	要删除班级的ID号	比如：11
    # vcode	必填	学校验证码	比如：00000005480978742527
    def deleterteacher(self, teacherid):
        parlode = {
            'vcode': vcode
        }
        URL = '{}/{}'.format(self.Turl, teacherid)
        requst = requests.delete(URL, data=parlode)
        respone = requst.json()
        pprint(respone, indent=2)
        return respone

    def delete_allteacher(self):

        list = self.listteacher()
        pprint(list, indent=2)
        # 删除列出
        for one in list['retlist']:
            self.deleterclass(one['id'])
        # 再删除所有
        list = self.listteacher()
        pprint(list, indent=2)
        if list['retlist'] != []:
            raise Exception("没有删除完所有老师")


    def modifyclass(self,teacherid,username,realname,subjectid,classlist,phonenumber,email,idcardnumber):
        data = {
            'vcode': vcode,
            'action': 'modify',
            'username': username,
            'realname': realname,
            'subjectid': int(subjectid),
            'classlist': {json.dumps(classlist)},
            'phonenumber': int(phonenumber),
            'email': email,
            'idcardnumber':int(idcardnumber)
        }
        URL = '{}/{}'.format(self.Turl, teacherid)
        requst = requests.put(URL, data=data)
        respone = requst.json()
        pprint(respone, indent=2)
        return respone


# if __name__ == '__main__':
    # Teacherlib.modifyclass(2,22,22)
    # addclass(1,'高一班级',20)