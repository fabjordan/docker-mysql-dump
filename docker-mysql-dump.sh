#!/bin/sh

data=$(date '+%d-%m-%Y_%H-%M-%S');
nome='backup_'$data.sql;

# Caso não tenha o Figlet instalado basta rodar: sudo apt install figlet
figlet -c EXECUTANDO BACKUP

echo "----------------------------------------------------";
echo "| ACESSANDO SERVIDOR REMOTO E REALIZANDO DUMP MYSQL |";
echo "----------------------------------------------------";

ssh user@ipServidor "docker exec nome-container mysqldump -u usuario-do-banco --password='senha-do-banco' nome-do-banco | gzip -v > /local-onde-ficara-o-dump-mysql/$nome.gz";

echo "\n------------------------------------"
echo "| MYSQL DUMP REALIZADO COM SUCESSO! |";
echo "------------------------------------"

echo "\nFAZENDO DOWNLOAD...";

rsync -avz -e ssh user@ipServidor:/local-onde-esta-o-dump-mysql/$nome.gz --progress ~/minha-pasta-local

echo "\n-------------------------------------------------------------------";
echo "| DOWNLOAD $nome FINALIZADO COM SUCESSO! |";
echo "-------------------------------------------------------------------";

figlet -c CONCLUIDO COM SUCESSO!
