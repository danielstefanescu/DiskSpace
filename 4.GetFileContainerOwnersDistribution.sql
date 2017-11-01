SELECT CASE
           WHEN Container = 'vstfs:///Buil'
           THEN 'Build'
           WHEN Container = 'vstfs:///Git/'
           THEN 'Git'
           WHEN Container = 'vstfs:///Dist'
           THEN 'DistributedTask'
           ELSE Container
       END AS FileContainerOwner,
       SUM(fm.CompressedLength) / 1024.0 / 1024.0 / 1024.0 AS TotalSizeInGB
FROM
(
    SELECT DISTINCT
           LEFT(c.ArtifactUri, 13) AS Container,
           fr.ResourceId,
           ci.PartitionId
    FROM tbl_Container c
         INNER JOIN tbl_ContainerItem ci ON c.ContainerId = ci.ContainerId
                                            AND c.PartitionId = ci.PartitionId
         INNER JOIN tbl_FileReference fr ON ci.fileId = fr.fileId
                                            AND ci.DataspaceId = fr.DataspaceId
                                            AND ci.PartitionId = fr.PartitionId
) c
INNER JOIN tbl_FileMetadata fm ON fm.ResourceId = c.ResourceId
                                  AND fm.PartitionId = c.PartitionId
GROUP BY c.Container
ORDER BY TotalSizeInGB DESC;