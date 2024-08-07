package com.java.controller;

import java.util.List;
import java.util.Map;

import com.java.utils.PaginationUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.java.service.AbandonedService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class AbandonedController {

    private static final Logger logger = LoggerFactory.getLogger(AbandonedController.class);
    private static final int PAGE_SIZE = 10;

    @Autowired
    private AbandonedService abandonedService;

    @GetMapping("/adoption/animalList")
    public String getAnimalList(@RequestParam(defaultValue = "1") int page,
                                @RequestParam(required = false) String uprCd,
                                @RequestParam(required = false) String orgCd,
                                Model model) throws Exception {
        int totalCount = abandonedService.getFilteredTotalCount(uprCd, orgCd);
        int totalPages = (totalCount + PAGE_SIZE - 1) / PAGE_SIZE;

        List<Map<String, String>> animalList = abandonedService.getAnimalListByPage(page, PAGE_SIZE, uprCd, orgCd);
        List<String> paginationLinks = PaginationUtils.getPaginationLinks(page, totalPages);

        model.addAttribute("animalList", animalList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("uprCd", uprCd);
        model.addAttribute("orgCd", orgCd);
        model.addAttribute("sidoList", abandonedService.getSidoList());
        if (uprCd != null) {
            model.addAttribute("sigunguList", abandonedService.getSigunguList(uprCd));
        }
        model.addAttribute("paginationLinks", paginationLinks);
        return "/adoption/animalList";
    }

    @GetMapping("/adoption/sigungu")
    @ResponseBody
    public List<Map<String, String>> getSigungu(@RequestParam String uprCd) throws Exception {
        return abandonedService.getSigunguList(uprCd);
    }

    @GetMapping("/adoption/Adog_ex")
    public String showAnimalDetails(@RequestParam("animalId") String animalId, Model model) throws Exception {
        System.out.println("Requested animalId: " + animalId); // Debug log for incoming animalId

        Map<String, String> animal = abandonedService.getAnimalById(animalId);
        if (animal != null && !animal.isEmpty()) {
            System.out.println("Retrieved animal data: " + animal); // Debug log for retrieved data
            model.addAttribute("animal", animal);
        } else {
            System.out.println("No animal data found for id: " + animalId); // Debug log for missing data
            model.addAttribute("errorMessage", "해당 동물의 정보를 찾을 수 없습니다. (공고번호: " + animalId + ")");
        }

        return "adoption/Adog_ex";
    }

}