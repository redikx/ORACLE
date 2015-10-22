Used when you hint query and want to load this plan to baseline to be used for unhinted query:

  select  
    sql_id, plan_hash_value, child_number, sql_plan_baseline, sql_text  
from  
    v$sql  
where  
sql_text like ('%query%n1000%');

declare  
    m_clob  clob;
    n number;  
begin  
    select  
        sql_fulltext  
    into  
        m_clob  
    from  
        v$sql  
    where  
        sql_id = '7tn7v9usdx5ns'  
    and child_number = 0;  
    n := dbms_spm.load_plans_from_cursor_cache( sql_id => '7tn7v9usdx5ns',  plan_hash_value=> 	61306953,  sql_text=> m_clob,  fixed=> 'NO', enabled=> 'YES'  );
	DBMS_OUTPUT.put_line('Plans Loaded: ' || n);
end;  
/
