*** Settings ***
Library   pylib.Teacherlib
Library    pylib.Courselib
Variables  cfg.py
#Resource    robotlib/rc.robot
Library     pylib.keylib
Library    pylib.Studentlib
#Suite Setup         open_browser2
#Suite Teardown      close_browser2

*** Test Cases ***
老师登录1_tc005001
     ${ret5}=    listclass    1
#    log to console  .................
#    log to console  ${pt}
     ${retadd}=    addclass    1   初中数学    75
     should be true     $retadd['retcode']==0
     ${ret7}=    listclass    1
     log to console   ${ret7}
     ${fck}=   evaluate   $ret7['retlist'][1]
     ${pt2}=     evaluate    $fck['id']
     log to console     ${fck}
     log to console  ...............
    #添加老师,教授学科为初中数学（ID为1）g_subject_math_id    = 1
     ${addte1}=    addteacher   bijp001       毕杰萍     ${g_subject_math_id}   ${pt2}    18302045313   3233363@qq.com    540522221536511586
     should be true     $addte1['retcode']==0
     log to console  ${addte1}
     ${ret8}=    listteacher
     ${fck1}=   evaluate   $ret8['retlist'][0]
     ${pt3}=     evaluate    $fck1['id']
     #登录已创建老师，并点击班级学生按钮， 显示学生列表为空
     open_browser2
     teacher_login       bijp001     888888
#    performs            '.main-menu >ul> li:nth-of-type(4)'     'a[href="#/student_group"] span'
     performs_student
     ${uii}=    get_teacher_class_students_info
     log to console     ${uii}
    sleep  15
    #2. 登录成功，进入老师首页，其中 学校、姓名、学科、金币、已发布微课、已发布作业 的信息正确
    ${teacherinfo}=    get_teacher_homepage_info
    ${eteacherinfo}=  create list      松勤学院00543   毕杰萍
                  ...  初中数学   0   0   0
    should be equal   ${teacherinfo}    ${eteacherinfo}
    #3. 显示学生列表为空
    ${classstudent}=    get_teacher_class_students_info
    should be true   $classstudent=={'七年级初中数学': []}
     close_browser2
    deleterteacher   ${pt3}

    [Teardown]    deleterclass  ${pt2}
#系统中还没有老师，没有学生，已经有班级
 #
 #1. 使用 工具调用创建学生的API，来创建一个学生
 #
 #2. 以创建学生的账号和密码（初始密码为888888）登录 web系统
 #
 #3. 点击 错题库 菜单
# 2. 登录成功，进入学生首页，其中 学校、姓名 、已完成微课、已完成作业 的信息正确
#
#3. 显示 “您尚未有错题入库哦”
学生登录1_tc005081
    #列出班级
    ${pt01}=      listclass  1
    ${pt02}=    evaluate    $pt01['retlist'][0]
    ${suite_classid}=     evaluate    $pt02['id']
    #列出学生
    list_students
    #添加学生李，学校验证码、指明操作、登录名、真实姓名、年级ID号、班级ID号、电话号码
    ${stuadd}=     addstudent       lixue01     学生李生      1    ${suite_classid}   182222222654
    open_browser2
    student_login       lixue01     888888
    ${sthome}=      get_student_homepage_info
    ${sthomelist}=      create list     学生李生   松勤学院00543       0    0
    should be equal     ${sthome}           ${sthomelist}
    ${stwrong}=     get_student_wrongquestions
#    log to console   ${stwrong}

    should be equal     ${stwrong}       您尚未有错题入库哦
    ${stlixue}=     list_students
    ${pt03}=    evaluate    $stlixue['retlist'][0]
    ${st_classid}=     evaluate    $pt03['id']
    [Teardown]  deletestudent  ${st_classid}

