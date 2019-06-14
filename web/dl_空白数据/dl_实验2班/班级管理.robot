*** Settings ***
Library    pylib.Courselib

*** Test Cases ***
删除班级1_tc000081
    ${ret2}=     listclass  1
    ${ret4}=    deleterclass   22
    should be true  $ret4['retcode']==404
    should be true   $ret4['reason']=='id 为`22`的班级不存在'


删除班级2_tc000082

    ${ret02}=     listclass  1
    log to console   ${ret02}
    ${ret03}=    addclass    1   实验3班    55
    should be true     $ret03['retcode']==0
    ${ret04}=       deleterclass   &{ret03}[id]
    log to console  ${ret04}
    listclass  1
    should be true  $ret04['retcode']==0
#    ${ret05}=       listclass   1
#    log to console  ${ret05}
#    should be true  $ret05['retcode']==0
#    should be true  $ret05['retlist']==[]
#    should not be equal  $ret01['id']  $ret05['id']
    [Teardown]   deleterclass   &{ret03}[id]
添加班级2 - tc000002
    ${ret5}=    listclass    1
#    log to console   ${ret5}
    ${ret6}=    addclass    1   实验3班    55
    should be true     $ret6['retcode']==0
    log to console      ${ret6}
    ${ret7}=    listclass    1
    log to console   ${ret7}
    ${fck}=   evaluate   $ret7['retlist'][1]
    log to console     ${fck}
    should be true    $fck['id']==$ret6['id']
    should be true    $fck['invitecode']==$ret6['invitecode']
    should be true    $fck['grade__name']=='七年级'
    should be true    $fck['studentlimit']==55
    should be true    $fck['name']=='实验3班'
    [Teardown]    deleterclass   &{ret6}[id]

添加班级3- tc000003
        ${ret03}=    listclass    1
        log to console   ${ret03}
        ${ret04}=    addclass    1   实验2班    55
        should be true     $ret04['retcode']==1
        ${ret05}=    listclass    1
        log to console   ${ret05}
        ${ck}=   evaluate   $ret05['retlist'][0]
#        should be true    $ck['id']==$ret03['id']
#        should be true    $ck['invitecode']==$ret04['invitecode']
        should be true    $ck['grade__name']=='七年级'
        should be true    $ck['studentlimit']==55
        should be true    $ck['name']=='实验2班'

修改班级1_tc000051
    ${rc2}=     listclass  1
    log to console   ${rc2}
    ${rk}=   evaluate   $rc2['retlist'][0]
    ${rc3}=    evaluate   $rk['id']
    log to console      ${rc3}
    ${rc4}=     modifyclass     ${rc3}    实验9班    70
    should be true     $rc4['retcode']==0
    log to console      ${rc4}
    ${rc6}=     listclass  1
    log to console   ${rc6}
    ${fck00}=   evaluate   $rc6['retlist'][0]
    log to console    ${fck00}
    should be true    $fck00['id']==$rk['id']
    should be true    $fck00['invitecode']==$rk['invitecode']
    should be true    $fck00['grade__name']=='七年级'
    should be true    $fck00['studentlimit']==70
    should be true    $fck00['name']=='实验9班'
    [Teardown]   deleterclass   &{rk}[id]

修改班级2_tc000052
    ${rc07}=    addclass    1     实验6班     66
    log to console  ${rc07}
    ${rc08}=    evaluate   $rc07['id']
    ${rc09}=     listclass  1

    ${rc04}=     modifyclass     ${rc08}    实验2班    55
    log to console  ${rc04}
    ${rc06}=     listclass  1
    should be true     $rc04['retcode']==0
#    should be true      $rc04['reason']=='未知错误:Traceback (most recent call last):\n  File "/home/yjyx/yijiao_src/yijiao_main/services/datamodel/schoolclass/models.py", line 612, in modifyClass\n    school_class.save()\n  File "/usr/local/lib/python2.7/site-packages/django/db/models/base.py", line 710, in save\n    force_update=force_update, update_fields=update_fields)\n  File "/usr/local/lib/python2.7/site-packages/django/db/models/base.py", line 738, in save_base\n    updated = self._save_table(raw, cls, force_insert, force_update, using, update_fields)\n  File "/usr/local/lib/python2.7/site-packages/django/db/models/base.py", line 803, in _save_table\n    forced_update)\n  File "/usr/local/lib/python2.7/site-packages/django/db/models/base.py", line 853, in _do_update\n    return filtered._update(values) > 0\n  File "/usr/local/lib/python2.7/site-packages/django/db/models/query.py", line 580, in _update\n    return query.get_compiler(self.db).execute_sql(CURSOR)\n  File "/usr/local/lib/python2.7/site-packages/django/db/models/sql/compiler.py", line 1062, in execute_sql\n    cursor = super(SQLUpdateCompiler, self).execute_sql(result_type)\n  File "/usr/local/lib/python2.7/site-packages/django/db/models/sql/compiler.py", line 840, in execute_sql\n    cursor.execute(sql, params)\n  File "/usr/local/lib/python2.7/site-packages/django/db/backends/utils.py", line 64, in execute\n    return self.cursor.execute(sql, params)\n  File "/usr/local/lib/python2.7/site-packages/django/db/utils.py", line 97, in __exit__\n    six.reraise(dj_exc_type, dj_exc_value, traceback)\n  File "/usr/local/lib/python2.7/site-packages/django/db/backends/utils.py", line 64, in execute\n    return self.cursor.execute(sql, params)\n  File "/usr/local/lib/python2.7/site-packages/django/db/backends/mysql/base.py", line 124, in execute\n    return self.cursor.execute(query, args)\n  File "/usr/local/lib/python2.7/site-packages/MySQLdb/cursors.py", line 205, in execute\n    self.errorhandler(self, exc, value)\n  File "/usr/local/lib/python2.7/site-packages/MySQLdb/connections.py", line 36, in defaulterrorhandler\n    raise errorclass, errorvalue\nIntegrityError: (1062, "Duplicate entry \'\\xe5\\xae\\x9e\\xe9\\xaa\\x8c8\\xe7\\x8f\\xad-548-2\' for key \'name\'")\n'

    [Teardown]   deleterclass    &{rc07}[id]
修改班级3_tc000053
    ${rc000}=    delete_allclass
    ${rc001}=    addclass    2     实验8班     66
    should be true     $rc001['retcode']==0
    log to console   $rc001['id']
    ${rc002}=     listclass  2
    log to console   ${rc002}
    ${rk000}=   evaluate   $rc002['retlist'][0]
    ${rc003}=    evaluate   $rk000['id']
    log to console      ${rc003}
    ${rc004}=     modifyclass     666    实验9班    70
    ${rc006}=     listclass  2
    log to console   ${rc004}
    should be true     $rc004['retcode']==404
    should be true     $rc004['reason']=='id 为`666`的班级不存在'
    [Teardown]   deleterclass    &{rc001}[id]


