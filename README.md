#DataGo博客项目
##前言
本项目完全是自己瞎琢磨

##1、 技术栈
- 前端:
    - bootstrap:前端布局
    - AngularJS:数据交互
- 后端:
    - flask:接口开发
    - MySQL:数据存储

##2、数据库设计
具体的建表语句见./libs/DDL.sql
具体用法:使用root用户登录到mysql
`surce ./libs/DDL.sql`即可
**注意:本项目建的数据库名称叫myblog,并且会创建名为myblog的用户,在创建之前会进行删除操作,请在执行之前务必检查一下自己本地的mysql数据库中是否已经存在名为myblog的database或者用户名,如果已经存在请自行修改DDL**



