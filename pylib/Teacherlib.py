import requests
from cfg import vcode
from pprint import pprint
import json
from robot.libraries.BuiltIn import BuiltIn

class Teacherlib:
    Turl='http://ci.ytesting.com/api/3school/teachers'
    #列出老师
    def listteacher(self, subjectid=None):
        if subjectid != None:
            params = {
                'vcode': vcode,
                'action': 'search_with_pagenation',
                'subjectid': int(subjectid)
            }
        else:
            params = {
                'vcode': vcode,
                'action': 'search_with_pagenation'
            }

        response = requests.get(self.Turl, params=params)

        bodyDict = response.json()
        pprint(bodyDict, indent=2)

        return bodyDict
    # 添加老师
    # username	必填	登录名
    # realname	必填	真实姓名
    # subjectid	必填	教授学科ID号
    # classlist	必填	教授班级ID列表，是json格式的字符串
    # phonenumber	必填	电话号码
    # email	必填	邮箱
    # idcardnumber	必填	身份证号
    def addteacher(self,username,realname,subjectid,classlist,phonenumber,email,idcardnumber,idsaveName=None):
        classlist=str(classlist)
        newclasslist=[{'id':oneid} for oneid in  classlist.split(',') if oneid]
        payload = {
            'vcode': vcode,
            'action': 'add',
            'username': username,
            'realname': realname,
            'subjectid': int(subjectid),
            'classlist': {json.dumps(newclasslist)},
            'phonenumber': int(phonenumber),
            'email': email,
            'idcardnumber':int(idcardnumber)

        }
        request = requests.post(self.Turl, data=payload)
        redir = request.json()
        pprint(redir, indent=2)
        if idsaveName:
            BuiltIn().set_global_veriable('${%s}' % idsaveName,redir['id'])
            print(f"global var set: ${idsaveName}:{redir['id']}")
        return redir

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
        if list['retcode'] != 0:
            raise Exception('cannot list teachers!!')
        # 删除列出
        for one in list['retlist']:
            self.deleterteacher(one['id'])
        # 再删除所有
        list = self.listteacher()
        pprint(list, indent=2)
        if list['retlist'] != []:
            raise Exception("没有删除完所有老师")


    def modifyclass(self,teacherid,realname=None,subjectid=None,classlist=None,phonenumber=None,email=None,idcardnumber=None):
        payload = {
            'vcode': self.vcode,
            'action': 'modify'
        }
        if realname is not None:
            payload['realname'] = realname
        if subjectid is not None:
            payload['subjectid'] = subjectid
        if phonenumber is not None:
            payload['phonenumber'] = phonenumber
        if email is not None:
            payload['email'] = email
        if idcardnumber is not None:
            payload['idcardnumber'] = idcardnumber
        if classlist is not None:
            # classlist 是这种格式的字符串 "1,2,3"，需要转换为python列表
            classlist = str(classlist)
            newClassList = [{'id': oneid} for oneid in classlist.split(',') if oneid]
            payload['classlist'] = json.dumps(newClassList)
        URL = '{}/{}'.format(self.Turl, teacherid)
        requst = requests.put(URL, data=payload)
        respone = requst.json()
        pprint(respone, indent=2)
        return respone


if __name__ == '__main__':
    scm = Teacherlib()
    ret = scm.listteacher()
    scm.delete_allteacher()
