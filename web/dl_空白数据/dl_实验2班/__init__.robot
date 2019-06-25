*** Settings ***
Library    pylib.Courselib
Suite Setup      addclass    1   实验2班    55
Suite Teardown     delete_allclass
#AND     delete_all_students         AND     delete_allteacher


#Suite Setup      addclass    1   实验2班    55     suite_g7c1_classid
#Suite Teardown   delete_allclass           ${suite_g7c1_classid}