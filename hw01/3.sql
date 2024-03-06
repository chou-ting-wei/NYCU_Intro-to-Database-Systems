SELECT C.champion_name, COUNT(P.champion_id) AS cnt 
FROM champ C, participant P 
WHERE C.champion_id = P.champion_id AND P.position = "JUNGLE"
GROUP BY C.champion_name
ORDER BY COUNT(P.champion_id) DESC
LIMIT 3;