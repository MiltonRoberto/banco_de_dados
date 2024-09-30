CREATE TABLE pessoas (
  nome varchar(20),
  sobrenome varchar(40),
  idade smallint
);

create PROCEDUre addPessoas(
 a_nome varchar[20],
 a_sobrenome varchar[20],
 a_idade smallint
) as $$
begin
insert into pessoas(nome, sobrenome, idade)
    values(a_nome, a_sobrenome, a_idade);
END
$$
LANGUAGE 'plpgsql';

call addpessoas('Milton Roberto', 'Bortolanza', 19);
