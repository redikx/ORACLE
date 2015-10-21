select 
tfiles.tablespace_name, sum(su.extents*tbl.next_extent)/(1024*1024) TEMP_USED, tfiles.TOTAL_TEMP
from v$sort_usage su, dba_tablespaces tbl, (select distinct tablespace_name, sum(bytes)/(1024*1024) TOTAL_TEMP from dba_temp_files group by tablespace_name) tfiles
where tablespace='TEMP' and
su.tablespace=tbl.tablespace_name and
tfiles.tablespace_name=tbl.tablespace_name
group by  tfiles.tablespace_name, tfiles.TOTAL_TEMP;
