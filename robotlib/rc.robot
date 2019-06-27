*** Settings ***
Library   pylib.Teacherlib
Library    pylib.Courselib
Variables  cfg.py
Library  SeleniumLibrary
Library    pylib.Studentlib
#
#*** Keywords ***
#loginteacher
#    [Arguments]   ${username}       ${password}
#    open web
#    maximize browser window
#    input text  id=username     ${username}
#    input text  id=password     ${password}
#    click element   id=submit
#    set browser implicit wait  15
##    close web
#    set browser implicit wait  30
#
#    sleep  5
##    close window
#open web
#    OPEN BROWSER  http://ci.ytesting.com/teacher/login/login.html   chrome
#    set browser implicit wait  10
#close web
#    close browser


*** Keywords ***
addweblixue
    ${pt01}=      listclass  1
    ${pt02}=    evaluate    $pt01['retlist'][0]
    ${suite_classid}=     evaluate    $pt02['id']
    #列出学生
    list_students
    #添加学生李，学校验证码、指明操作、登录名、真实姓名、年级ID号、班级ID号、电话号码
    ${stuadd}=     addstudent       lixue     学生李      1    ${suite_classid}   182222222654

deleteweblixue
    #删除学生李
    ${listea01}=       list_students
    log to console   ${listea01}
    ${tes02}=     evaluate  $listea01['retlist'][0]
    log to console  ${tes02}
    ${tes03}=    evaluate  $tes02['id']
    [Teardown]      deleterteacher     ${tes03}