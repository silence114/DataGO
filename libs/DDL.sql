drop database if exists myblog;
create database if not exists myblog;

drop user 'myblog'@'%';
flush privileges;
create user 'myblog'@'%' identified by 'myblog';

grant usage on myblog.* to 'myblog'@'%' identified by 'myblog' with
MAX_QUERIES_PER_HOUR 0
MAX_CONNECTIONS_PER_HOUR 0
MAX_UPDATES_PER_HOUR 0
MAX_USER_CONNECTIONS 0;

grant all privileges on myblog.* to 'myblog'@'%';

flush privileges;

CREATE TABLE IF NOT EXISTS `myblog`.`blog_author` (
  `author_id`   INT UNSIGNED    NOT NULL AUTO_INCREMENT COMMENT '主键，作为作者ID',
  `author_name` VARCHAR(45)     NOT NULL                COMMENT '作者名称',
  `author_tags` VARCHAR(128)    NULL DEFAULT '懒，无标签' COMMENT '作者标签，多个标签之间使用中文或者英文逗号隔开',
  `author_resume` VARCHAR(128)  NULL                    COMMENT '作者简历文件地址',
  PRIMARY KEY (`author_id`)
)ENGINE = InnoDB DEFAULT CHARACTER SET = utf8
COMMENT = '文章作者表';

CREATE TABLE IF NOT EXISTS `myblog`.`blog_category` (
  `category_id`     INT UNSIGNED    NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `category_name`   VARCHAR(32)     NOT NULL                COMMENT '分类名称',
  `category_desc`   VARCHAR(128)    NULL                    COMMENT '分类说明',
  PRIMARY KEY (`category_id`)
)ENGINE = InnoDB DEFAULT CHARACTER SET = utf8
COMMENT = '文章类目表';

CREATE TABLE IF NOT EXISTS `myblog`.`tags` (
  `tag_id`      INT UNSIGNED    NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `tag_name`    VARCHAR(16)     NOT NULL                COMMENT '标签文本',
  `tag_desc`    VARCHAR(45)     NULL                    COMMENT '标签描述',
  PRIMARY KEY (`tag_id`)
)ENGINE = InnoDB DEFAULT CHARACTER SET = utf8
COMMENT = '文章标签表';

CREATE TABLE IF NOT EXISTS `myblog`.`blogs` (
  `blog_id`         INT UNSIGNED    NOT NULL AUTO_INCREMENT     COMMENT '文章ID',
  `author_id`       INT UNSIGNED    NOT NULL                    COMMENT '作者ID',
  `author_name`     VARCHAR(45)     NOT NULL DEFAULT '任杰'      COMMENT '作者名称',
  `category_id`     INT UNSIGNED    NOT NULL                    COMMENT '分类ID',
  `category_name`   VARCHAR(32)     NOT NULL                    COMMENT '分类名称',
  `create_time`     TIMESTAMP       NULL                        COMMENT '文章创建时间',
  `updatetime`      TIMESTAMP       NULL                        COMMENT '文章更新时间',
  `title`           VARCHAR(64)     NOT NULL                    COMMENT '文章标题',
  `intro`           VARCHAR(512)    NOT NULL                    COMMENT '文章简介',
  `filepath`        VARCHAR(128)    NOT NULL                    COMMENT '文章文件地址，文章以html格式存储',
  PRIMARY KEY (`blog_id`),
  INDEX `fk_author_idx` (`author_id` ASC),
  INDEX `fk_category_idx` (`category_id` ASC),
  CONSTRAINT `fk_author`   FOREIGN KEY (`author_id`)   REFERENCES `myblog`.`blog_author` (`author_id`)     ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_category` FOREIGN KEY (`category_id`) REFERENCES `myblog`.`blog_category` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = InnoDB DEFAULT CHARACTER SET = utf8
COMMENT = '文章表';

CREATE TABLE IF NOT EXISTS `myblog`.`blog_tag` (
  `id`          INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `blog_id`     INT UNSIGNED NOT NULL COMMENT '文章ID',
  `tab_id`      INT UNSIGNED NOT NULL COMMENT '标签ID',
  PRIMARY KEY (`id`),
  INDEX `fk_blogs_idx` (`blog_id` ASC),
  INDEX `fk_tags_idx` (`tab_id` ASC),
  CONSTRAINT `fk_blogs` FOREIGN KEY (`blog_id`) REFERENCES `myblog`.`blogs` (`blog_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_tags`  FOREIGN KEY (`tab_id`)  REFERENCES `myblog`.`tags` (`tag_id`)   ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = InnoDB DEFAULT CHARACTER SET = utf8
comment '文章标签表';