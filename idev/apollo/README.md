# source
https://www.apolloconfig.com/#/zh/deployment/distributed-deployment-guide
1.创建数据库ApolloConfigDB和ApolloPortalDB，分别导入以下两个sql文件
apolloconfigdb.sql
apolloportaldb.sql
2.注意修改

ApolloConfigDB.ServerConfig 下的eureka.service.url 地址为DEV_META/eureka/