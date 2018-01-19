CREATE TABLE `user` (
  `userId` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(255) NOT NULL DEFAULT '' COMMENT '用户名',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像',
  `isOnline` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否在线,0掉线,1在线',
  `lat` varchar(255) NOT NULL DEFAULT '' COMMENT '纬度',
  `lng` varchar(255) NOT NULL DEFAULT '' COMMENT '经度',
  PRIMARY KEY (`userId`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;