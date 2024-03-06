SELECT SUBSTRING_INDEX(A.version, ".", 2) AS version, SUM(A.win = 1) AS win_cnt, 
SUM(A.win = 0) AS lose_cnt, SUM(A.win = 1) / (SUM(A.win = 1) + SUM(A.win = 0)) AS win_ratio
FROM (
(SELECT SUBSTRING_INDEX(M.version, ".", 2) AS version, M.match_id, S.win
FROM match_info M, participant P, champ C, stat S
WHERE P.match_id = M.match_id
AND C.champion_id = P.champion_id
AND C.champion_name = "Lee Sin"
AND S.player_id = P.player_id
) AS A
INNER JOIN(
SELECT SUBSTRING_INDEX(M.version, ".", 2) AS version, M.match_id, S.win
FROM match_info M, participant P, champ C, stat S
WHERE P.match_id = M.match_id
AND C.champion_id = P.champion_id
AND C.champion_name = "Teemo"
AND S.player_id = P.player_id
) AS B
ON A.match_id = B.match_id AND A.win = B.win)
GROUP BY A.version
ORDER BY A.version;