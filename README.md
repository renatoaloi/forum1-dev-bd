# forum1-dev-bd
Anhanguera 2020 - Forum 1 - Desenvolvendo um banco de dados!

## Objetivo

Formatar campos de um relatório, sendo que os campos possam ter tipos pré-determinados e que possam ser definidos os atributos do tipo (em si), do tamanho, uma descrição e também a posição de apresentação no relatório.

## Requisitos

- Campos de relatórios que possuam descrição, tamanho e tipo.
- Os campos devem informar uma posição de apresentação no relatório.
    - A ideia aqui é usar CSS selectors para determinar a exata posição do campo no relatório
- Vários campos de vários relatórios podem ser criados
- Os tipos são imutáveis, estando disponíveis apenas os cadastrados previamente, a não ser que sejam implementados a posteriori.
- A tabela de Relatório é abstrata nesse cenário e não será representada

## Tabelas

### tab_campo

Tabela para armazenar os campos do relatório

|FK|PK|campo|tipo|tam|
|----|----|----|----|----|
||*|id|int|-|
|*||tipo_id|int|-|
|||descricao|varchar|255|
|||tamanho|int|-|
|||posicao|text|-|


### tab_campo_tipo

Tabela para armazenar os tipos dos campos do relatório

|FK|PK|campo|tipo|tam|
|----|----|----|----|----|
||*|id|int|-|
|||descricao|varchar|255|

## Script SQL

### Create database

Criando um banco de dados para esta tarefa do Fórum #1. Eu optei por usar o charset latin1 com o collate padrão dele que é o latin1_swedish_ci por ser o mais preparado para caracteres da língua portuguesa.

```
CREATE DATABASE if not exists forum1_dev_bd CHARACTER SET latin1 COLLATE latin1_swedish_ci;

USE forum1_dev_bd;
```

### Create tables

Tabela de tipos de campo

```
CREATE TABLE tab_campo_tipo (
    id int not null auto_increment PRIMARY KEY,
    descricao varchar(255) null
);
```

Tabela de campos

```
CREATE TABLE tab_campo (
    id int not null auto_increment PRIMARY KEY,
    tipo_id int not null,
    descricao varchar(255) null,
    tamanho int null,
    posicao text null,
    CONSTRAINT FOREIGN KEY (tipo_id) REFERENCES tab_campo_tipo(id)
);
```

### Insert data

```
INSERT INTO tab_campo_tipo (descricao)
VALUES ('INT'), ('STRING'), ('DECIMAL'), ('DATE'), ('CUSTOM');
```

```
INSERT INTO tab_campo (tipo_id, descricao, tamanho, posicao)
VALUES 
(3, 'Soma Total', null, '.js-footer-total-label'), 
(1, 'Total de linhas', null, '.js-footer-total-linhas-label'), 
(2, 'Titulo #1', 255, '.js-header-titulo-1');
```

## Utilização

Quando o desenvolvedor frontend for renderizar o campo do título do relatório, por exemplo, ele precisará dos dados da seguinte forma vindos do backend:

```
SELECT a.descricao as NomeCampo, b.descricao as TipoCampo, a.tamanho
FROM tab_campo a
JOIN tab_campo_tipo b on a.tipo_id = b.id
WHERE a.posicao = '.js-header-titulo-1';
```

## Conclusão

Utilizando essa prática, o frontend pode saber o que renderizar pelo seletor da classe do CSS.

Uma implementação futura seria agregar valores aos campos, os relacionando com relatórios, de forma que cada relatório possa ter o seu próprio campo "Titulo #1" renderizado corretamente.