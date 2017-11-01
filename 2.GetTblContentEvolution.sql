
SELECT DATEPART(yyyy, CreationDate) AS [year],
       DATEPART(mm, CreationDate) AS [month],
       COUNT(*) AS [count],
       SUM(DATALENGTH(Content)) / 1048576.0 / 1024.0 AS [SizeInGB],
       (SUM(DATALENGTH(Content)) / 1048576.0 / 1024.0) / COUNT(*) AS [AverageSize]
FROM tbl_Content
GROUP BY DATEPART(yyyy, CreationDate),
         DATEPART(mm, CreationDate)
ORDER BY DATEPART(yyyy, CreationDate),
         DATEPART(mm, CreationDate);