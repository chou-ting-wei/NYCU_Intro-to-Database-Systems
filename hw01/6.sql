(SELECT "DUO_CARRY" AS position, C.champion_name
FROM champ C, participant P
WHERE P.position = "DUO_CARRY" 
AND P.match_id IN (SELECT match_id FROM match_info WHERE duration BETWEEN 2400 AND 3000)
AND P.champion_id = C.champion_id
GROUP BY C.champion_name
ORDER BY COUNT(P.champion_id) DESC
LIMIT 1)
UNION
(SELECT "DUO_SUPPORT" AS position, C.champion_name
FROM champ C, participant P
WHERE P.position = "DUO_SUPPORT" 
AND P.match_id IN (SELECT match_id FROM match_info WHERE duration BETWEEN 2400 AND 3000)
AND P.champion_id = C.champion_id
GROUP BY C.champion_name
ORDER BY COUNT(P.champion_id) DESC
LIMIT 1)
UNION
(SELECT "JUNGLE" AS position, C.champion_name
FROM champ C, participant P
WHERE P.position = "JUNGLE" 
AND P.match_id IN (SELECT match_id FROM match_info WHERE duration BETWEEN 2400 AND 3000)
AND P.champion_id = C.champion_id
GROUP BY C.champion_name
ORDER BY COUNT(P.champion_id) DESC
LIMIT 1)
UNION
(SELECT "MID" AS position, C.champion_name
FROM champ C, participant P
WHERE P.position = "MID" 
AND P.match_id IN (SELECT match_id FROM match_info WHERE duration BETWEEN 2400 AND 3000)
AND P.champion_id = C.champion_id
GROUP BY C.champion_name
ORDER BY COUNT(P.champion_id) DESC
LIMIT 1)
UNION
(SELECT "TOP" AS position, C.champion_name
FROM champ C, participant P
WHERE P.position = "TOP"
AND P.match_id IN (SELECT match_id FROM match_info WHERE duration BETWEEN 2400 AND 3000)
AND P.champion_id = C.champion_id
GROUP BY C.champion_name
ORDER BY COUNT(P.champion_id) DESC
LIMIT 1);