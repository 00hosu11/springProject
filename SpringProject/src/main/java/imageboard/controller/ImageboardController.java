package imageboard.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import imageboard.bean.ImageboardDTO;
import imageboard.bean.ImageboardPaging;
import imageboard.service.ImageboardService;

@Controller
@RequestMapping(value="imageboard")
public class ImageboardController {
	@Autowired
	private ImageboardService imageboardService;

	//display 에 넣기 
    @RequestMapping(value="imageboardWriteForm", method=RequestMethod.GET)
    public String imageboardWriteForm(Model model) {
    	model.addAttribute("display", "/imageboard/imageboardWriteForm.jsp");
        return "/index";
    }
	
    //name="img" 1개인 경우
//	@RequestMapping(value="imageboardWrite" , method=RequestMethod.POST)
//	@ResponseBody
//	public void imageboardWrite(@ModelAttribute ImageboardDTO imageboardDTO,
//								@RequestParam MultipartFile img) { //업로드된 이미지는 tmp 임시파일로 img로 올라온다
//		
//		String filePath = "D:\\Spring\\workspace\\SpringProject\\src\\main\\webapp\\storage";
//		String fileName = img.getOriginalFilename(); //파일명 바꾸기
//		File file = new File(filePath, fileName); //파일 생성
//		
//		//파일 복사
//		try {
//			FileCopyUtils.copy(img.getInputStream(), new FileOutputStream(file));
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		
//		imageboardDTO.setImage1(fileName); //DTO에 이름을 저장한다.
//		
//	}
//------------------------------------------------------------------------------------------------------------------	
//    //name="img" 2개 이상인 경우
//  @RequestMapping(value="imageboardWrite" , method=RequestMethod.POST)
//	@ResponseBody
//	public void imageboardWrite(@ModelAttribute ImageboardDTO imageboardDTO,
//								@RequestParam MultipartFile[] img) { //업로드된 이미지는 tmp 임시파일로 img로 올라온다
//		
//		String filePath = "D:\\Spring\\workspace\\SpringProject\\src\\main\\webapp\\storage";
//		String fileName;
//		File file;
//
//		// 파일 복사
//		if (img[0] != null) {
//			fileName = img[0].getOriginalFilename();
//			file = new File(filePath, fileName);
//			
//			try {
//				FileCopyUtils.copy(img[0].getInputStream(), new FileOutputStream(file));
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
//
//			imageboardDTO.setImage1(fileName); // DTO에 이름을 저장한다.
//			
//		} else {
//			
//			imageboardDTO.setImage1(""); //파일이 null일때 DTO에 빈값으로 저장 
//			
//		}
//		//----------------------------
//		if (img[1] != null) {
//			fileName = img[1].getOriginalFilename();
//			file = new File(filePath, fileName);
//			
//			try {
//				FileCopyUtils.copy(img[1].getInputStream(), new FileOutputStream(file));
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
//
//			imageboardDTO.setImage2(fileName); // DTO에 이름을 저장한다.
//			
//		} else {
//			
//			imageboardDTO.setImage2(""); //파일이 null일때 DTO에 빈값으로 저장 
//			
//		}
//	}
//------------------------------------------------------------------------------------------------------------
    
    //한번에 여러개의 파일을 선택했을 때
    @RequestMapping(value="imageboardWrite" , method=RequestMethod.POST)
	@ResponseBody
	public void imageboardWrite(@ModelAttribute ImageboardDTO imageboardDTO,
								@RequestParam("img[]") List<MultipartFile> list) {
    	
    	String filePath = "D:\\Spring\\workspace\\SpringProject\\src\\main\\webapp\\storage";
    	String fileName;
    	File file;
    	
    	for(MultipartFile img : list) {
    		fileName = img.getOriginalFilename();
    		file = new File(filePath, fileName);
    		
    		//파일 복사
    		try {
    			FileCopyUtils.copy(img.getInputStream(), new FileOutputStream(file));
    		} catch (IOException e) {
    			e.printStackTrace();
    		}
    		imageboardDTO.setImage1(fileName);
    		imageboardDTO.setImage2("");
    		
    		//DB
    		imageboardService.imageboardWrite(imageboardDTO);
    	}//for
    	
    
    }
        
  //------------------------------------------------------------------------------------------------------------
    
    
    @RequestMapping(value="imageboardList" , method=RequestMethod.GET)
    public String imageboardList(@RequestParam(required=false, defaultValue = "1") String pg , Model model) {
    	model.addAttribute("pg", pg);
    	model.addAttribute("display", "/imageboard/imageboardList.jsp");
    	return "/index";
    }
    
    @RequestMapping(value="getImageboardList", method=RequestMethod.POST)
    @ResponseBody
    public ModelAndView getImageboardList(@RequestParam(required=false, defaultValue = "1") String pg) {
    	
    	//1페이지당 3개씩
    	List<ImageboardDTO> list = imageboardService.getImageboardList(pg);
    	
    	//페이징 처리
    	ImageboardPaging imageboardPaging= imageboardService.imageboardPaging(pg);
    	
    	ModelAndView mav = new ModelAndView();
    	mav.addObject("pg", pg);
    	mav.addObject("list", list);
    	mav.addObject("imageboardPaging", imageboardPaging);
    	
    	mav.setViewName("jsonView"); //json으로 자동으로 변환
    	return mav;
    }
    
    @RequestMapping(value="imageboardView", method=RequestMethod.GET)
    public String imageboardView(@RequestParam String seq,@RequestParam String pg, Model model) {
    	
    	model.addAttribute("seq" ,seq);
    	model.addAttribute("pg" ,pg);
    	model.addAttribute("display", "/imageboard/imageboardView.jsp");
        return "/index";
    }
    
    
    @RequestMapping(value="imageboardView", method=RequestMethod.POST)
    @ResponseBody
    public ModelAndView imageboardView(@RequestParam String seq) {
    	ImageboardDTO imageboardDTO = imageboardService.imageboardView(seq);
    	
    	ModelAndView mav = new ModelAndView();
    	mav.addObject("imageboardDTO" ,imageboardDTO);
    	mav.setViewName("jsonView"); //json으로 자동으로 변환
    	return mav;
    }
    
    @RequestMapping(value="imageboardDelete", method=RequestMethod.GET)
    public ModelAndView imageboardDelete(String[] check) {
    	
    	imageboardService.imageboardDelete(check);
    	
    	return new ModelAndView("redirect:/imageboard/imageboardList");
    }
    
}
