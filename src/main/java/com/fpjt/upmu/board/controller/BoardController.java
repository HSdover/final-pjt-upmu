package com.fpjt.upmu.board.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fpjt.upmu.board.model.service.BoardService;
import com.fpjt.upmu.board.model.vo.Attachment;
import com.fpjt.upmu.common.util.UpmuUtils;
import com.fpjt.upmu.board.controller.BoardController;
import com.fpjt.upmu.board.model.vo.BoardExt;
import com.fpjt.upmu.board.model.vo.Board;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@Slf4j
public class BoardController {
	@Autowired
	private ServletContext application;

	@Autowired
	private ResourceLoader resourceLoader;

	@Autowired
	private BoardService boardService;

	@GetMapping("/boardList.do")
	public ModelAndView boardList(ModelAndView mav,  @RequestParam(required = true, defaultValue = "1") int cpage, HttpServletRequest request,
			Model model) {
		try {
			log.debug("cpage = {}", cpage);
			final int limit = 10;
			final int offset = (cpage - 1) * limit;
			Map<String, Object> param = new HashMap<>();
			param.put("limit", limit);
			param.put("offset", offset);
			// 1.???????????? : content?????? - Rowbounds
			List<BoardExt> list = boardService.selectBoardList(param);
			int totalContents = boardService.selectBoardTotalContents();
			String url = request.getRequestURI();
			//log.debug("totalContents = {}, url = {}", totalContents, url);
			String pageBar = UpmuUtils.getPageBar(totalContents, cpage, limit, url);
			
			// 2. jsp??? ??????
			model.addAttribute("list", list);
			model.addAttribute("pageBar", pageBar);
			mav.setViewName("board/boardList");
		} catch (Exception e) {
			log.error("????????? ?????? ??????!", e);
			throw e;
		}
		return mav;
	}

	@GetMapping("/boardForm.do")
	public void boardForm() {
	}

	@PostMapping("/boardEnroll.do")
	public String boardEnroll(@ModelAttribute BoardExt board, @RequestParam(name = "upFile") MultipartFile[] upFiles,
			RedirectAttributes redirectAttr) throws Exception {

		try {
			log.debug("board = {}", board);
			// 1. ?????? ?????? : ???????????? /resources/upload/board
			// pageContext:PageContext - request:HttpServletRequest - session:HttpSession -
			// application:ServletContext
			String saveDirectory = application.getRealPath("/resources/upload/board");
			log.debug("saveDirectory = {}", saveDirectory);

			// ???????????? ??????
			File dir = new File(saveDirectory);
			if (!dir.exists())
				dir.mkdirs(); // ???????????? ??????????????? ??????

			List<Attachment> attachList = new ArrayList<>();

			for (MultipartFile upFile : upFiles) {
				// input[name=upFile]????????? ???????????? upFile??? ????????????.
				if (upFile.isEmpty())
					continue;

				String renamedFilename = UpmuUtils.getRenamedFilename(upFile.getOriginalFilename());

				// a.?????????????????? ??????
				File dest = new File(saveDirectory, renamedFilename);
				upFile.transferTo(dest); // ????????????

				// b.????????? ???????????? Attachment????????? ?????? ??? list??? ??????
				Attachment attach = new Attachment();
				attach.setOriginalFilename(upFile.getOriginalFilename());
				attach.setRenamedFilename(renamedFilename);
				attachList.add(attach);
			}

			log.debug("attachList = {}", attachList);
			// board????????? ??????
			board.setAttachList(attachList);

			// 2. ???????????? : db?????? board, attachment
			int result = boardService.insertBoard(board);

			// 3. ?????????????????? & ???????????????
			redirectAttr.addFlashAttribute("msg", "??????????????? ??????!");
		} catch (Exception e) {
			log.error("????????? ?????? ??????!", e);
			throw e;
		}
		return "redirect:/board/boardDetail.do?no=" + board.getNo();
	}

	@GetMapping("/boardDetail.do")
	public void selectOneBoard(@RequestParam int no, Model model) {

		try {
			boardService.readCount(no);
			// 1. ???????????? : board - attachment
			BoardExt board = boardService.selectOneBoardCollection(no);
			log.debug("board = {}", board);

			// 2. jsp??? ??????
			model.addAttribute("board", board);
		} catch (Exception e) {
			log.error("????????? ?????? ??????!", e);
			throw e;
		}
		
		
	}

