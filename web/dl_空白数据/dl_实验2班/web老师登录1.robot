*** Settings ***
Library   pylib.Teacherlib
Library    pylib.Courselib
Variables  cfg.py
Resource    robotlib/rc.robot
*** Test Cases ***
老师登录1_tc005001
     ${ret5}=    listclass    1
#    log to console  .................哈哈哈
#    log to console  ${pt}
     ${retadd}=    addclass    1   初中数学    75
     should be true     $retadd['retcode']==0
     ${ret7}=    listclass    1
     log to console   ${ret7}
     ${fck}=   evaluate   $ret7['retlist'][1]
     ${pt2}=     evaluate    $fck['id']
     log to console     ${fck}
     log to console  ...............哈哈哈
    #添加老师,教授学科为初中数学（ID为1）g_subject_math_id    = 1
    ${addte1}=    addteacher   bijp001       毕杰萍     ${g_subject_math_id}   ${pt2}    18302045313   3233363@qq.com    540522221536511586
    should be true     $addte1['retcode']==0
    log to console  ${addte1}
    ${ret8}=    listteacher
    ${fck1}=   evaluate   $ret8['retlist'][0]
     ${pt3}=     evaluate    $fck1['id']

    loginteacher    bijp001     888888

#    close window
#    deleterteacher   ${pt3}

#    [Teardown]    deleterclass  ${pt2}

#老师登录2_tc005002