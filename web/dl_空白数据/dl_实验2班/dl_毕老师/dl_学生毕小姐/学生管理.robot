*** Settings ***
Library    pylib.Teacherlib
Library    pylib.Courselib
Library    pylib.Studentlib
Variables  cfg.py

*** Test Cases ***
添加学生2_tc002002
    ${stulist}=     list students
    log to console  ${stulist}
#    ${listea01}=       listteacher
#    log to console   ${listea01}
    ${tes02}=     evaluate  $stulist['retlist'][0]
    ${tes03}=    evaluate  $tes02['id']
    #列出课程，找出课程id和班级的classid
    ${cour}=    listclass   1
#    log to console  ${cour}
#    log to console  ..........................
    ${courid}=  evaluate  $cour['gradeid']
    ${pt02}=    evaluate    $cour['retlist'][0]
    ${suite_math_teacher_id}=     evaluate    $pt02['id']
    #学校验证码、指明操作、登录名、真实姓名、年级ID号、班级ID号、电话号码

    ${stuadd}=     addstudent       jjj02     毕小姐02      1    ${suite_math_teacher_id}   18222222202
    log to console      ${stuadd}
    should be true      $stuadd['retcode']==0
    ${stulist2}=        list students
    ${stuid02}=         evaluate        $stulist2['retlist'][1]
    ${addid2}=          evaluate        $stuid02['id']
    should be true      ${addid2}==$stuadd['id']
    log to console      .....................添加学生2_tc002002
    [Teardown]      deletestudent     ${addid2}
删除学生1_tc002081
    ${cour3}=    listclass   1
    log to console  ..........................
    ${courid3}=  evaluate  $cour3['gradeid']
    ${pt03}=    evaluate    $cour3['retlist'][0]
    ${suite_math_teacher_id}=     evaluate    $pt03['id']
    ${stuadd3}=     addstudent       jjj03     毕小姐03      1    ${suite_math_teacher_id}   18222222202
    ${stulist3}=        list students
    ${stuid03}=         evaluate        $stulist3['retlist'][1]
    ${addid3}=          evaluate        $stuid03['id']
    ${delete}=            deletestudent       ${addid3}
    log to console      .....................删除学生1_tc002081