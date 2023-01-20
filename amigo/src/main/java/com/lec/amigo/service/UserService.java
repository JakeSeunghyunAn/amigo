package com.lec.amigo.service;


import com.lec.amigo.vo.UserVO;

public interface UserService {

	UserVO getUser(String email);
	UserVO insertUser(UserVO userVO);

	public void sendEmail(UserVO vo, String div);
	public int searchPw(UserVO vo);
	
}
