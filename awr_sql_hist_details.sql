set lines 300
set pages 4000
select to_char(hp.begin_interval_time,'YYYY-MM-DD HH24') TIME_HH,sum(elapsed_time_delta) elapse_time,
sum(disk_reads_delta) Disk_Reads, sum(buffer_gets_delta) bufgets,
round(sum(buffer_gets_delta)/decode(sum(executions_delta),0,1,sum(executions_delta))) bg_p_exec,
round(sum(disk_reads_delta)/decode(sum(executions_delta),0,1,sum(executions_delta))) dr_p_exec,
sum(executions_delta) execs,
round(sum(rows_processed_delta)/decode(sum(executions_delta),0,1,sum(executions_delta))) rowsproc,
min(plan_hash_value) plan_hash_value, count(distinct(plan_hash_value)) nr_of_plans from 
dba_hist_sqlstat sqlstat,dba_hist_snapshot hp
where 
sqlstat.snap_id=hp.snap_id and
hp.begin_interval_time > to_date(sysdate-&daysback,'YYYY-MM-DD HH24:MI:SS')  
and sql_id='&sql_id'
group by to_char(hp.begin_interval_time,'YYYY-MM-DD HH24')
--group by distinct(to_char(hp.begin_interval_time,'YYYY-MM-DD HH24'))
order by 1 desc
/
