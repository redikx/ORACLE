set long 4000
set serveroutput on
set lines 300
declare
res1 varchar2(4000);
            cursor ind_cur is
                        select index_name
                        from dba_indexes
                        where owner='&&SCHEMA' and index_name like '%&name%';
ind_name ind_cur%ROWTYPE;
begin
open ind_cur;
loop
fetch ind_cur into ind_name;
exit when ind_cur%NOTFOUND;
/*dbms_output.put_line(ind_name.index_name);*/
select dbms_metadata.GET_DDL('INDEX',ind_name.index_name,'&&SCHEMA') into res1 from dual;
dbms_output.put_line(res1||';');
end loop;
close ind_cur;
end;
