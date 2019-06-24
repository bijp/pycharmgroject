import requests
from cfg import  vcode
from pprint import pprint


class  StudentsLib:
    Surl = "http://ci.ytesting.com/ci.ytesting.com/api/3school/students"

    def deletestudent(self,classid):
        payload = {
            'vcode'  : vcode,
        }

        url = '{}/{}'.format(self.Surl,classid)
        response = requests.delete(url,data=payload)

        return response.json()


    def list_students(self,gradeid=None):
        if gradeid != None:
            params = {
                'vcode':vcode,
                'action':'search_with_pagenation',
                'gradeid':int(gradeid)
            }
        else:
            params = {
                'vcode':vcode,
                'action':'search_with_pagenation'
            }

        response = requests.get(self.Surl,params=params)

        bodyDict = response.json()
        pprint (bodyDict,indent=2)
        return bodyDict


    def add_student(self,username,realname,gradeid,classid,ptonenumber):
        payload = {
            'vcode'  : vcode,
            'action' : 'add',
            'username': username,
            'realname': realname,
            'grade'  : int(gradeid),
            'classid'   : classid,
            'ptonenumber'  : int(ptonenumber),
        }
        response = requests.post(self.Surl,data=payload)

        bodyDict = response.json()
        pprint (bodyDict,indent=2)
        return bodyDict


    def delete_all_students(self):
        # 先列出所有班级
        rd =  self.list_school_class()
        pprint(rd, indent=2)

        # 删除列出的所有班级
        for one in rd['retlist']:
            self.delete_school_class(one['id'])

        #再列出七年级所有班级
        rd =  self.list_school_class(1)
        pprint (rd,indent=2)

        # 如果没有删除干净，通过异常报错给RF
        # 参考http://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#reporting-keyword-status
        if rd['retlist'] != []:
            raise  Exception("cannot delete all school classes!!")

if __name__ == '__main__':
    scm = StudentsLib()
    scm.list_students()
    # ret = scm.list_school_class(1)


