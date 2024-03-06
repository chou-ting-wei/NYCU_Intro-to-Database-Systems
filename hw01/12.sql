(SELECT * FROM(
SELECT "DUO_CARRY" AS position, C.champion_name, SUM(S.win = 1) AS win_cnt, SUM(S.win = 0) AS lose_cnt, 
SUM(S.firstblood = 1) / (SUM(S.firstblood = 0) + SUM(S.firstblood = 1)) AS first_blood_ratio
FROM champ C, participant P, stat S
WHERE P.position = "DUO_CARRY"
AND C.champion_id = P.champion_id
AND P.player_id = S.player_id
GROUP BY C.champion_name) AS AA
WHERE (win_cnt + lose_cnt) > 100
ORDER BY first_blood_ratio DESC
LIMIT 3)
UNION
(SELECT * FROM(
SELECT "DUO_SUPPORT" AS position, C.champion_name, SUM(S.win = 1) AS win_cnt, SUM(S.win = 0) AS lose_cnt, 
SUM(S.firstblood = 1) / (SUM(S.firstblood = 0) + SUM(S.firstblood = 1)) AS first_blood_ratio
FROM champ C, participant P, stat S
WHERE P.position = "DUO_SUPPORT"
AND C.champion_id = P.champion_id
AND P.player_id = S.player_id
GROUP BY C.champion_name) AS AA
WHERE (win_cnt + lose_cnt) > 100
ORDER BY first_blood_ratio DESC
LIMIT 3)
UNION
(SELECT * FROM(
SELECT "JUNGLE" AS position, C.champion_name, SUM(S.win = 1) AS win_cnt, SUM(S.win = 0) AS lose_cnt, 
SUM(S.firstblood = 1) / (SUM(S.firstblood = 0) + SUM(S.firstblood = 1)) AS first_blood_ratio
FROM champ C, participant P, stat S
WHERE P.position = "JUNGLE"
AND C.champion_id = P.champion_id
AND P.player_id = S.player_id
GROUP BY C.champion_name) AS AA
WHERE (win_cnt + lose_cnt) > 100
ORDER BY first_blood_ratio DESC
LIMIT 3)
UNION
(SELECT * FROM(
SELECT "MID" AS position, C.champion_name, SUM(S.win = 1) AS win_cnt, SUM(S.win = 0) AS lose_cnt, 
SUM(S.firstblood = 1) / (SUM(S.firstblood = 0) + SUM(S.firstblood = 1)) AS first_blood_ratio
FROM champ C, participant P, stat S
WHERE P.position = "MID"
AND C.champion_id = P.champion_id
AND P.player_id = S.player_id
GROUP BY C.champion_name) AS AA
WHERE (win_cnt + lose_cnt) > 100
ORDER BY first_blood_ratio DESC
LIMIT 3)
UNION
(SELECT * FROM(
SELECT "TOP" AS position, C.champion_name, SUM(S.win = 1) AS win_cnt, SUM(S.win = 0) AS lose_cnt, 
SUM(S.firstblood = 1) / (SUM(S.firstblood = 0) + SUM(S.firstblood = 1)) AS first_blood_ratio
FROM champ C, participant P, stat S
WHERE P.position = "TOP"
AND C.champion_id = P.champion_id
AND P.player_id = S.player_id
GROUP BY C.champion_name) AS AA
WHERE (win_cnt + lose_cnt) > 100
ORDER BY first_blood_ratio DESC
LIMIT 3);
SELECT firstblood, SUM(win = 1) / (SUM(win = 0) + SUM(win = 1)) AS win_ratio, 
(IFNULL((SUM(kills) + SUM(assists)) / NULLIF(SUM(deaths), 0), 0)) AS avg_kda,
AVG(goldearned) AS avg_gold, AVG(longesttimespentliving) AS avg_longest_alive,
AVG(doublekills) AS avg_double_kills, AVG(triplekills) AS avg_triple_kills, AVG(quadrakills) AS avg_quadra_kills,
AVG(pentakills) AS avg_penta_kills, AVG(legendarykills) AS avg_legendary_kills
FROM stat
GROUP BY firstblood;