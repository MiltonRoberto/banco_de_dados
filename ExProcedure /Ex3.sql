CREATE OR REPLACE PROCEDURE atualizar_produto (
dois_cod_produto INT,
  novo_preco NUMERIC
) as $$
begin
UPDATE produto
    set preco = novo_preco
    where cod_produto = dois_cod_produto;
end;
$$
LANGUAGE plpgsql;

call atualizar_produto(11, 300);
SELECT * from produto;
