col time for a30
set pages 4000
set lines 300
select time,
       snap_id,
       round(time_delta/1e3/nullif(waits_delta,0), 1) avg_wait_ms,
       waits_delta num_of_waits,
       round(time_delta/1e6) total_seconds
from
(       
  select sn.snap_id,
         sn.begin_interval_time time,
         e.total_waits - lag(e.total_waits) over (partition by e.event_name order by e.snap_id) waits_delta,
         e.time_waited_micro - lag(e.time_waited_micro) OVER (PARTITION BY e.event_name ORDER BY e.snap_id) time_delta
  from dba_hist_system_event e,
       dba_hist_snapshot sn
  where e.snap_id = sn.snap_id
AND e.event_name = '&event_name'
) ev
WHERE ev.time_delta > 0 
and time > to_date('2015/07/09 00:00:00','YYYY/MM/DD HH24:MI:SS')
--and to_date('2015/06/05 05:30:00','YYYY/MM/DD HH24:MI:SS')
order by time desc
/
