*** Settings ***
Library     Courselib.py
Library     Teacherlib.py
Variables   cfg.py
*** Test Cases ***
添加老师2_tc001002
    listteacher
    #添加老师
    ${addte1}=    addteacher   bijp       毕杰萍     ${g_subject_math_id}   ${pt2}    18302045312   323333@qq.com    540522221536511585
    log to console  ${addte1}
    should be true  $addte1['retcode']==0
    ${listea}=       listteacher
    log to console   ${listea}
    ${tes}=     evaluate  $listea['retlist'][0]
    log to console  ${tes}
    ${tes1}=    evaluate  $tes['id']
    should be true   ${tes1}==$addte1['id']
#    [Teardown]       delete_allteacher
    [Teardown]      deleterteacher     ${tes1}