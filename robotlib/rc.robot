*** Settings ***
Library   pylib.Teacherlib
Library    pylib.Courselib
Variables  cfg.py
Library  SeleniumLibrary

*** Keywords ***
loginteacher
    [Arguments]   ${username}       ${password}
    open web
    maximize browser window
    input text  id=username     ${username}
    input text  id=password     ${password}
    click element   id=submit
    set browser implicit wait  15
#    close web
    set browser implicit wait  30

    sleep  5
#    close window
open web
    OPEN BROWSER  http://ci.ytesting.com/teacher/login/login.html   chrome
    set browser implicit wait  10
close web
    close browser