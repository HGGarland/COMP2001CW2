-- Create the TrailLog table
CREATE TABLE dbo.TrailLog (
    LogID INT PRIMARY KEY IDENTITY,
    UserID INT NOT NULL,
    TrailID INT NOT NULL,
    Action NVARCHAR(50),
    ActionTimestamp DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_UserID FOREIGN KEY (UserID) REFERENCES dbo.Users(UserID),
    CONSTRAINT FK_TrailID FOREIGN KEY (TrailID) REFERENCES dbo.Trail(TrailID)
);
GO

-- Create a trigger to log trail additions
CREATE TRIGGER dbo.TrailAddTrigger
ON dbo.Trail
AFTER INSERT
AS
BEGIN
    INSERT INTO dbo.TrailLog (UserID, TrailID, Action, ActionTimestamp)
    SELECT CreatedBy, TrailID, 'Trail Added', GETDATE()
    FROM Inserted;
END;
GO
