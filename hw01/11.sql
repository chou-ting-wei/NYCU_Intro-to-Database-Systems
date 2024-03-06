SELECT * FROM(
SELECT A.summoner_spell, A.win_cnt, A.lose_cnt, A.win_cnt / (A.win_cnt + A.lose_cnt) AS win_ratio FROM(
(SELECT P.ss1 AS summoner_spell, SUM(S.win = 1) AS win_cnt, SUM(S.win = 0) AS lose_cnt
FROM participant P, stat S
WHERE P.player_id = S.player_id
AND P.position = "TOP"
GROUP BY P.ss1) AS A
INNER JOIN
(SELECT P.ss2 AS summoner_spell, SUM(S.win = 1) AS win_cnt, SUM(S.win = 0) AS lose_cnt
FROM participant P, stat S
WHERE P.player_id = S.player_id
AND P.position = "TOP"
GROUP BY P.ss2) AS B
ON STRCMP(A.summoner_spell, B.summoner_spell) = 0)
GROUP BY A.summoner_spell) AS AA
WHERE (AA.win_cnt + AA.lose_cnt) > 100
ORDER BY win_ratio DESC;