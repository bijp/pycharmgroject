import requests
from cfg import  vcode
from pprint import pprint
from robot.libraries.BuiltIn import BuiltIn

class  Studentlib:
    Surl = "http://ci.ytesting.com/api/3school/students"
    #列出学生
    def list_students(self):
            params = {
                'vcode':vcode,
                'action':'search_with_pagenation'
                }

            response = requests.get(self.Surl,params=params)
            Dict = response.json()
            pprint (Dict,indent=2)
            return Dict

    #添加学生
    def addstudent(self,username,realname,gradeid,classid,phonenumber,idSavedName=None):
        payload = {
            'vcode'  : vcode,
            'action' : 'add',
            'username': username,
            'realname': realname,
            'gradeid'  : int(gradeid),
            'classid'   : int(classid),
            'phonenumber': phonenumber
        }
        response = requests.post(self.Surl,data=payload)

        bodyDict = response.json()
        pprint (bodyDict,indent=2)
        if idSavedName:
            BuiltIn().set_global_variable('${%s}' % idSavedName,
                                          bodyDict['id'])
            print(f"global var set: ${idSavedName}:{bodyDict['id']}")
        return bodyDict

    #修改学生
    def modifystudent(self,studentid,realname=None,phonenumber=None):
        data={
            'vcode':vcode,
            'action':'modify',
        }
        if realname is not None:
            data['realname'] = realname

        if phonenumber is not None:
            data['phonenumber'] = phonenumber
        URL = '{}/{}'.format(self.Surl, studentid)
        requst = requests.put(URL, data=data)
        respone=requst.json()
        pprint(respone,indent=2)
        return respone
    #删除学生
    def deletestudent(self,studentid):
        payload = {
            'vcode': vcode,
        }

        URL = '{}/{}'.format(self.Surl, studentid)
        response = requests.delete(URL, data=payload)

        bodyDict = response.json()
        pprint(bodyDict, indent=2)
        return bodyDict
    #删除所有学生
    def delete_all_students(self):
        # 列出所有学生
        rd = self.list_students()
        if rd['retcode'] != 0:
            raise Exception('cannot list student!!')

        # 删除列出的所有学生
        for one in rd['retlist']:
            self.deletestudent(one['id'])

        # 再列出所有学生
        rd = self.list_students()

        # 如果没有删除干净，通过异常报错给RF
        if rd['retlist'] != []:
            raise Exception("cannot delete all student!!")

if __name__ == '__main__':
    sl = Studentlib()
    sl.list_students()
    # sl.addstudent('jjj','毕小姐',1,125,18222222222)
    # sl.deletestudent(17969)
    sl.delete_all_students()


