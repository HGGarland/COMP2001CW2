CREATE VIEW dbo.TrailDetails AS
SELECT 
    T.TrailID,
    T.TrailName,
    T.Distance,
    T.ElevationGain,
    T.EstimatedTime,
    T.Difficulty,
    T.TrailInfo,
    T.Description,
    L.LocationLat,
    L.LocationLon,
    L.PointOrder
FROM 
    dbo.Trail T
JOIN 
    dbo.TrailLocation L ON T.TrailID = L.TrailID;
