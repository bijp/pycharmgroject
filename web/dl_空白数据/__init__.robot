*** Settings ***
Library    pylib.Courselib
Library    pylib.Teacherlib
Suite Setup   Run Keywords  delete_allclass   AND   delete_allteacher