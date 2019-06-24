*** Settings ***
Library   pylib.Teacherlib
Library    pylib.Courselib
Variables  cfg.py
*** Test Cases ***
添加老师2_tc001002
#    listteacher
    ${pt00}=      listclass  1
    ${pt001}=    evaluate    $pt00['retlist'][0]
    ${pt002}=     evaluate    $pt001['id']
    #新创建一个班级
    ${pt003}=    addclass    1    实验8班     88
#    ${tes0001}=    evaluate  $pt003['id']
#    log to console      ${tes0001}
    should be true     $pt003['retcode']==0
    #添加老师
    ${addte01}=    addteacher   bijp2       毕杰萍1     1   &{pt003}[id]  18711049401   3213333@qq.com    540522221536511586
    #${g_subject_math_id}
    log to console  ${addte01}
    should be true  $addte01['retcode']==0
    ${listea00}=       listteacher
    log to console   ${listea00}
    ${tes01}=     evaluate  $listea00['retlist'][1]
    log to console  ${tes01}
    ${tes001}=    evaluate  $tes01['id']
    should be true   ${tes001}==$addte01['id']
#    deleterteacher     ${tes001}
#    deleterclass   &{pt003}[id]
    [Teardown]
                deleterteacher     ${tes001}
                deleterclass   &{pt003}[id]
