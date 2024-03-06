SELECT * FROM(
SELECT A.champion_name AS self_champ_name, SUM(A.win = 1) / (SUM(A.win = 1) + SUM(A.win = 0)) AS win_ratio, 
IFNULL((SUM(A.kills) + SUM(A.assists)) / NULLIF(SUM(A.deaths), 0), 0) AS self_kda, AVG(A.goldearned) AS self_avg_gold, 
"Gragas" AS enemy_champ_name, IFNULL((SUM(B.kills) + SUM(B.assists)) / NULLIF(SUM(B.deaths), 0), 0) AS enemy_kda,
AVG(B.goldearned) AS enemy_avg_gold, COUNT(A.champion_name) AS battle_record
FROM (
(SELECT C.champion_name, P.match_id, S.win, S.kills, S.assists, S.deaths, S.goldearned
FROM participant P, champ C, stat S
WHERE C.champion_id = P.champion_id
AND C.champion_name != "Gragas"
AND P.position = "TOP"
AND S.player_id = P.player_id
) AS A
INNER JOIN
(SELECT C.champion_name, P.match_id, S.win, S.kills, S.assists, S.deaths, S.goldearned
FROM participant P, champ C, stat S
WHERE C.champion_id = P.champion_id
AND C.champion_name = "Gragas"
AND P.position = "TOP"
AND S.player_id = P.player_id
) AS B
ON A.match_id = B.match_id AND A.win != B.win)
GROUP BY A.champion_name
ORDER BY (SUM(A.win = 1) / (SUM(A.win = 1) + SUM(A.win = 0))) DESC) AS AA
WHERE AA.battle_record > 100
LIMIT 5;