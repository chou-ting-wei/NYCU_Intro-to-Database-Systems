SELECT DISTINCT C.champion_name
FROM champ C, match_info M, teamban T
WHERE STRCMP(SUBSTRING_INDEX(M.version, ".", 2), "7.7") = 0
AND T.match_id = M.match_id
AND C.champion_id NOT IN (
SELECT DISTINCT T.champion_id 
FROM teamban T, match_info M
WHERE STRCMP(SUBSTRING_INDEX(M.version, ".", 2), "7.7") = 0
AND T.match_id = M.match_id
)
ORDER BY C.champion_name;