select distinct session_id,sql_id, sum(10) ASH from v$active_Session_history
where session_id in ( &sid)
group by session_id,sql_id
order by 3 desc
;

select distinct session_id,event, sum(10) ASH from v$active_Session_history
where session_id in ( &sid)
group by session_id,event
order by 3 desc
;
