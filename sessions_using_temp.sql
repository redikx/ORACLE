col event for a40
col machine for a15
select usa.extents*NEXT_EXTENT/(1024*1024) TEMP_SPACE, sess.sid, sess.serial#, sess.osuser,sess.username, sess.status, sess.machine, sess.logon_time, sess.event,sess.seconds_in_wait
 from 
v$sort_usage usa, 
v$session sess,
dba_tablespaces tblsp  
where session_addr=saddr
and usa.tablespace= tblsp.tablespace_name
order by extents desc
