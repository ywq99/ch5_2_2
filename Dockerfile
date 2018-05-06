#基于哪个镜像
FROM java:8
#将本地文件夹挂载到当前容器
VOLUME /tmp
#复制文件到容器，也可以直接写成
ADD ch5_2_2-0.0.1-SNAPSHOT.jar app.jar
RUN bash -c 'touch /app.jar'

#声明需要暴露的端口
EXPOSE 9090

#配置容器启动后执行的命令
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/.urondom","-jar","/app.jar"]