DROP DATABASE IF EXISTS modalidades;
CREATE DATABASE modalidades;
USE modalidades;

-- Criação da tabela `empresas`
DROP TABLE IF EXISTS `empresas`;
CREATE TABLE `empresas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `avatar` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `empresas` WRITE;

INSERT INTO `empresas` (`id`, `nome`, `avatar`) VALUES
(1, 'Allp Fit Academia', 'allpfit.png'),
(2, 'Ativa Fitness', 'ativa.jpg'),
(3, 'Selfit Academias', 'selfit.png');

UNLOCK TABLES;

-- Criação da tabela `produtos`
DROP TABLE IF EXISTS `produtos`;
CREATE TABLE `produtos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descricao` varchar(510) NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  `url` varchar(1020) NOT NULL,
  `imagem1` varchar(255) NOT NULL,
  `imagem2` varchar(255) DEFAULT NULL,
  `imagem3` varchar(255) DEFAULT NULL,
  `empresa` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_produtos_empesas_idx` (`empresa`),
  CONSTRAINT `fk_produtos_empesas` FOREIGN KEY (`empresa`) REFERENCES `empresas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `produtos` WRITE;

INSERT INTO `produtos` (`id`, `nome`, `descricao`, `preco`, `url`, `imagem1`, `imagem2`, `imagem3`, `empresa`) VALUES
(1, 'Aula de Ginástica', 'Aula de 1 hora com professor capacitado.', 100.00, 'https://www.selfitacademias.com.br/', 'ginastica1.jpg', 'ginastica2.jpg', 'ginastica3.jpg', 3),
(2, 'Musculação', 'Acesso a academia para treinos de musculação qualquer dia da semana.', 120.00, 'https://www.selfitacademias.com.br/', 'musculacao1.jpg', 'musculacao2.jpg', NULL, 3),
(3, 'Musculação', 'Acesso a academia para treinos de musculação qualquer dia da semana.', 800.00, 'https://allpfit.com.br/', 'musculacao3.jpg', 'musculacao4.jpg', NULL, 1),
(4, 'Aula de Funcional', 'Aula de 1 hora com professor capacitado.', 50.00, 'https://allpfit.com.br/', 'funcional1.jpg', NULL, NULL, 1),
(5, 'Spinning', 'Aula de 1 hora com professor capacitado.', 50.00, 'https://www.selfitacademias.com.br/', 'spinning1.jpg', 'spinning2.jpg', 'spinning3.jpg', 3),
(6, 'Fit Dance', 'Aula às quintas e sábados com professor Eduardo às 10h da manhã.', 100.00, 'https://www.selfitacademias.com.br/', 'fitdance1.jpg', 'fitdance2.jpg', NULL, 3),
(7, 'Aula de Natação', 'Aulas de terça a sábado, das 10h às 16h.', 320.00, 'https://academiaativafitness.com.br/web/', 'natacao1.jpg', 'natacao2.jpg', 'natacao3.jpg', 2),
(8, 'Musculação', 'Acesso a academia para treinos de musculação qualquer dia da semana.', 160.00, 'https://academiaativafitness.com.br/web/', 'musculacao2.jpg', 'musculacao1.jpg', 'musculacao4.jpg', 2),
(9, 'Judô', 'Turmas abertas para crianças e adultos. Horário matutino e noturno.', 150.00, 'https://academiaativafitness.com.br/web/', 'judo1.jpg', 'judo2.jpeg', NULL, 2),
(10, 'Crossfit', 'Turmas matutinas. Aulas de 1 hora com professor.', 200.00, 'https://www.selfitacademias.com.br/', 'crossfit1.jpeg', 'crossfit2.jpg', NULL, 3);

UNLOCK TABLES;

-- Criação da tabela `feeds`
DROP TABLE IF EXISTS `feeds`;
CREATE TABLE `feeds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data` datetime NOT NULL,
  `produto` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_feeds_produtos_idx` (`produto`),
  CONSTRAINT `fk_feeds_produtos` FOREIGN KEY (`produto`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `feeds` WRITE;

INSERT INTO feeds (id, data, produto) VALUES
(1, '2024-07-30 17:00:00', 1),
(2, '2024-07-30 17:00:00', 2),
(3, '2024-07-30 17:00:00', 3),
(4, '2024-07-30 17:00:00', 4),
(5, '2024-07-30 17:00:00', 5),
(6, '2024-07-30 17:00:00', 6),
(7, '2024-07-30 17:00:00', 7),
(8, '2024-07-30 17:00:00', 8),
(9, '2024-07-30 17:00:00', 9),
(10, '2024-07-30 17:00:00', 10);

UNLOCK TABLES;

-- Criação da tabela `comentarios`
DROP TABLE IF EXISTS `comentarios`;
CREATE TABLE `comentarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comentario` varchar(510) NOT NULL,
  `feed` int NOT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `conta` varchar(255) NOT NULL,
  `data` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_feed_idx` (`feed`),
  CONSTRAINT `fk_comentarios_feeds` FOREIGN KEY (`feed`) REFERENCES `feeds` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `comentarios` WRITE;

INSERT INTO `comentarios` (`id`, `comentario`, `feed`, `nome`, `conta`, `data`) VALUES
(1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', 1, 'academia - modalidades', 'exemplo@email.com', '2024-08-12 20:13:00'),
(2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', 2, 'academia - modalidades', 'exemplo@email.com', '2024-08-12 20:13:00'),
(3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', 3, 'academia - modalidades', 'exemplo@email.com', '2024-08-12 20:13:00'),
(4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', 4, 'academia - modalidades', 'exemplo@email.com', '2024-08-12 20:13:00'),
(5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', 5, 'academia - modalidades', 'exemplo@email.com', '2024-08-12 20:13:00'),
(6, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', 6, 'academia - modalidades', 'exemplo@email.com', '2024-08-12 20:13:00'),
(7, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', 7, 'academia - modalidades', 'exemplo@email.com', '2024-08-12 20:13:00'),
(8, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', 8, 'academia - modalidades', 'exemplo@email.com', '2024-08-12 20:13:00'),
(9, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', 9, 'academia - modalidades', 'exemplo@email.com', '2024-08-12 20:13:00'),
(10, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', 10, 'academia - modalidades', 'exemplo@email.com', '2024-08-12 20:13:00');

UNLOCK TABLES;

-- Criação da tabela `likes`
DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `feed` int NOT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `conta` varchar(255) NOT NULL,
  `data` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_likes_feed_idx` (`feed`),
  CONSTRAINT `fk_likes_feeds` FOREIGN KEY (`feed`) REFERENCES `feeds` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `likes` WRITE;

INSERT INTO `likes` (id, feed, email) VALUES
(1,1,'exemplo@email.com'),
(2,1,'exemplo@email.com'),
(3,2,'exemplo@email.com'),
(4,2,'exemplo@email.com'),
(5,3,'exemplo@email.com'),
(6,3,'exemplo@email.com'),
(7,4,'exemplo@email.com');

UNLOCK TABLES;