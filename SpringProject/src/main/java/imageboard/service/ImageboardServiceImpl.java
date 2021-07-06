package imageboard.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import imageboard.bean.ImageboardDTO;
import imageboard.bean.ImageboardPaging;
import imageboard.dao.ImageboardDAO;

@Service
public class ImageboardServiceImpl implements ImageboardService {
	@Autowired
	private ImageboardDAO imageboardDAO;
	@Autowired
	private ImageboardPaging imageboardPaging;

	@Override
	public void imageboardWrite(ImageboardDTO imageboardDTO) {
		imageboardDAO.imageboardWrite(imageboardDTO);
	}

	@Override
	public List<ImageboardDTO> getImageboardList(String pg) {
		//1페이지당 3개씩
		int endNum = Integer.parseInt(pg)*3;
		int startNum = endNum-2;
		
		Map<String , Integer> map = new HashMap<String, Integer>();
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		return imageboardDAO.getImageboardList(map);
	}

	@Override
	public ImageboardPaging imageboardPaging(String pg) {
		int totalA = imageboardDAO.getTotalA(); //검색한 총글수
		
		imageboardPaging.setCurrentPage(Integer.parseInt(pg)); //현재 페이지
		imageboardPaging.setPageBlock(3);
		imageboardPaging.setPageSize(5);
		imageboardPaging.setTotalA(totalA);
		imageboardPaging.makePagingHTML();
		
		return imageboardPaging;
	}

	@Override
	public ImageboardDTO imageboardView(String seq) {
		return imageboardDAO.imageboardView(seq);
	}

	@Override
	public void imageboardDelete(String[] check) {
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("array", check);
		
		imageboardDAO.imageboardDelete(map);
	}
	
	
	
}
