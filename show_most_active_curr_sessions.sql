select ts.sql_id, ts.CPUpct PCT, ts.wt wait_time, sa.executions, trunc(sa.disk_reads/decode(sa.executions,0,1,sa.executions)) disk_reads_per_exec, sa.disk_reads,
trunc(sa.buffer_gets/decode(sa.executions,0,1,sa.executions)) buff_get_per_exec, sa.buffer_gets, 
trunc(sa.elapsed_time/1000/decode(sa.executions,0,1,sa.executions)) ms_per_exec,
round(sa.user_io_wait_time/decode(sa.disk_reads,0,1,sa.disk_reads)/1000,2) Single_IO_time_ms,
--sa.outline_category, 
sa.sql_plan_baseline, 
sa.sql_text 
from (
select sql_id,  round(count(*)/sum(count(*)) over (), 2) * 100 CPUpct, sum(wait_time) wt   
from v$active_session_history
where --session_state = 'ON CPU'
sample_time > sysdate - &minutesback/24/60
and sql_id is not null
group by sql_id
order by 2 desc) ts, v$sqlarea sa
where ts.sql_id = sa.sql_id 
and rownum < &howmanyshow
order by 6 desc;
