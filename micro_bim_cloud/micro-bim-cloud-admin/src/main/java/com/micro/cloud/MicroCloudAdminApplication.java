package com.micro.cloud;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * 应用启动入口
 * Created by macro on 2018/4/26.
 */
@SpringBootApplication
@EnableScheduling
public class MicroCloudAdminApplication extends SpringBootServletInitializer {
    public static void main(String[] args) {
        SpringApplication.run(MicroCloudAdminApplication.class, args);
    }

    /**
     * 调用外部Tomcat，重写configure方法
     */
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder){
        return builder.sources(MicroCloudAdminApplication.class);
    }
}
