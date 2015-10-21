SELECT * FROM table(dbms_xplan.display_cursor('&sql',nvl('&child',0),'advanced'));

select * from table(DBMS_XPLAN.DISPLAY_AWR('&sql',&hash_value,'','')); 
