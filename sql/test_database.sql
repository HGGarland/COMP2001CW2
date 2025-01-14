-- View all users
SELECT * FROM dbo.Users;

-- Add a new trail
EXEC dbo.AddTrail 
    @TrailName = 'Example Trail',
    @Distance = 4.5,
    @ElevationGain = 200,
    @EstimatedTime = 3,
    @Difficulty = 'Moderate',
    @TrailInfo = 'Example description for a test trail.',
    @UserID = 1,
    @Description = 'Test trail',
    @CreatedBy = 1;

-- View all trails
SELECT * FROM dbo.Trail;

-- Add a trail location
EXEC dbo.AddTrailLocation 
    @TrailID = 1, 
    @LocationLat = 50.386547, 
    @LocationLon = -4.081557, 
    @PointOrder = 1;

-- Test the view
SELECT * FROM dbo.TrailDetails;

-- Check the log
SELECT * FROM dbo.TrailLog;
