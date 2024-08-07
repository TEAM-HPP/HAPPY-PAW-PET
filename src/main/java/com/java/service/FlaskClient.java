package com.java.service;

import org.springframework.web.client.RestTemplate;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Component
public class FlaskClient {
    public String callFlaskApi(String filePathStr) {
        RestTemplate restTemplate = new RestTemplate();
        String flaskUrl = "http://localhost:8182/predict";

        // 예시: 파일 경로 설정
        Path filePath = Paths.get(filePathStr);

        try {
            // 파일을 읽어와서 바이트 배열로 변환
            byte[] fileContent = Files.readAllBytes(filePath);
            Resource fileResource = new ByteArrayResource(fileContent) {
                @Override
                public String getFilename() {
                    return filePath.getFileName().toString();
                }
            };

            // 헤더 설정
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.MULTIPART_FORM_DATA);

            // 요청 본문 설정
            HttpEntity<Resource> requestEntity = new HttpEntity<>(fileResource, headers);

            // POST 요청 보내기
            ResponseEntity<String> response = restTemplate.postForEntity(flaskUrl, requestEntity, String.class);
            return response.getBody();
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}
