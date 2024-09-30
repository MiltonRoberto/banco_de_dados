CREATE OR REPLACE PROCEDURE insere_atualiza (cod int, prod varchar(30), descr text, valor numeric, qtde smallint, desc_perc numeric)
LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO produtos(cod_produto, nome_produto, descricao, preco, qtde_estoque)
  VALUES (cod, prod, descr, valor, qtde);
  UPDATE produtos SET preco = preco * (100 - desc_perc) / 100;
END;
$$;

CALL insere_atualiza(6,'Tênis'::varchar(30),'Vans'::text, 12.30, 12::smallint, 10);
