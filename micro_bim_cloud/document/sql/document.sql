
CREATE TABLE `doc_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) NOT NULL,
  `corp_id` varchar(255) NOT NULL COMMENT '企业ID',
  `user_id` varchar(255) NOT NULL COMMENT '用户人员ID',
  `user_name` varchar(255) NOT NULL COMMENT '用户人员名称',
  `doc_type` int(2) DEFAULT 0 COMMENT '文件类型（0:文件夹，1:文件）',
  `doc_name` varchar(255) DEFAULT NULL COMMENT '文件名称或文件夹名称',
  `space_id` varchar(255) DEFAULT NULL COMMENT '企业isc空间id',
  `file_id` varchar(255) DEFAULT NULL COMMENT '企业isc文件存储id',
  `file_name` varchar(255) DEFAULT NULL COMMENT '企业isc文件存储名称',
  `file_size` bigint(20) DEFAULT NULL COMMENT '企业isc文件大小',
  `file_type` varchar(255) DEFAULT NULL COMMENT '企业isc文件扩展名',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间' ,
  `chunk_numbers` bigint(20) DEFAULT NULL COMMENT '文件总块数' ,
  `is_delete` int(2) DEFAULT 0 COMMENT '是否删除（0:未删除，1:已删除）' ,
  `file_md5` varchar(36) DEFAULT NULL COMMENT '文件md5值' ,
  `uuid` varchar(36) DEFAULT NULL COMMENT 'uuid' ,
  `is_look` int(2) DEFAULT 0 COMMENT '是否全员可查看（0:全员不可查看，1:全员可查看）',
  `is_save_mode` int(2) DEFAULT 0 COMMENT '是否开启安全模式（0:不启动，1:启动）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文件详细信息';


CREATE TABLE `user_doc_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) default 0 COMMENT '用户ID',
  `corp_id` varchar(255) NOT NULL COMMENT '企业ID',
  `doc_id` varchar(255) NOT NULL COMMENT '文件ID',
  `history_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '历史时间' ,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户历史浏览列表';

CREATE TABLE `user_doc_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL COMMENT '用户ID',
  `corp_id` varchar(255) NOT NULL COMMENT '企业ID',
  `doc_id` varchar(255) NOT NULL COMMENT '文件ID',
  `permission` int NOT NULL COMMENT '权限级别（1:可管理，2:可编辑，3:可查看）',
  `is_creator` int NOT NULL COMMENT '是否上传文件者',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户历史浏览列表';



CREATE FUNCTION `getChildList`(rootId INT)
    RETURNS varchar(1000)
BEGIN
    #声明两个局部变量
    DECLARE sTemp VARCHAR(1000);
    DECLARE sTempChd VARCHAR(1000);
    #初始化局部变量
    SET sTemp = '$';
    #调用cast函数将int转换为char
    SET sTempChd =cast(rootId as CHAR);
    #递归拼接
    WHILE sTempChd is not null DO
    #存储每次递归结果
    SET sTemp = concat(sTemp,',',sTempChd);
    #将参数作为pid，然后查询其子id，然后将子id作为pid，
    #查询以子id为pid的子id，依次循环下去，直到所有节点都为叶子节点
    SELECT group_concat(id) INTO sTempChd FROM  doc_info where FIND_IN_SET(parent_id,sTempChd)>0;
    END WHILE;
    RETURN sTemp;
END















