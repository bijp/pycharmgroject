*** Settings ***
Library    pylib.Teacherlib
Library    pylib.Courselib
Library    pylib.Studentlib
Variables  cfg.py
*** Test Cases ***
添加学生1-tc002001
    ${cour}=    listclass   1
    log to console  ${cour}
    log to console  ..........................
    ${courid}=  evaluate  $cour['gradeid']
    ${pt02}=    evaluate    $cour['retlist'][0]
    ${suite_math_teacher_id}=     evaluate    $pt02['id']
    log to console  ....................
    #学校验证码、指明操作、登录名、真实姓名、年级ID号、班级ID号、电话号码

    ${stuadd}=     addstudent       jjj     毕小姐      1    ${suite_math_teacher_id}   18222222222
    log to console      ${stuadd}
    should be true      $stuadd['retcode']==0
    #列出学生信息，判断id是否是创建的id
    ${stulis}=     list_students
    log to console  ..................列出学生
#    log to console         ${stulis}
    ${sturetlist}=       evaluate    $stulis['retlist'][0]
#    log to console      ${sturetlist}
    ${stuid}=       evaluate     $sturetlist['id']
#    log to console      ${stuid}
#    log to console      &{stuadd}[id]
    log to console  ..................列出学生结束
    #返回结果id包含了刚才创建的学生的id
    should be true      ${stuid}==&{stuadd}[id]
    log to console  用例结束
    [Teardown]  deletestudent    &{stuadd}[id]
#    [Teardown]  delete all students
