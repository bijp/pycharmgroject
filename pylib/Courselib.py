import requests
from cfg import vcode
from pprint import pprint
from robot.libraries.BuiltIn import BuiltIn

class Courselib:
    Curl="http://ci.ytesting.com/api/3school/school_classes"
    # def __init__(self):
    #     self.vcode = vcode
    # def set_vcode(self, vcode):
    #     self.vcode = vcode
    # 列出班级
    # vcode	必填	学校验证码	比如：00000005480978742527
    # action	必填	指明操作	list_classes_by_schoolgrade
    # gradeid	可选	指明年级的id号。
    # 如果没有该参数，则表示列出所有年级的班级	比如：1
    def listclass(self, gradeid=None):
        if gradeid != None:
            params = {
                'vcode': vcode,
                'action': 'list_classes_by_schoolgrade',
                'gradeid': int(gradeid)
            }
        else:
            params = {
                'vcode': vcode,
                'action': 'list_classes_by_schoolgrade',
            }
        response = requests.get(self.Curl, params=params)
        # 获取结果，返回给调用者
        self.retDict = response.json()
        pprint(self.retDict, indent=2)
        return self.retDict

    # 添加班级
    # """vcode	必填	学校验证码	比如：00000005480978742527
    # action	必填	指明操作	add
    # grade	必填	指明年级的id号	比如：1
    # name	必填	指明添加班级的名称。
    # 长度范围为 1 - 20 个字符	比如：实验1班
    # studentlimit	必填	指明班级学生的人数上限	比如：80"""
    def addclass(self,grade,name,studentlimit,idSavedName=None):
        payload={
            'vcode':vcode,
            'action':'add',
            'grade': int(grade),
            'name':name,
            'studentlimit':int(studentlimit)
        }
        request=requests.post(self.Curl,data=payload)
        redir=request.json()
        pprint (redir,indent=2)
        if idSavedName:
            print('before')
            BuiltIn().set_global_variable('${%s}' % idSavedName, redir['id'])
            print(f"global var set: ${idSavedName}:{redir['id']}")
        return redir

    #删除班级
    # classid	必填	要删除班级的ID号	比如：11
    # vcode	必填	学校验证码	比如：00000005480978742527
    def deleterclass(self,classid):
        parlode={
            'vcode':vcode
        }
        URL='{}/{}'.format(self.Curl,classid)
        requst=requests.delete(URL,data=parlode)
        respone=requst.json()
        pprint (respone,indent=2)
        return respone
    def delete_allclass(self):
        #先列出所有班级
        list=self.listclass()
        pprint (list,indent=2)
        #删除列出所有的班级
        for one in list['retlist']:
            self.deleterclass(one['id'])
        #再删除所有的课程
        list=self.listclass()
        pprint (list,indent=2)
        if list['retlist']!=[]:
            raise Exception("没有删除完所有课程")
    #修改班级
    # vcode	必填	学校验证码	比如：00000005480978742527
    # action	必填	指明操作	modify
    # name	必填	指明添加班级的名称。
    # 长度范围为 1 - 20 个字符	比如：实验1班
    # studentlimit	必填	指明班级学生的人数上限	比如：80
    def modifyclass(self,classid,name,studentlimit):
        data={
            'vcode':vcode,
            'action':'modify',
            'name':name,
            'studentlimit':int(studentlimit)
        }
        URL = '{}/{}'.format(self.Curl, classid)
        requst = requests.put(URL, data=data)
        respone=requst.json()
        pprint(respone,indent=2)
        return respone


if __name__ == '__main__':
    scm = Courselib()
    # ret = scm.listclass(1)
    scm.delete_allclass
    # addclass(1,'高一班级',20)