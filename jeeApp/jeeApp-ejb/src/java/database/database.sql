/**
 * Author:  adrian
 * Created: Jun 29, 2018
 */
CREATE DATABASE `jeeapp` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;

-- creacion de usuario (dandole todos los privilegios)
/*GRANT USAGE ON *.* TO 'jeeapp'@'localhost';*/
DROP USER 'jeeapp'@'localhost';
CREATE USER 'jeeapp'@'localhost' IDENTIFIED BY 'jeeapppass';
GRANT ALL PRIVILEGES ON `jeeapp`.* TO 'jeeapp'@'localhost' WITH GRANT OPTION;

USE `jeeapp`;

-- creacion de tabla USER
CREATE TABLE IF NOT EXISTS `USER` (
  `login` varchar(40) COLLATE utf8_spanish_ci NOT NULL COMMENT 'Clave primaria que identifica a cada usuario.',
    `password` varchar(255) COLLATE utf8_spanish_ci NOT NULL COMMENT 'Password que el usuario utiliza para iniciar sesión. No puede ser nula',
    `fullname` varchar(60) COLLATE utf8_spanish_ci NOT NULL COMMENT 'Nombre y apellidos del usuario. No puede ser nulo.',
    `email` varchar(40) COLLATE utf8_spanish_ci NOT NULL COMMENT 'login del usuario, no puede ser nulo',
    `phone` int(9) NOT NULL COMMENT 'Numero de telefono del usuario, no puede ser nulo.',
    `country` varchar(60) COLLATE utf8_spanish_ci NOT NULL COMMENT 'Pais del usuario. No puede ser nulo.',
    PRIMARY KEY (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Tabla para almacenamiento de usuarios';

-- creacion de tabla POST
CREATE TABLE IF NOT EXISTS `POST` (
  `idPost` int(9) NOT NULL AUTO_INCREMENT COMMENT 'id del post, unico y auto incremental',
  `datePost` timestamp COLLATE utf8_spanish_ci NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha y hora en la que es creado el post, no puede ser nulo',
`title` varchar(255) COLLATE utf8_spanish_ci NOT NULL COMMENT 'Contenido del post. No puede ser nulo.',
  `content` text COLLATE utf8_spanish_ci NOT NULL COMMENT 'Contenido del post. No puede ser nulo.',
  `numLikes` int(4) DEFAULT NULL COMMENT 'Numero de likes que tiene el post, nulo por defecto',
  `author` varchar(60) COLLATE utf8_spanish_ci NOT NULL COMMENT 'login del autor del post, no puede ser nulo, clave foranea a USER.login',
  PRIMARY KEY (`idPost`),
  FOREIGN KEY (`author`) REFERENCES `USER` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Tabla para almacenamiento de posts' AUTO_INCREMENT=1;

-- creacion de tabla FRIENDS
CREATE TABLE IF NOT EXISTS `FRIENDS` (
	`userlogin` varchar(40) COLLATE utf8_spanish_ci NOT NULL COMMENT 'login del usuario',
	`friendlogin` varchar(40) COLLATE utf8_spanish_ci NOT NULL COMMENT 'login del amigo',
	`isFriend` boolean DEFAULT FALSE COMMENT 'Cuando se realiza una solicitud se pone a false y cuando se acepta se pone a true',	
	PRIMARY KEY (`userlogin`,`friendlogin`),
	FOREIGN KEY (`userlogin`) REFERENCES USER(login),
	FOREIGN KEY (`friendlogin`) REFERENCES USER(login)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Tabla para almacenamiento de amigos';

-- creacion de la tabla LIKES de posts
CREATE TABLE IF NOT EXISTS `LIKES` (
	`authorLike` varchar(40) COLLATE utf8_spanish_ci NOT NULL COMMENT 'login del usuario que hizo like en el post', 
	`likePost` int (9) NOT NULL COMMENT 'id del post en el que se hizo like',
	PRIMARY KEY (`authorLike`,`likePost`),
	FOREIGN KEY (`authorLike`) REFERENCES USER(login),
	FOREIGN KEY (`likePost`) REFERENCES POST(idPost) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Tabla para almacenamiento de likes';	

-- creacion de la tabla COMMENTS
CREATE TABLE IF NOT EXISTS `COMMENTS` (
	`idComment` INT(5) NOT NULL AUTO_INCREMENT COMMENT 'id del comentario, unico y auto incremental',
	`dateComment` timestamp COLLATE utf8_spanish_ci NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'fecha y hora en la que es creado el comentario, no puede ser nulo',
	`content` text COLLATE utf8_spanish_ci NOT NULL COMMENT 'Contenido del post. No puede ser nulo.',	
	`numLikes` int(4) DEFAULT '0' COMMENT 'Numero de likes que tiene el comentario, 0 por defecto',
	`author` varchar(40) COLLATE utf8_spanish_ci NOT NULL COMMENT 'login del usuario que hizo el comentario',
	`idPost` int (9) NOT NULL COMMENT 'id del post en el que se hizo like',
	PRIMARY KEY (`idComment`),
	FOREIGN KEY (`author`) REFERENCES `USER`(`login`),
	FOREIGN KEY (`idPost`) REFERENCES `POST`(`idPost`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Tabla para almacenamiento de comentarios' AUTO_INCREMENT=1;

-- creacion de la tabla LIKES de comentarios
CREATE TABLE IF NOT EXISTS `LIKESCOMMENTS` (
	`authorLike` varchar(40) COLLATE utf8_spanish_ci NOT NULL COMMENT 'login del usuario que hizo like en el post', 
	`likeComment` int (9) NOT NULL COMMENT 'id del comentario en el que se hizo like',
	PRIMARY KEY (`authorLike`,`likeComment`),
	FOREIGN KEY (`authorLike`) REFERENCES USER(login),
	FOREIGN KEY (`likeComment`) REFERENCES COMMENTS(idComment) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Tabla para almacenamiento de likes';	


INSERT INTO `USER` (`login`,`password`,`fullname`,`email`,`phone`, `country`) VALUES
('adri229','$2y$10$RmU5MwjgiI48vkHzRS3BiOtQY5LSQTa.Oe7/JmNDDCAizardsdp/C','adrian gonzalez','adri229@gmailcom','988102030','Spain'),
('adri339','$2y$10$aameo0kWBO09kpvpl6B0yumLiayGWgQhWc.KpkafoFOLVm4gqTAmK','adrian dominguez','adri339@gmailcom','988102030','Spain'),
('adri449','$2y$10$orRCQxumVq3DOTPV0ZcLLuSzZEP84JKA1eMx87xFPnHunRMoPCd92','adrian perez','adri449@gmailcom','988102030','Spain'),
('adri559','$2y$10$yhhaK08iySsp1BnNwdH2ae/c2cdxYmY8Wo9JJoTotsAIigdlfoSsm','adrian martinez','adri559@gmailcom','988102030','Spain'),
('adri669','$2y$10$BoMnGs22bMQ3cV7ynRvi1ObRN2gn2XCaZh7xwy8es5cnOTt.BVOqS','adrian vazquez','adri669@gmailcom','988102030','Spain');    
