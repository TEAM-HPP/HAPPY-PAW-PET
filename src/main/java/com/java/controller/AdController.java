package com.java.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.analytics.data.v1beta.BetaAnalyticsDataClient;
import com.google.analytics.data.v1beta.BetaAnalyticsDataSettings;
import com.google.analytics.data.v1beta.DateRange;
import com.google.analytics.data.v1beta.Dimension;
import com.google.analytics.data.v1beta.Metric;
import com.google.analytics.data.v1beta.OrderBy;
import com.google.analytics.data.v1beta.Row;
import com.google.analytics.data.v1beta.RunReportRequest;
import com.google.analytics.data.v1beta.RunReportResponse;
import com.google.api.gax.core.FixedCredentialsProvider;
import com.google.auth.oauth2.GoogleCredentials;
import com.java.dto.AdoptDto;
import com.java.dto.ByememDto;
import com.java.dto.MemberDto;
import com.java.dto.PetDto;
import com.java.dto.board.BcmAgeDto;
import com.java.dto.board.BcmDto;
import com.java.dto.board.BoardCommentDto;
import com.java.dto.diagnosis.PetDiagnosisDto;
import com.java.dto.qna.QnaAnswerDto;
import com.java.service.AbandonedService;
import com.java.service.ByememService;
import com.java.service.MemberService;
import com.java.service.PetService;
import com.java.service.adopt.AdoptService;
import com.java.service.board.BcmAgeService;
import com.java.service.board.BcmService;
import com.java.service.board.BoardCommentService;
import com.java.service.board.BoardService;
import com.java.service.dianosis.PetDiagnosisService;
import com.java.service.qna.QnaAnswerService;
import com.java.service.qna.QnaService;


@Controller
public class AdController {

	@Autowired MemberService memberService;
	@Autowired PetService petService;
	@Autowired ByememService byememService;
	@Autowired BoardService boardService;
	@Autowired BoardCommentService bcService;
	@Autowired QnaService qnaService;
	@Autowired QnaAnswerService qaService;
	@Autowired BcmService bcmService;
	@Autowired BcmAgeService bcmAgeService;
	@Autowired AdoptService adoptService;
	@Autowired private AbandonedService abandonedService;
	@Autowired PetDiagnosisService pdService;


	@RequestMapping("/admin/admin")  //관리자페이지 메인
	public String admin() {

		return "admin/admin";
	}

	@GetMapping("/admin/analyticsTest")
	@ResponseBody
	public List<Map<String, String>> getAnalyticsData() throws Exception {

		System.clearProperty("GOOGLE_APPLICATION_CREDENTIALS");
		System.setProperty("GOOGLE_APPLICATION_CREDENTIALS", "C:\\Happypawpet\\Auth\\happypawpetServiceaccount.json");

		// GA4 Property ID 설정
		String propertyId = "453125441";

		List<Map<String, String>> analyticsDataList = new ArrayList<>();

		LocalDate endDate = LocalDate.now();
		LocalDate startDate = endDate.minusDays(7);

        InputStream serviceAccountStream = new FileInputStream("C:\\Happypawpet\\Auth\\happypawpetServiceaccount.json");
//		InputStream serviceAccountStream = new FileInputStream("C:\\Users\\KOREAVC\\Desktop\\2조\\happypawpetServiceaccount.json");

		GoogleCredentials credentials = GoogleCredentials.fromStream(serviceAccountStream);

		BetaAnalyticsDataSettings settings = BetaAnalyticsDataSettings.newBuilder().setCredentialsProvider(FixedCredentialsProvider.create(credentials)).build();
		try (BetaAnalyticsDataClient analyticsData = BetaAnalyticsDataClient.create(settings)) {

			RunReportRequest request = RunReportRequest.newBuilder()
					.setProperty("properties/" + propertyId)
					.addDateRanges(DateRange.newBuilder().setStartDate(startDate.toString()).setEndDate(endDate.toString()))
					.addDimensions(Dimension.newBuilder().setName("date"))
					.addMetrics(Metric.newBuilder().setName("active7DayUsers"))
					.addMetrics(Metric.newBuilder().setName("averageSessionDuration"))
					.addMetrics(Metric.newBuilder().setName("newUsers"))
					.addMetrics(Metric.newBuilder().setName("screenPageViews"))
					.addOrderBys(OrderBy.newBuilder()
							.setDimension(OrderBy.DimensionOrderBy.newBuilder()
									.setDimensionName("date")
									.setOrderType(OrderBy.DimensionOrderBy.OrderType.ALPHANUMERIC)
							)
							.setDesc(false)
					)
					.build();

			RunReportResponse response = analyticsData.runReport(request);

			for (Row row : response.getRowsList()) {
				Map<String, String> data = new HashMap<>();
				data.put("date", row.getDimensionValues(0).getValue());
				data.put("active7DayUsers", row.getMetricValues(0).getValue());
				data.put("averageSessionDuration", row.getMetricValues(1).getValue());
				data.put("newUsers", row.getMetricValues(2).getValue());
				data.put("screenPageViews", row.getMetricValues(3).getValue());
				analyticsDataList.add(data);
			}

		}
		return analyticsDataList;
	}

