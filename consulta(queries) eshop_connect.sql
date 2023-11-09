-- 1. Selecionar todos os produtos
-- 2. Selecionar o nome de todos os usuários
-- 3. Retornar todos os conteúdos dos comentários dos produtos
-- 4. Qual o endereço do usuário cujo ID é igual a 21
-- 5. Qual endereço da loja com id 39
-- 6. Os pedidos com ID 74892932 e 84821231 foram pagos?

USE eshop_connect;

-- 1:
SELECT name from product;

-- 2:
SELECT name from users;

-- 3:
SELECT content from comments;

-- 4:
SELECT streetAddr from address where fk_userId = 21;

-- 5:
SELECT name, province,city from address where fk_sid;