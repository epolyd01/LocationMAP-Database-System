CREATE PROCEDURE [dbo].Q6

AS
  SELECT F.FingerprintID, F.Floor, F.X,F.Y, Count(O.ObjectID) AS [Total of Objects]
    FROM Fingerprint AS F INNER JOIN [Object] AS O ON F.FingerprintID =  O.FingerprintID
    GROUP BY F.FingerprintID,F.Floor, F.X,F.Y
    ORDER BY Count(*)

GO