package com.java;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import com.java.service.FlaskClient;

@SpringBootApplication
@MapperScan("com.java.dao")
public class HappyPawPetApplication implements CommandLineRunner {

	@Autowired
	private FlaskClient flaskClient;

	public static void main(String[] args) {
		SpringApplication.run(HappyPawPetApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception { // 가변인수
		flaskClient.callFlaskApi();
	}
}
