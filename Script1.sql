
use mysql;

show character set LIKE 'latin%';
show collation LIKE 'latin%';

CREATE DATABASE if not exists forum1_dev_bd CHARACTER SET latin1 COLLATE latin1_swedish_ci;

USE forum1_dev_bd;

CREATE TABLE tab_campo_tipo (
    id int not null auto_increment PRIMARY KEY,
    descricao varchar(255) null
);

CREATE TABLE tab_campo (
    id int not null auto_increment PRIMARY KEY,
    tipo_id int not null,
    descricao varchar(255) null,
    tamanho int null,
    posicao text null,
    CONSTRAINT FOREIGN KEY (tipo_id) REFERENCES tab_campo_tipo(id)
);

INSERT INTO tab_campo_tipo (descricao)
VALUES ('INT'), ('STRING'), ('DECIMAL'), ('DATE'), ('CUSTOM');


INSERT INTO tab_campo (tipo_id, descricao, tamanho, posicao)
VALUES 
(3, 'Soma Total', null, '.js-footer-total-label'), 
(1, 'Total de linhas', null, '.js-footer-total-linhas-label'), 
(2, 'Titulo #1', 255, '.js-header-titulo-1');


SELECT a.descricao as NomeCampo, b.descricao as TipoCampo, a.tamanho
FROM tab_campo a
JOIN tab_campo_tipo b on a.tipo_id = b.id
WHERE a.posicao = '.js-header-titulo-1';




