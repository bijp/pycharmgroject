*** Settings ***
Library    pylib.Courselib
Library    pylib.Teacher
Suite Setup   addteacher   ppp       毕老师    ${g_subject_math_id}   ${suite_g7c1_classid}    18302045312   323333@qq.com    540522221536511585
Suite Teardown    deleterteacher   ${suite_math_teacher_id}
