
CREATE PROCEDURE [dbo].[Q13] (@FingerprintID int)
AS

SELECT DISTINCT F.FingerprintID
FROM Fingerprint AS F INNER JOIN Object AS O ON F.FingerprintID = O.FingerprintID
WHERE  F.FingerprintID != @FingerPrintID AND NOT EXISTS(
	( SELECT O.TypeID
	 FROM Fingerprint AS F1 INNER JOIN Object AS O ON F1.FingerprintID = O.FingerprintID
	 WHERE F1.FingerprintID  = @FingerprintID
	 )

	 EXCEPT

	 (SELECT O.TypeID
	 FROM Fingerprint AS F2 INNER JOIN Object AS O ON F2.FingerprintID = O.FingerprintID
	 WHERE F2.FingerprintID = F.FingerprintID AND  F2.FingerprintID != @FingerprintID)
)
ORDER BY F.FingerprintID

GO