select distinct sql_id, trunc(count(*)/6) MINS  from DBA_HIST_ACTIVE_SESS_HISTORY
where session_id=&sid
and sample_time between to_date(sysdate-&earlier_dayback,'YYYY-MM-DD HH24:MI:SS')
and to_date(sysdate-&later_dayback,'YYYY-MM-DD HH24:MI:SS')
group by sql_id order by 2
;
