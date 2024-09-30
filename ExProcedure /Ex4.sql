create or replace PROCEDURE produtosEmEstoque (
p_qtde_estoque INT
) as $$
declare i RECORD;
begin
for i in
    select * from produto where qtde_estoque < p_qtde_estoque
LOOP
raise notice 'Id do produto %, Estoque %', i.cod_produto, i.qtde_estoque;
end loop;
END;
$$
LANGUAGE plpgsql;

DROP PROCEDURE produtosemestoque;



call produtosEmEstoque(30);