	//-----------------------------------------------------------------------------------------
	//회원관리
	@GetMapping("/admin/member") //관리자페이지-회원전체보기
	public ModelAndView member() {

		ArrayList<MemberDto> list = memberService.memList();
		ArrayList<ByememDto> blist = byememService.byememList();

		ModelAndView mv = new ModelAndView();
		mv.addObject("list",list);
		mv.addObject("blist",blist);
		mv.setViewName("admin/member");

		return mv;
	}

	@PostMapping("/admin/byememChart1") //ajax chart 데이터 전송
	@ResponseBody
	public ArrayList<ByememDto> chart_data() {

		ArrayList<ByememDto> blist = byememService.chartDraw();

		System.out.println("blist 개수 : "+blist.size());

		for (int i=0;i<blist.size();i++) {
			System.out.println(blist.get(i).getContent()+","+blist.get(i).getCnt());
		}//for

		return blist;

	}

	@PostMapping("/admin/byememChart2") //ajax chart 데이터 전송
	@ResponseBody
	public ArrayList<ByememDto> chart_data2() {

		ArrayList<ByememDto> blist2 = byememService.chartDraw2();

		System.out.println("blist2 개수 : "+blist2.size());

		for (int i=0;i<blist2.size();i++) {
			System.out.println(blist2.get(i).getGender()+","+blist2.get(i).getGcnt());
		}//for

		return blist2;

	}
	//---------------------------------------------------------------------------------------
	//반려동물
	@GetMapping("/admin/pet") //관리자페이지-반려동물전체보기
	public String pet(@RequestParam(required = false) String uprCd,
					  @RequestParam(required = false) String orgCd,
					  Model model) throws Exception {

		int totalCount = abandonedService.getFilteredTotalCount(uprCd, orgCd);

		ArrayList<PetDto> plist = petService.petList();

		model.addAttribute("totalCount", totalCount);
		model.addAttribute("sidoList", abandonedService.getSidoList());
		model.addAttribute("plist",plist);

		return "/admin/pet";
	}

	@GetMapping("/admin/memDetail") //반려동물 id로 보호자 정보 조회
	public ModelAndView memDetail(PetDto petDto) {

		String id = petDto.getId();
		System.out.println("id : "+id);

		MemberDto mDto = memberService.memView(petDto);
		ArrayList<PetDto> plist = petService.petAll(id);


		ModelAndView mv = new ModelAndView();
		mv.addObject("mDto",mDto);
		mv.addObject("plist",plist);
		mv.setViewName("admin/memDetail");

		return mv;
	}

	@PostMapping("/admin/animalChart")
	@ResponseBody
	public Map<String, Object> animalChart(@RequestParam(required = false) String uprCd,
										   @RequestParam(required = false) String orgCd,
										   Model model) throws Exception {

		List<Map<String, String>> regionlist = abandonedService.getSigunguList(uprCd);
		int totalCount = abandonedService.getFilteredTotalCount(uprCd, orgCd);

		Map<String, Integer> countMap = new HashMap<>();

		// regionlist에서 orgCd 추출 및 출력
		for (Map<String, String> region : regionlist) {
			String orgCdValue = region.get("orgCd");
			String orgdownNmValue = region.get("orgdownNm");

			if (orgCdValue != null && orgdownNmValue != null) {
				int regionCount = abandonedService.getFilteredTotalCount(uprCd, orgCdValue);
				countMap.put(orgdownNmValue, regionCount);
			}
		}

		Map<String, Object> response = new HashMap<>();
		response.put("regionlist", regionlist);
		response.put("totalCount", totalCount);
		response.put("countMap", countMap);


		return response;

	}

