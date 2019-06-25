*** Settings ***
Library    pylib.Teacherlib
Library    pylib.Courselib
Library    pylib.Studentlib
Variables  cfg.py
Suite Setup       addjjj01
Suite Teardown    deletejjj01

*** Keywords ***
addjjj01
    ${cou}=    listclass   1
    ${courid}=  evaluate  $cou['gradeid']
    ${pt02}=    evaluate    $cou['retlist'][0]
    ${suite_math_teacher_id}=     evaluate    $pt02['id']
    ${stuadd}=     addstudent       jjj01     学生毕小姐      ${courid}    ${suite_math_teacher_id}   18222222223

deletejjj01
    ${stulist}=     list students
    log to console  ${stulist}
    ${tes02}=     evaluate  $stulist['retlist'][0]

    ${tes03}=    evaluate  $tes02['id']
    deletestudent     ${tes03}


