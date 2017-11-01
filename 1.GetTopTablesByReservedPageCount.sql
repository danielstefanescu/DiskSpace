SELECT TOP 10 o.name,
              SUM(reserved_page_count) * 8.0 / 1024 / 1024.0 SizeInGB,
              SUM(CASE
                      WHEN p.index_id <= 1
                      THEN p.row_count
                      ELSE 0
                  END) Row_Count
FROM sys.dm_db_partition_stats p
     JOIN sys.objects o ON p.object_id = o.object_id
GROUP BY o.name
ORDER BY SUM(reserved_page_count) DESC;