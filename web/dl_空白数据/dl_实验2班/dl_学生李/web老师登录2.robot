*** Settings ***
Library   pylib.Teacherlib
Library    pylib.Courselib
Variables  cfg.py
Library    pylib.Studentlib
Resource    robotlib/rc.robot
Library     pylib.keylib
#Suite Setup         open_browser2
#Suite Teardown      close_browser2

*** Test Cases ***
老师登录2_tc005002
#      ${ret5}=    listclass    1
#    log to console  .................
#    log to console  ${pt}
#     ${retadd}=    addclass    1   初中数学    75
#     should be true     $retadd['retcode']==0
     addweblixue
     ${ret7}=    listclass    1
     log to console   ${ret7}
     ${fck}=   evaluate   $ret7['retlist'][0]
     ${pt2}=     evaluate    $fck['id']
     log to console     ${fck}
     log to console  ...............班级列出已完毕

#     log to console    ${ty2u}
    #添加老师,教授学科为初中数学（ID为1）g_subject_math_id    = 1
     ${addte1}=    addteacher   bijp005       毕杰萍     ${g_subject_math_id}   ${pt2}    18302045555   32333463@qq.com    450522221536511586
     should be true     $addte1['retcode']==0
     log to console  ${addte1}
     ${tyu}=     list_students
     log to console    ${tyu}
     ${ret8}=    listteacher
     ${fck1}=   evaluate   $ret8['retlist'][0]
     ${pt3}=     evaluate    $fck1['id']
     #登录已创建老师，并点击班级学生按钮， 显示学生列表为空
     open_browser2
     teacher_login       bijp005     888888
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
#    ${classstudent}=    get_teacher_class_students_info
#    should be true   $classstudent=={'七年级初中数学': []
     close_browser2
#    deleteweblixue
    #删除学生李
    ${listea01}=       list_students
    log to console   ${listea01}
    ${tes02}=     evaluate  $listea01['retlist'][0]
    log to console  ${tes02}
    ${tes03}=    evaluate  $tes02['id']
    deleterteacher     ${tes03}
    deleterteacher   ${pt3}

    [Teardown]    deleterclass  ${pt2}



