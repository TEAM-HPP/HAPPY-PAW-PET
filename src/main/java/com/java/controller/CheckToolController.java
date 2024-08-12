package com.java.controller;

import java.io.File;
import java.util.List;

import com.java.dto.ProductDto;
import com.java.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import com.java.dto.PetDto;
import com.java.dto.diagnosis.PetDiagnosisDto;
import com.java.service.PetService;
import com.java.service.dianosis.PetDiagnosisService;

import jakarta.servlet.http.HttpSession;
import org.springframework.web.client.RestTemplate;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;

@Controller
public class CheckToolController {

	@Autowired
	PetDiagnosisService pdService;

	@Autowired
	PetService petService;

	@Autowired
	HttpSession session;

	@Autowired
	RestTemplate restTemplate;

	@Autowired
	ProductService productService;

//	@GetMapping("/diagnosis/CheckTool")
//	public String CheckTool() {
//		return "diagnosis/CheckTool";
//	}

	@GetMapping("/diagnosis/resultEye")
	public String resultEye(@RequestParam("disease") String disease,
							@RequestParam("probability") double probability,
							@RequestParam("userId") String userId,
							@RequestParam("petName") String petName,
							Model model) {

		List<ProductDto> nutritionProducts = productService.getProductsByTypeAndDisease("영양제", disease);
		List<ProductDto> foodProducts = productService.getProductsByTypeAndDisease("사료", disease);
		List<ProductDto> medicineProducts = productService.getProductsByTypeAndDisease("안약", disease);

		model.addAttribute("nutritionProducts", nutritionProducts);
		model.addAttribute("foodProducts", foodProducts);
		model.addAttribute("medicineProducts", medicineProducts);

		model.addAttribute("userId", userId);
		model.addAttribute("petName", petName);
		model.addAttribute("disease", disease);
		model.addAttribute("probability", probability);

		return "diagnosis/resultEye";
	}

	@RequestMapping("/diagnosis/checkForm")
	@ResponseBody
	public String checkForm(PetDiagnosisDto petdiagnosisDto, @RequestPart("file") MultipartFile file) {
		String id = (String) session.getAttribute("sessionId");
		String pname = petdiagnosisDto.getPname();

		String uFile = "";
		String saveUrl = "";

		// 운영체제에 따라 저장 경로를 설정
		String os = System.getProperty("os.name").toLowerCase();
		if (os.contains("win")) {
			saveUrl = "c:/upload/";
		} else if (os.contains("mac")) {
			saveUrl = "/Users/igyuwon/upload/";
		} else {
			// 다른 운영체제의 경우 기본 경로 설정 (예: 리눅스)
			saveUrl = "/path/to/your/upload/";
		}

		if (!file.isEmpty()) {
			long time = System.currentTimeMillis();
			uFile = String.format("%d_%s", time, file.getOriginalFilename());

			File dir = new File(saveUrl);
			if (!dir.exists()) {
				dir.mkdirs();
			}

			File f = new File(saveUrl + uFile);
			try {
				file.transferTo(f);
			} catch (Exception e) {
				return "{\"error\": \"File transfer error\"}";
			}
		}

		petdiagnosisDto.setPfile(uFile);
		petdiagnosisDto.setId(id);
		pdService.insertPetDiagnosisDB(petdiagnosisDto);

		String flaskUrl = "http://localhost:8182/predict";
		try {
			MultipartEntityBuilder builder = MultipartEntityBuilder.create();
			builder.addBinaryBody("file", new File(saveUrl + uFile), ContentType.APPLICATION_OCTET_STREAM, file.getOriginalFilename());

			HttpPost post = new HttpPost(flaskUrl);
			post.setEntity(builder.build());

			try (CloseableHttpClient httpClient = HttpClients.createDefault();
				 CloseableHttpResponse response = httpClient.execute(post)) {

				int statusCode = response.getStatusLine().getStatusCode();

				HttpEntity responseEntity = response.getEntity();
				if (responseEntity != null) {
					String result = EntityUtils.toString(responseEntity);

					if (statusCode == 200) {
						ObjectMapper objectMapper = new ObjectMapper();
						JsonNode rootNode = objectMapper.readTree(result);
						((ObjectNode) rootNode).put("userId", id);
						((ObjectNode) rootNode).put("petName", pname);
						((ObjectNode) rootNode).put("file", uFile);
						return rootNode.toString();
					} else {
						return "{\"error\": \"Flask server error\"}";
					}
				}
			}
		} catch (Exception e) {
			return "{\"error\": \"Communication error with Flask server\"}";
		}

		return "{\"error\": \"Unknown error\"}";
	}


	@RequestMapping("/diagnosis/comparePet") //반려동물 정보 비교
	@ResponseBody
	public String comparePet(PetDiagnosisDto petdiagnosisDto) {
		PetDto petDto = petService.comparePet(petdiagnosisDto);
		int chk = (petDto != null) ? 1 : 0;
		return "" + chk;
	}

	@RequestMapping("/diagnosis/joinPet")
	@ResponseBody
	public String joinPet(PetDiagnosisDto petdiagnosisDto) {
		petService.joinPetFromDiagnosis(petdiagnosisDto);
		return "OK";
	}

	@GetMapping("/diagnosis/CheckTool")
	public String getDiagnosisHistory(HttpSession session, Model model) {
		// 진단 이력 확인 로그
		//System.out.println("진단 이력 페이지 요청됨");

		String userId = (String) session.getAttribute("sessionId");
		//System.out.println("sessionId : "+userId);

		if (userId != null) {
			System.out.println("로그인이 안되어있습니다.");
			List<PetDiagnosisDto> diagnosisHistory = pdService.getDiagnosisHistoryByUserId(userId);
			System.out.println("Number of diagnosis records found: " + diagnosisHistory.size());
			
			model.addAttribute("diagnosisHistory", diagnosisHistory);

			return "redirect:/login/login";
		}

		return "diagnosis/CheckTool";
	}

}
