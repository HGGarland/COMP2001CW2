-- Insert sample users
INSERT INTO dbo.Users (Username, Email, Password, PasswordHash)
VALUES
('Grace Hopper', 'grace@plymouth.ac.uk', 'ISAD123!', HASHBYTES('SHA2_256', 'ISAD123!')),
('Tim Berners-Lee', 'tim@plymouth.ac.uk', 'COMP2001!', HASHBYTES('SHA2_256', 'COMP2001!')),
('Ada Lovelace', 'ada@plymouth.ac.uk', 'insecurePassword', HASHBYTES('SHA2_256', 'insecurePassword'));

-- Insert sample trails
INSERT INTO dbo.Trail (TrailName, Distance, ElevationGain, EstimatedTime, Difficulty, TrailInfo, UserID, Description, CreatedBy, CreatedAt)
VALUES
('Plymbridge Circular', 5.0, 100, 2, 'Moderate', 'A circular trail in Devon', 20, 'A scenic circular trail in Devon.', 20, GETDATE()),
('Waterfront Trail', 3.0, 20, 1, 'Easy', 'A scenic waterfront walk', 21, 'A scenic walk along the waterfront.', 21, GETDATE());

-- Insert sample trail locations
INSERT INTO dbo.TrailLocation (TrailID, LocationLat, LocationLon, PointOrder)
VALUES
(1, 50.386547, -4.081557, 1),
(1, 50.387218, -4.082223, 2),
(2, 50.365409, -4.147869, 1),
(2, 50.365899, -4.148439, 2);