	@GetMapping("/fileDownload.do")
	public ResponseEntity<Resource> fileDownloadWithResponseEntity(@RequestParam int no)
			throws UnsupportedEncodingException {
		// 1. ???????????? : db??????
		Attachment attach = boardService.selectOneAttachment(no);
		ResponseEntity<Resource> responseEntity = null;

		try {
			// ????????????
			if (attach == null) {
				return ResponseEntity.notFound().build();
			}

			// 2. Resource??????
			String saveDirectory = application.getRealPath("/resources/upload/board");
			File downFile = new File(saveDirectory, attach.getRenamedFilename());
			Resource resource = resourceLoader.getResource("file:" + downFile);
			String filename = new String(attach.getOriginalFilename().getBytes("utf-8"), "iso-8859-1");
			// 3. ResponseEntity ?????? ?????? ??? ??????
			// builder??????
			responseEntity =
					// 200????????? ??????
					ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_OCTET_STREAM_VALUE)
							.header(HttpHeaders.CONTENT_DISPOSITION, "attachment;filename=" + filename).body(resource);

		} catch (Exception e) {
			log.error("?????? ???????????? ??????", e);
			throw e;
		}
		return responseEntity;
	}

	@GetMapping("/boardUpdate.do")
	public void selectUpdate(@RequestParam int no, Model model) {

		// 1. ???????????? : board - attachment
		BoardExt board = boardService.selectOneBoardCollection(no);
		log.debug("board = {}", board);

		// 2. jsp??? ??????
		model.addAttribute("board", board);
	}

	@PostMapping("/boardUpdate")
	public void boardUpdate(@ModelAttribute BoardExt boardExt, @RequestParam(name = "upFile") MultipartFile[] upFiles)
			throws Exception {

		try {

			log.debug(" boardExt {}", boardExt);

			String saveDirectory = application.getRealPath("/resources/upload/board");
			log.debug("saveDirectory = {}", saveDirectory);

			List<Attachment> attachList = new ArrayList<>();
			for (MultipartFile upFile : upFiles) {
				log.debug("upFiles = {}", upFiles);
				// input[name=upFile]????????? ???????????? upFile??? ????????????.
				// ???????????? ??????????????? ????????? ????????? ????????? ?????????
				if (upFile.isEmpty())
					continue;

				String renamedFilename = UpmuUtils.getRenamedFilename(upFile.getOriginalFilename());

				// a.?????????????????? ??????
				File dest = new File(saveDirectory, renamedFilename);
				upFile.transferTo(dest); // ????????????

				// b.????????? ???????????? Attachment????????? ?????? ??? list??? ??????
				Attachment attach = new Attachment();
				attach.setOriginalFilename(upFile.getOriginalFilename());
				attach.setRenamedFilename(renamedFilename);
				attachList.add(attach);
			}

			log.debug("attachList = {}", attachList);
			// board????????? ??????
			boardExt.setAttachList(attachList);

			int result = boardService.boardUpdate(boardExt);

			
		} catch (Exception e) {
			log.error("????????? ?????? ??????", e);
			throw e;
		}
	}

	@PostMapping("/boardDelete/{no}")
	@ResponseBody
	public int boardDelete(@PathVariable String no) {
				
			int number = Integer.parseInt(no);
		try {
			log.debug("no {}", no);
			int result = boardService.boardDelete(number);
			log.debug("result {}", result);
			return result;
		} catch (Exception e) {
			log.error("????????? ?????? ??????", e);
			throw e;
		}
	}
	
	@GetMapping("/boardSearch.do")
	@ResponseBody
	public List<BoardExt> boardSearch(@RequestParam String search){
		try {
			log.debug("search {}", search);
			List<BoardExt> list = boardService.boardSearch(search);
			log.debug("list {}", list);
			return list;
		} catch (Exception e) {
			log.error("????????? ?????? ??????", e);
			throw e;
		}
	}

	@PostMapping("/deleteFile")
	@ResponseBody
	public int deleteFile(@RequestBody int no) {
		try {
			log.debug("no {}", no);
			
			int result = boardService.deleteFile(no);
			return result;
		} catch (Exception e) {
			log.error("????????? ?????? ??????", e);
			throw e;
		}
	}
	
	@GetMapping("/mainBoardList")
	@ResponseBody
	public List<BoardExt> mainBoardList(){
		
		try {
			log.debug("{}", 11111111);
			List<BoardExt> list = boardService.mainBoardList();
			log.debug("list {}", list);
			return list;
		} catch (Exception e) {
			log.error("????????? ?????? ??????", e);
			throw e;
		}
	}
	
}
