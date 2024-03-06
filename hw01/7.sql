(SELECT "DUO_CARRY" AS position, C.champion_name, (IFNULL((SUM(S.kills) + SUM(S.assists)) / NULLIF(SUM(S.deaths), 0), 0)) AS kda
FROM champ C, participant P, stat S
WHERE P.position = "DUO_CARRY"
AND P.champion_id = C.champion_id
AND S.player_id = P.player_id
GROUP BY C.champion_name
ORDER BY (IFNULL((SUM(S.kills) + SUM(S.assists)) / NULLIF(SUM(S.deaths), 0), 0)) DESC
LIMIT 1)
UNION
(SELECT "DUO_SUPPORT" AS position, C.champion_name, (IFNULL((SUM(S.kills) + SUM(S.assists)) / NULLIF(SUM(S.deaths), 0), 0)) AS kda
FROM champ C, participant P, stat S
WHERE P.position = "DUO_SUPPORT"
AND P.champion_id = C.champion_id
AND S.player_id = P.player_id
GROUP BY C.champion_name
ORDER BY (IFNULL((SUM(S.kills) + SUM(S.assists)) / NULLIF(SUM(S.deaths), 0), 0)) DESC
LIMIT 1)
UNION
(SELECT "JUNGLE" AS position, C.champion_name, (IFNULL((SUM(S.kills) + SUM(S.assists)) / NULLIF(SUM(S.deaths), 0), 0)) AS kda
FROM champ C, participant P, stat S
WHERE P.position = "JUNGLE"
AND P.champion_id = C.champion_id
AND S.player_id = P.player_id
GROUP BY C.champion_name
ORDER BY (IFNULL((SUM(S.kills) + SUM(S.assists)) / NULLIF(SUM(S.deaths), 0), 0)) DESC
LIMIT 1)
UNION
(SELECT "MID" AS position, C.champion_name, (IFNULL((SUM(S.kills) + SUM(S.assists)) / NULLIF(SUM(S.deaths), 0), 0)) AS kda
FROM champ C, participant P, stat S
WHERE P.position = "MID"
AND P.champion_id = C.champion_id
AND S.player_id = P.player_id
GROUP BY C.champion_name
ORDER BY (IFNULL((SUM(S.kills) + SUM(S.assists)) / NULLIF(SUM(S.deaths), 0), 0)) DESC
LIMIT 1)
UNION
(SELECT "TOP" AS position, C.champion_name, (IFNULL((SUM(S.kills) + SUM(S.assists)) / NULLIF(SUM(S.deaths), 0), 0)) AS kda
FROM champ C, participant P, stat S
WHERE P.position = "TOP"
AND P.champion_id = C.champion_id
AND S.player_id = P.player_id
GROUP BY C.champion_name
ORDER BY (IFNULL((SUM(S.kills) + SUM(S.assists)) / NULLIF(SUM(S.deaths), 0), 0)) DESC
LIMIT 1);