*** Settings ***
Library    pylib.Courselib


*** Test Cases ***
添加班级1 - tc000001
    ${ret1}=    addclass    1     实验1班     58
    should be true     $ret1['retcode']==0
#列出班级，检验一下
    ${ret2}=    listclass    1
    log to console  ${ret2}
    ${fc}=   evaluate   $ret2['retlist'][0]
    should be true    $fc['id']==$ret1['id']
    should be true    $fc['invitecode']==$ret1['invitecode']
    should be true    $fc['grade__name']=='七年级'
    should be true    $fc['studentlimit']==58
    should be true    $fc['name']=='实验1班'

    [Teardown]    deleterclass   $ret1[id]

