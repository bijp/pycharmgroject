*** Settings ***
Library    pylib.Courselib
Suite Setup      addclass    1   实验2班    55
Suite Teardown   delete_allclass