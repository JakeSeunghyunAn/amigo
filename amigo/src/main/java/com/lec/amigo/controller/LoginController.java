package com.lec.amigo.controller;


import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.lec.amigo.dao.ChatDAO;
import com.lec.amigo.dao.UserDAO;
import com.lec.amigo.impl.UserServiceImpl;
import com.lec.amigo.vo.ChatRoom;
import com.lec.amigo.vo.UserVO;

@Controller
public class LoginController {
	
	@Autowired
	UserServiceImpl userService;
	
	private String uploadFolder = "";
	
	
	// 로그인 화면 
	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String login() {	
		return "view/login/login_form.jsp"; 
	}
	
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String login(UserVO userVO, UserDAO userDAO, HttpSession sess) {
			
		UserVO user = userDAO.getUser(userVO.getUser_email()); // 사용자가 입력한 이메일을 getUser메서드로 DB 있는지 찾기

		if(user == null) {
			sess.setAttribute("isLoginSuccess", false);
			return "view/login/login_form.jsp";
		}
		
		if(!user.getUser_pw().equals(userVO.getUser_pw())) {
			sess.setAttribute("matchedPassword", false);
			return "view/login/login_form.jsp";
		} else {
			sess.setAttribute("matchedPassword", true);
		}
		
		if(user.getUser_email().equals(userVO.getUser_email())) {
			sess.setAttribute("user", user);
			//실챗 실시간 알림용 세션 어트리뷰트 설정한거니 지우지마세요! 싫은데용
			ChatDAO chat_dao = new ChatDAO();
			List<ChatRoom> room_list = chat_dao.getRoomList(user.getUser_no());
			if(!room_list.isEmpty()) {
				sess.setAttribute("chat_room_list", room_list);
			}
			
			if(user.getUser_type().equals("A")) {
				sess.setAttribute("isAdmin", true);
			} else {
				sess.setAttribute("isAdmin", false);
			}
			return "view/main.jsp";
		} else {
			sess.setAttribute("isLoginSuccess", false);
			return "view/login/login_form.jsp";
		}
		
	}
	
	// 로그아웃
	@RequestMapping(value ="/logout.do", method = RequestMethod.GET)
	public String logout(HttpSession sess) {
		sess.invalidate();
		return "home.jsp";
	}
	
	// 회원탈퇴
	@RequestMapping(value="/revoke.do", method = RequestMethod.GET)
	public String revoke(UserVO userVO) {
		userService.revokeUser(userVO.getUser_no());
		return "home.jsp";
	}
	
	// 이메일로 인증하기
	@PostMapping("/emailAuth.do")
	@ResponseBody
	public String emailAuth(String user_email) {	
		System.out.println(user_email);
		return userService.emailAuth(user_email);
	}
	
	// 비밀번호 찾기
	@RequestMapping(value = "/search_pwd.do", method = RequestMethod.GET)
	public String search_pwd() {
		return "view/login/search_pwd_form.jsp";
	}
	
	@RequestMapping(value = "/search_pwd.do", method = RequestMethod.POST)
	   public String search_pwq(UserVO vo, Model model) {
	     int cnt = userService.searchPw(vo);
	     if (cnt != 0) {
	 		model.addAttribute("msg", "이메일로 임시 비밀번호가 전송되었습니다.");
			model.addAttribute("url", "login.do");
			return "view/login/search_pwd_alert.jsp";
	     } else {
	    	model.addAttribute("msg", "등록된 이메일이 없습니다. 다시 입력해주세요.");
			model.addAttribute("url", "search_pwd.do");
			return "view/login/search_pwd_alert.jsp";
	     }
	   }
	
	// 약관동의
	@RequestMapping(value="/terms.do", method = RequestMethod.GET)
	public String terms() {	
		return "view/login/terms.jsp"; 
	} 
	
	// 회원가입
	@RequestMapping(value="/signup.do", method = RequestMethod.GET)
	public String signup() {
		return "view/signup/sign_up_form.jsp";
	}
	
	@RequestMapping(value="/signup.do", method = RequestMethod.POST)
	public String signup(UserVO userVO, HttpServletRequest req, Model model) {
		
		userVO.setUser_addr(userVO.getUser_addr()+" "+req.getParameter("user_addr2"));		
		userService.insertUser(userVO);
		model.addAttribute("msg", "회원가입이 완료되었습니다. 로그인 해주세요.");
		model.addAttribute("url", "login.do");
		return "view/signup/sign_up_alert.jsp";
	}
	
	// 이메일 중복체크
	@PostMapping("emailCheck.do")
	@ResponseBody
	public String emailCheck(@RequestParam("user_email") String user_email){
		int cnt = userService.emailCheck(user_email);
		if (cnt != 0) {
			return "fail";
		} else {
			return "success";
		}
	}
	
	// 닉네임 중복체크
	@PostMapping("nickCheck.do")
	@ResponseBody
	public String nickCheck(@RequestParam("user_nick") String user_nick){
		int cnt = userService.nickCheck(user_nick);
		if (cnt != 0) {
			return "fail";
		} else {
			return "success";
		}
	}
	
	// 둘러보기
	@RequestMapping(value="/main_tour.do", method = RequestMethod.GET) 
	public String main_tour() {
		return "view/main_tour.jsp"; 
	}
	
	// 내 프로필
	@RequestMapping(value="/my_profile.do",  method = RequestMethod.GET)
	public String myProfile() {
		return "view/mypage/my_profile.jsp";
	}
	
	// 회원 정보 수정
	@RequestMapping(value="/updateUser.do", method = RequestMethod.POST)
	public String updateUser(Model model, UserVO userVO, HttpSession sess) throws IOException {
		
		MultipartFile uploadFile = userVO.getUploadFile();
		
		if (!uploadFile.isEmpty()) {
			String fileName = uploadFile.getOriginalFilename();
			String fileExtension = fileName.substring(fileName.lastIndexOf("."),fileName.length());
			UUID uuid = UUID.randomUUID();
			String[] uuids = uuid.toString().split("-");
			String uniqueName = uuids[0] + fileExtension; // 랜덤 글자 생성
			uploadFile.transferTo(new File(uploadFolder + fileName + uniqueName));
			userVO.setUser_photo(fileName+uniqueName);
		}
		
		// 바뀐 정보로 세션 정보 업데이트!
		sess.setAttribute("user", userService.updateUser(userVO));
		model.addAttribute("msg","정보가 정상적으로 수정되었습니다.");
		model.addAttribute("url","my_profile.do");
		
		return "view/comunity/alert.jsp";
	}
	
	
}
