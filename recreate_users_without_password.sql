declare
stmt varchar2(4000);
cursor dba_use is select username from dba_users;
usernam dba_use%rowtype;
begin
open dba_use;
loop
fetch dba_use into usernam;
exit when dba_use%NOTFOUND;
select  dbms_metadata.get_ddl('USER', usernam.username) || '/' usercreate into stmt from dba_users
where username=usernam.username;
dbms_output.put_line(stmt);
end loop;
close dba_use;
end;
/
