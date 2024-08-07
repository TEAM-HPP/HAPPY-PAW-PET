package com.java.service;

import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AbandonedServiceImpl implements AbandonedService {

    private static final String SERVICE_KEY = "zCTjzW18rqhX1LpK9QLM07rDQFLFiMXBd9EfNSbXHrHvcwrHSjT6qCb22u6iMlD%2B5W%2Bx%2FUu4Y0BcNSJ%2FrGmDTw%3D%3D";

    // 필터링된 조건에 따라 총 유기동물 수를 반환합니다.
    @Override
    public int getFilteredTotalCount(String uprCd, String orgCd) throws Exception {
        String xmlData = getPublicData(1, 1, uprCd, orgCd);
        Document doc = parseXmlDocument(xmlData);
        NodeList totalCountList = doc.getElementsByTagName("totalCount");
        if (totalCountList.getLength() > 0) {
            return Integer.parseInt(totalCountList.item(0).getTextContent());
        }
        return 0;
    }

    // 페이지별로 유기동물 목록을 반환합니다.
    @Override
    public List<Map<String, String>> getAnimalListByPage(int page, int pageSize, String uprCd, String orgCd) throws Exception {
        String xmlData = getPublicData(page, pageSize, uprCd, orgCd);
        return parseXmlData(xmlData);
    }
    // 대한민국의 시도 목록을 반환합니다.
    @Override
    public List<Map<String, String>> getSidoList() throws Exception {
        String xmlData = getSidoData();
        return parseSidoData(xmlData);
    }
    // 특정 시도의 시군구 목록을 반환합니다.
    @Override
    public List<Map<String, String>> getSigunguList(String uprCd) throws Exception {
        String xmlData = getSigunguData(uprCd);
        return parseSigunguData(xmlData);
    }
    // 특정 유기동물의 정보를 desertionNo를 사용하여 반환합니다.
    @Override
    public Map<String, String> getAnimalById(String desertionNo) throws Exception {
        System.out.println("Fetching data for desertionNo: " + desertionNo);

        int numOfRows = 1000; // 한 번의 호출로 가져올 수 있는 최대 데이터 수
        int totalCount = getFilteredTotalCount("", ""); // 모든 데이터를 가져오기 위해 빈 문자열 사용
        int totalPageCount = (totalCount + numOfRows - 1) / numOfRows; // 총 페이지 수 계산
        List<Map<String, String>> allAnimals = new ArrayList<>();

        // 각 페이지를 순회하며 데이터를 가져옵니다.
        for (int page = 1; page <= totalPageCount; page++) {
            System.out.println("Fetching page: " + page);
            String xmlData = getPublicData(page, numOfRows, "", ""); // 모든 시도, 시군구 데이터를 가져오기 위해 빈 문자열 전달
            allAnimals.addAll(parseXmlData(xmlData)); // 현재 페이지의 데이터를 추가
        }

        // 해당 desertionNo를 가진 데이터를 찾습니다.
        for (Map<String, String> animal : allAnimals) {
            if (desertionNo.equals(animal.get("desertionNo"))) {
                System.out.println("Found matching animal: " + animal); // Debug log for found data
                return animal; // 일치하는 데이터 반환
            }
        }

        System.out.println("No animal data found for desertionNo: " + desertionNo); // Debug log for no data
        return null; // 일치하는 데이터가 없을 경우 null 반환
    }


    // 페이지, 페이지 크기, 상위 코드, 기관 코드를 기준으로 유기동물 데이터를 가져옵니다.
    private String getPublicData(int page, int numOfRows, String uprCd, String orgCd) throws Exception {
        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1543061/abandonmentPublicSrvc/abandonmentPublic");
        urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + SERVICE_KEY);
        urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode(String.valueOf(page), "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode(String.valueOf(numOfRows), "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("upkind", "UTF-8") + "=" + URLEncoder.encode("417000", "UTF-8")); // 417000은 개를 의미합니다

        if (uprCd != null && !uprCd.isEmpty()) {
            urlBuilder.append("&" + URLEncoder.encode("upr_cd", "UTF-8") + "=" + URLEncoder.encode(uprCd, "UTF-8"));
        }
        if (orgCd != null && !orgCd.isEmpty()) {
            urlBuilder.append("&" + URLEncoder.encode("org_cd", "UTF-8") + "=" + URLEncoder.encode(orgCd, "UTF-8"));
        }

        return getResponseFromUrl(urlBuilder.toString());
    }
    // 시도 데이터를 가져옵니다.
    private String getSidoData() throws Exception {
        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1543061/abandonmentPublicSrvc/sido");
        urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + SERVICE_KEY);
        urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=17"); // 대한민국의 17개 시도를 가져옴

        return getResponseFromUrl(urlBuilder.toString());
    }
    // 시군구 데이터를 가져옵니다.
    private String getSigunguData(String uprCd) throws Exception {
        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1543061/abandonmentPublicSrvc/sigungu");
        urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + SERVICE_KEY);
        urlBuilder.append("&" + URLEncoder.encode("upr_cd", "UTF-8") + "=" + URLEncoder.encode(uprCd, "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=100"); // 시군구의 수가 많기 때문에 충분히 큰 수를 지정

        return getResponseFromUrl(urlBuilder.toString());
    }
    // XML 데이터를 파싱하여 유기동물 목록을 반환합니다.
    private List<Map<String, String>> parseXmlData(String xmlData) throws Exception {
        Document doc = parseXmlDocument(xmlData);
        NodeList itemList = doc.getElementsByTagName("item");
        List<Map<String, String>> animalList = new ArrayList<>();

        for (int i = 0; i < itemList.getLength(); i++) {
            Element item = (Element) itemList.item(i);
            Map<String, String> animalMap = new HashMap<>();

            animalMap.put("desertionNo", getElementValue(item, "desertionNo"));
            animalMap.put("kindCd", getElementValue(item, "kindCd"));
            animalMap.put("colorCd", getElementValue(item, "colorCd"));
            animalMap.put("age", getElementValue(item, "age"));
            animalMap.put("weight", getElementValue(item, "weight"));
            animalMap.put("processState", getElementValue(item, "processState"));
            animalMap.put("sexCd", getElementValue(item, "sexCd"));
            animalMap.put("neuterYn", getElementValue(item, "neuterYn"));
            animalMap.put("specialMark", getElementValue(item, "specialMark"));
            animalMap.put("careNm", getElementValue(item, "careNm"));
            animalMap.put("careTel", getElementValue(item, "careTel"));
            animalMap.put("careAddr", getElementValue(item, "careAddr"));
            animalMap.put("popfile", getElementValue(item, "popfile"));

            animalList.add(animalMap);
        }

        return animalList;
    }

    // XML 데이터를 파싱하여 특정 유기동물의 정보를 반환합니다.
    private Map<String, String> parseAnimalData(String xmlData, String targetDesertionNo) throws Exception {
        Document doc = parseXmlDocument(xmlData);
        NodeList itemList = doc.getElementsByTagName("item");

        for (int i = 0; i < itemList.getLength(); i++) {
            Element item = (Element) itemList.item(i);
            String desertionNo = getElementValue(item, "desertionNo");

            if (desertionNo.equals(targetDesertionNo)) {
                Map<String, String> animalMap = new HashMap<>();
                animalMap.put("desertionNo", desertionNo);
                animalMap.put("kindCd", getElementValue(item, "kindCd"));
                animalMap.put("colorCd", getElementValue(item, "colorCd"));
                animalMap.put("age", getElementValue(item, "age"));
                animalMap.put("weight", getElementValue(item, "weight"));
                animalMap.put("processState", getElementValue(item, "processState"));
                animalMap.put("sexCd", getElementValue(item, "sexCd"));
                animalMap.put("neuterYn", getElementValue(item, "neuterYn"));
                animalMap.put("specialMark", getElementValue(item, "specialMark"));
                animalMap.put("careNm", getElementValue(item, "careNm"));
                animalMap.put("careTel", getElementValue(item, "careTel"));
                animalMap.put("careAddr", getElementValue(item, "careAddr"));
                animalMap.put("popfile", getElementValue(item, "popfile"));

                System.out.println("Found animal data: " + animalMap); // Debug log for found animal data
                return animalMap; // 데이터가 일치하면 반환
            }
        }

        System.out.println("No matching data for desertionNo: " + targetDesertionNo); // Debug log for no matching data
        return null;
    }


    // XML 데이터를 파싱하여 시도 목록을 반환합니다.
    private List<Map<String, String>> parseSidoData(String xmlData) throws Exception {
        Document doc = parseXmlDocument(xmlData);
        NodeList itemList = doc.getElementsByTagName("item");
        List<Map<String, String>> sidoList = new ArrayList<>();

        for (int i = 0; i < itemList.getLength(); i++) {
            Element item = (Element) itemList.item(i);
            Map<String, String> sidoMap = new HashMap<>();
            sidoMap.put("orgCd", getElementValue(item, "orgCd"));
            sidoMap.put("orgdownNm", getElementValue(item, "orgdownNm"));
            sidoList.add(sidoMap);
        }

        return sidoList;
    }
    // XML 데이터를 파싱하여 시군구 목록을 반환합니다.
    private List<Map<String, String>> parseSigunguData(String xmlData) throws Exception {
        Document doc = parseXmlDocument(xmlData);
        NodeList itemList = doc.getElementsByTagName("item");
        List<Map<String, String>> sigunguList = new ArrayList<>();

        for (int i = 0; i < itemList.getLength(); i++) {
            Element item = (Element) itemList.item(i);
            Map<String, String> sigunguMap = new HashMap<>();
            sigunguMap.put("orgCd", getElementValue(item, "orgCd"));
            sigunguMap.put("orgdownNm", getElementValue(item, "orgdownNm"));
            sigunguList.add(sigunguMap);
        }

        return sigunguList;
    }
    // XML 문서를 파싱하는 메서드
    private Document parseXmlDocument(String xmlData) throws Exception {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        return builder.parse(new org.xml.sax.InputSource(new StringReader(xmlData)));
    }
    // XML 요소에서 값을 추출하는 메서드
    private String getElementValue(Element parent, String elementName) {
        NodeList nodeList = parent.getElementsByTagName(elementName);
        if (nodeList.getLength() > 0) {
            return nodeList.item(0).getTextContent();
        }
        return "";
    }
    // 주어진 URL로 요청을 보내고 응답을 받습니다.
    private String getResponseFromUrl(String urlString) throws Exception {
        URL url = new URL(urlString);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");

        if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            byte[] bytes = conn.getInputStream().readAllBytes();
            String response = new String(bytes);
            conn.disconnect();
            return response;
        } else {
            conn.disconnect();
            throw new Exception("Error: " + conn.getResponseMessage());
        }
    }
}
