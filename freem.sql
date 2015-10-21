set pagesize 400
set linesize 200
col file_name for a50
col name for a20
col ext_avl for a8
select nvl(b.tablespace_name,
nvl(a.tablespace_name,'UNKOWN')) name,
trunc(kbytes_alloc/(1024)) MB_ALLOC,
trunc(kbytes_alloc/1024-nvl(kbytes_free/1024,0)) MB_USED,
trunc(nvl(kbytes_free/(1024),0)) MB_FREE,
trunc(((kbytes_alloc-nvl(kbytes_free,0))/
kbytes_alloc)*100) pct_used,
nvl(largest,0) largest,
decode(alloc,0,'-',trunc(alloc)) EXT_AVL
from 
( select sum(bytes)/1024 Kbytes_free,max(bytes)/1024 largest,tablespace_name
from sys.dba_free_space
group by tablespace_name ) a,
( select sum(bytes)/1024 Kbytes_alloc,tablespace_name
from sys.dba_data_files
group by tablespace_name ) b,
(select distinct tablespace_name, sum(bytes)/(1024*1024) BYTES,sum(decode(maxbytes,0,0,(maxbytes-bytes)/(1024*1024))) ALLOC  from dba_data_files 
group by tablespace_name) c
where a.tablespace_name (+) = b.tablespace_name
and c.tablespace_name  = b.tablespace_name 
--and c.tablespace_name like 'UNDO'
order by 5
/