	//-------------------------------------------------------------------------------------
	//게시판
	@RequestMapping("/admin/board") //관리자페이지 - 게시판 전체(공지사항, QNA, 입양커뮤니티)
	public ModelAndView board() {

		ArrayList<BoardCommentDto> bclist = bcService.boardCommentList();
		ArrayList<QnaAnswerDto> qalist = qaService.qnaAnswerList();
		ArrayList<AdoptDto> adlist = adoptService.adoptCommuList();

		ModelAndView mv = new ModelAndView();
		mv.addObject("bclist",bclist);
		mv.addObject("qalist",qalist);
		mv.addObject("adlist",adlist);
		mv.setViewName("admin/board");

		return mv;
	}
	//-----------------------------------------------------------------------------------------

	@RequestMapping("/admin/boardDetail") //관리자페이지 - 공지사항관리
	public ModelAndView boardDetail() {

		ArrayList<BoardCommentDto> bclist = bcService.boardCommentList();
		ArrayList<BoardCommentDto> rlist = bcService.qhitRank();
		ArrayList<BoardCommentDto> clist = bcService.qcommentRank();

		ModelAndView mv = new ModelAndView();
		mv.addObject("bclist",bclist);
		mv.addObject("rlist",rlist);
		mv.addObject("clist",clist);
		mv.setViewName("admin/boardDetail");

		return mv;
	}

	@GetMapping("/admin/boardComment") //공지사항 댓글 분석
	public ModelAndView boardComment() {

		ArrayList<BoardCommentDto> clist = bcService.qcommentRank();

		ModelAndView mv = new ModelAndView();
		mv.addObject("clist",clist);
		mv.setViewName("admin/boardComment");

		return mv;
	}

	@PostMapping("/admin/commentChart1") //ajax commentchart 데이터 전송
	@ResponseBody
	public ArrayList<BcmDto> comment_data(int bno) {

		ArrayList<BcmDto> cglist = bcmService.chartDraw(bno);

		System.out.println("bno : "+bno);

		for (int i=0;i<cglist.size();i++) {
			System.out.println(cglist.get(i).getBno()+","+cglist.get(i).getGender()+","+cglist.get(i).getCnt());
		}//for

		return cglist;

	}

	@PostMapping("/admin/commentChart2") //ajax commentchart2 데이터 전송
	@ResponseBody
	public ArrayList<BcmAgeDto> comment_data2(int bno) {

		ArrayList<BcmAgeDto> calist = bcmAgeService.chartDraw2(bno);

		System.out.println("bno : "+bno);

		for (int i=0;i<calist.size();i++) {
			System.out.println(calist.get(i).getBno()+","+calist.get(i).getAge_group()+","+calist.get(i).getAcnt());
		}//for

		return calist;

	}

	@PostMapping("/admin/ctChart1") //ajax ctchart 데이터 전송
	@ResponseBody
	public ArrayList<BcmDto> ct_data() {

		ArrayList<BcmDto> tglist = bcmService.cTotalDraw();


		for (int i=0;i<tglist.size();i++) {
			System.out.println(tglist.get(i).getGender()+","+tglist.get(i).getCnt());
		}//for

		return tglist;

	}

	@PostMapping("/admin/ctChart2") //ajax ctchart2 데이터 전송
	@ResponseBody
	public ArrayList<BcmAgeDto> ct_data2() {

		ArrayList<BcmAgeDto> talist = bcmAgeService.cTotalDraw2();


		for (int i=0;i<talist.size();i++) {
			System.out.println(talist.get(i).getAge_group()+","+talist.get(i).getAcnt());
		}//for

		return talist;

	}
	//------------------------------------------------------------------------------------------
	//Qna
	@RequestMapping("/admin/qna") //QnA 게시판 전체보기
	public ModelAndView qna() {

		ArrayList<QnaAnswerDto> qalist = qaService.qnaAnswerList();

		ModelAndView mv = new ModelAndView();
		mv.addObject("qalist",qalist);
		mv.setViewName("admin/qna");


		return mv;
	}
	//------------------------------------------------------------------------------------------
	//adoption
	@RequestMapping("/admin/adoption") //입양후기 게시판
	public ModelAndView adoption() {

		ArrayList<AdoptDto> adlist = adoptService.adoptCommuList();

		ModelAndView mv = new ModelAndView();
		mv.addObject("adlist",adlist);
		mv.setViewName("admin/adoption");


		return mv;
	}
	//------------------------------------------------------------------------------------------
	//diagnosis
	@GetMapping("/admin/eyediagnosis") //진단내역 - 안구
	public ModelAndView eyediagnosis() {

		ArrayList<PetDiagnosisDto> diagnosisHistory = pdService.selectList();

		ModelAndView mv = new ModelAndView();
		mv.addObject("diagnosisHistory",diagnosisHistory);
		mv.setViewName("admin/eyediagnosis");

		return mv;
	}
}

