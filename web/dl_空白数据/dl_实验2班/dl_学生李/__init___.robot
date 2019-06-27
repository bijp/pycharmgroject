#*** Settings ***
#Library   pylib.Teacherlib
#Library    pylib.Courselib
#Library    pylib.Studentlib
#Variables  cfg.py
##Suite Setup       addweblixue
##Suite Teardown    deleteweblixue
#*** Keywords ***
#addweblixue
#    ${pt01}=      listclass  1
#    ${pt02}=    evaluate    $pt01['retlist'][0]
#    ${suite_classid}=     evaluate    $pt02['id']
#    #列出学生
#    list_students
#    #添加学生李，学校验证码、指明操作、登录名、真实姓名、年级ID号、班级ID号、电话号码
#    ${stuadd}=     addstudent       lixue     学生李      1    ${suite_classid}   182222222654
#
#deleteweblixue
#    #删除学生李
#    ${listea01}=       list_students
#    log to console   ${listea01}
#    ${tes02}=     evaluate  $listea01['retlist'][0]
#    log to console  ${tes02}
#    ${tes03}=    evaluate  $tes02['id']
#    [Teardown]      deleterteacher     ${tes03}