*** Settings ***
Library   pylib.Teacherlib
Library    pylib.Courselib
Variables  cfg.py
Suite Setup       addppp
Suite Teardown    deleterppp
*** Keywords ***
addppp
    ${pt01}=      listclass  1
    ${pt02}=    evaluate    $pt['retlist'][0]
    ${suite_math_teacher_id}=     evaluate    $pt1['id']
    #列出老师
    listteacher
    ${add1}=     addteacher   ppp       毕老师    ${g_subject_math_id}   ${suite_math_teacher_id}    18302045312   323333@qq.com    540522221536511585

deleterppp
    ${listea01}=       listteacher
    log to console   ${listea01}
    ${tes02}=     evaluate  $listea01['retlist'][0]
    log to console  ${tes02}
    ${tes03}=    evaluate  $tes02['id']
    [Teardown]      deleterteacher     ${tes03}