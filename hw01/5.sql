(SELECT "lose" AS win_lose, COUNT(AA.match_id) AS cnt
FROM (SELECT AVG(longesttimespentliving) AS avg_time, P.match_id
FROM participant P INNER JOIN stat S ON S.player_id = P.player_id
WHERE S.win = 0
GROUP BY P.match_id) AS AA
WHERE avg_time >= 1200)
UNION
(SELECT "win" AS win_lose, COUNT(AA.match_id) AS cnt
FROM (SELECT AVG(longesttimespentliving) AS avg_time, P.match_id
FROM participant P INNER JOIN stat S ON S.player_id = P.player_id
WHERE S.win = 1
GROUP BY P.match_id) AS AA
WHERE avg_time >= 1200);