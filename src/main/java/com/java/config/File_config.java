package com.java.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class File_config implements WebMvcConfigurer {

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		String os = System.getProperty("os.name").toLowerCase();

		if (os.contains("win")) {
			// 윈도우 운영체제일 경우
			registry.addResourceHandler("/upload/**")
					.addResourceLocations("file:///c:/upload/");
		} else if (os.contains("mac")) {
			// MacOS 운영체제일 경우
			registry.addResourceHandler("/upload/**")
					.addResourceLocations("file:/Users/igyuwon/upload/");
		} else {
			// 다른 운영체제 (리눅스 등)
			registry.addResourceHandler("/upload/**")
					.addResourceLocations("file:///c:/upload/");
		}
	}
}

