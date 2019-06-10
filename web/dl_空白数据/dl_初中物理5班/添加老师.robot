*** Settings ***
Library   pylib.Teacherlib
Library    pylib.Courselib
#
#*** Test Cases ***
#添加老师1_tc001001
#    delete_allteacher
#    ${pt}=      listclass  1
##    log to console  ${pt}
#    ${pt1}=    evaluate    $pt['retlist'][0]
#    ${pt2}=     evaluate    $pt1['id']
#    log to console  ${pt2}
#    #列出老师
#    listteacher     1
#
#
##添加老师2_tc001002
##
##添加老师3_tc001003
