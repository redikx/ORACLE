1. drop staging sqlset:
BEGIN
  DBMS_SQLTUNE.DROP_SQLSET(sqlset_name => 'MySTS01');
END;

2. Create sqlset:
BEGIN
  DBMS_SQLTUNE.CREATE_SQLSET (
    sqlset_name  => 'staging' 
,   description  => 'SQL tuning set to store SQL from the private SQL area' 
);
END;

3. Load plan into sqlset:
DECLARE
  cur sys_refcursor;
BEGIN
  OPEN cur FOR
    SELECT VALUE(P)
    FROM TABLE(
       dbms_sqltune.select_workload_repository(begin_snap=>136397, end_snap=>136398,basic_filter=>'sql_id = ''6fbcczqm8ss0y''',attribute_list=>'ALL')
              ) p;
     DBMS_SQLTUNE.LOAD_SQLSET( sqlset_name=> 'staging', populate_cursor=>cur);
  CLOSE cur;
END;
/


4. Check content of sqlset:
SELECT
  first_load_time          ,
  executions as execs              ,
  parsing_schema_name      ,
  elapsed_time  / 1000000 as elapsed_time_secs  ,
  cpu_time / 1000000 as cpu_time_secs           ,
  buffer_gets              ,
  disk_reads               ,
  direct_writes            ,
  rows_processed           ,
  fetches                  ,
  optimizer_cost           ,
  sql_plan                ,
  plan_hash_value          ,
  sql_id                   ,
  sql_text
   FROM TABLE(DBMS_SQLTUNE.SELECT_SQLSET(sqlset_name => 'test'));

5. Load plan as baseline:
DECLARE
my_plans pls_integer;
BEGIN
  my_plans := DBMS_SPM.LOAD_PLANS_FROM_SQLSET(
    sqlset_name => 'test',
    basic_filter=>'plan_hash_value = ''983276112'''
    );
END;
