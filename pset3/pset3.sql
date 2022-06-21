WITH RECURSIVE classificacao_p
AS (SELECT codigo, CONCAT(nome) AS nome, codigo_pai
FROM classificacao
WHERE codigo_pai is null

UNION ALL

SELECT class.codigo, CONCAT(pf.nome || ' >>> ' || class.nome), class.codigo_pai
FROM classificacao AS class
INNER JOIN classificacao_p AS pf on pf.codigo = class.codigo_pai
SELECT codigo AS "Código", nome AS "Elementos", codigo_pai AS  "Código Pai"
FROM classificacao_p
ORDER BY classificacao_p.nome;