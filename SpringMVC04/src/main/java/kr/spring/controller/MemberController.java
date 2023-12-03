package kr.spring.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.spring.entity.Member;
import kr.spring.mapper.MemberMapper;

@Controller
public class MemberController {
		
	@Autowired
	private MemberMapper mapper;
	
	
	@RequestMapping("/joinForm.do")
	public String joinForm() {
		// 컨트롤러에서 실행하면 위치가 views(처음 시작점)
		// -> member 폴더로 들어와야 함
		return "member/joinForm";
	}
	
	@RequestMapping("/idCheck.do")
	public @ResponseBody int idCheck(@RequestParam("memId") String id) {
		// restController가 아니면 @ResponseBody 꼭 써줘야 비동기통신 가능
		Member m = mapper.idCheck(id);
		// m == null : 아이디 사용가능
		// m != null : 아이디 사용불가능
		
		
		if(m != null || id.equals("")) {
			return 0;
		}else {
			return 1;
		}
		
	}
	
	@RequestMapping("/join.do")
	public String join(Member m , RedirectAttributes rttr, HttpSession session) {
		System.out.println("회원가입 요청");
		
		// 유효성 검사
		// 빈값은 없는지 아이디를 잘 입력했는지 등등
		// 백엔드나 프로트엔드 둘 중 하나는 꼭 해줘야함 , 둘 다 해주는 게 베스트
		if(m.getMemId() == null || m.getMemId().equals("") || 
				m.getMemPw() == null || m.getMemPw().equals("") ||
				m.getMemName() == null || m.getMemName().equals("") ||
				m.getMemAge() == 0 ||
				m.getMemEmail() == null || m.getMemEmail().equals("")) {
			// jsp에서 name값이 틀렸음(null값이다) : memId가 아님 or 빈값이 들어옴(아이디를 작성하지 않음)
			
			// 실패 시 joinForm.do로 msgType과 msg내용을 보내야함
			// msgType: 실패메세지, msg: "모든 내용을 입력하세요"
			// 포워딩 방식만 model 사용가능!! -> 여기는 redirect 방식 : model에 저장 X(model 사용 X)
			// session 가능 but)session에 담기에는 적합한 데이터가 아님(너무 간단한거야)
			// RedirectAttributes : pageContext에 저장됨(일회성 Flash 으로, 한페이지에서만, 잠깐 저장 가능)
			// -> 리다이렉트 방식으로 이동할 때 보낼 데이터를 저장하는 객체
			rttr.addFlashAttribute("msgType", "실패메세지");
			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요");
			
			// 하나라도 누락되어 있기 때문에 회원가입을 할 수 없음 -> 회원가입폼으로 이동
			return "redirect:/joinForm.do";
			
		}else {
			// 회원가입 시도 가능
			m.setMemProfile("");
			int cnt = mapper.join(m);
			
			if(cnt == 1) {
				System.out.println("회원가입 성공!");
				rttr.addFlashAttribute("msgType", "성공메세지");
				rttr.addFlashAttribute("msg", "회원가입에 성공했습니다.");
				
				// 회원가입 성공 시 로그인 처리까지
				// 회원가입한 정보 세션에 저장
				session.setAttribute("mvo",m);
				return "redirect:/";
				
			}else{
				System.out.println("회원가입 실패");
				rttr.addFlashAttribute("msgType", "실패메세지");
				rttr.addFlashAttribute("msg", "회원가입에 실패했습니다.");
				return "redirect:/joinForm.do";
			}
			
		}
		
	}
	
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping("/loginForm.do")
	public String loginForm() {
		// 로그인 페이지로 이동하는 기능
		return "member/loginForm";
	}
	
	   @RequestMapping("/login.do")
	   public String login(Member vo, RedirectAttributes rttr, HttpSession session) {
	      
	      // 문제
	      // mapper에 login이라는 메서드 이름으로 로그인 기능 수행하기
	      // 단, 로그인 성공 시 index.jsp 이동 후 "로그인에 성공했습니다" 모달창 띄우기
	      // 로그인 실패 시 login.jsp 이동 후 "로그인에 실패했습니다" 모달창 띄우기
	      
	      Member mvo = mapper.login(vo);   // 로그인 후 해당 회원의 정보를 모두 받아와야 하므로 Member 객체에 저장
	      
	      if(mvo != null) {
	         // 로그인 성공
	         System.out.println("로그인 성공!");
	         
	         rttr.addFlashAttribute("msgType", "성공 메세지");
	         rttr.addFlashAttribute("msg", "로그인에 성공했습니다!");      
	         
	         session.setAttribute("mvo", mvo);  // session에 로그인 정보 저장   
	         return "redirect:/";
	         
	      }else {
	         // mvo == null : 로그인 실패
	         System.out.println("로그인 실패...");
	         rttr.addFlashAttribute("msgType", "실패 메세지");
	         rttr.addFlashAttribute("msg", "로그인에 실패했습니다.");            
	         return "redirect:loginForm.do";         
	      }
	   }
	
	   @RequestMapping("/updateForm.do")
	   public String updateForm() {
	      return "member/updateForm";
	   }
	   
	   
	   
		@RequestMapping("/update.do")
		public String update(Member member, RedirectAttributes rttr, HttpSession session) {
			System.out.println(member.toString());

			// 문제
			// mapper의 update 메서드를 통해 해당 회원의 정보 수정하기

			// 조건 1. 하나라도 입력하지 않은 데이터가 있으면 updateForm.jsp로 다시 돌려보내면서 "모든 내용을 입력하세요"모달창 띄우기
			if (member.getMemPw() == null || member.getMemPw().equals("") || member.getMemName() == null
					|| member.getMemName().equals("") || member.getMemAge() == 0 || member.getMemEmail() == null
					|| member.getMemEmail().equals("")) {

				rttr.addFlashAttribute("msgType", "실패 메세지");
				rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
				return "redirect:/updateForm.do";

			} else {
				// 유효성 검사 성공
				// 원래 코드 : member.setMemProfile(""); -> profile값은 빈값 들어가게 해줌
				
				// 회원정보 수정 시 프로필 값이 null이 되는 문제 해결하기 위한 코드
				// Member mvo = (Member)session.getAttribute("mvo");
				// member.setMemProfile(mvo.getMemProfile());
				
				
				int cnt = mapper.update(member);

				if (cnt != 1) {
					// 조건 2. 회원수정 실패 시 updateForm.jsp로 다시 돌려 보내면서 "회원 정보 수정이 실패했습니다" 모달창 띄우기
					System.out.println("회원수정 실패");
					rttr.addFlashAttribute("msgType", "실패 메세지");
					rttr.addFlashAttribute("msg", "회원정보 수정에 실패했습니다.");
					return "redirect:/updateForm.do";

				} else {
					// 조건 3. 회원수정 성공 시 index.jsp로 보내고 "회원정보 수정에 성공했습니다" 모달창 띄우기
					System.out.println("회원수정 성공");
					rttr.addFlashAttribute("msgType", "성공 메세지");
					rttr.addFlashAttribute("msg", "회원정보 수정에 성공했습니다.");

					// 로그인한 정보는 session에서 유지되고 있음 -> 회원정보 수정 시 session도 업데이트 해줘야함
					session.setAttribute("mvo", member);

					return "redirect:/";

				}
			}
		}
		
		@RequestMapping("/imgForm.do")
		public String imgForm() {
			return "member/imgForm";
		}
		
		@RequestMapping("/imgUpdate.do")
		public String imgUpdate(HttpServletRequest request, HttpSession session, RedirectAttributes rttr) {
			// 이전에는 Request 객체를 따로 불러오지 않아도 내부적으로 스프링이 request.getParameter 해서 vo 묶어줬었음
			
			// 파일 업로드를 할 수 있게 도와주는 객체 필요 : cos.jar
			// (session, request 처럼 내장 객체 X -> 직접 만들어줘야 함)
			MultipartRequest multi = null;
			// MultiPartRequest 객체를 생성하기 위해서는 5개의 정보가 필요
			// (1)요청 데이터 (2)저장경로 (3)최대크기 (4)인코딩 (5)파일명 중복제거

			// 1. 요청 데이터 : request 객체 안에 다 담겨있음(요청에 대한 정보)
			// 2. 저장경로
			String savePt = request.getRealPath("resources/upload");
			// System.out.println(savePt);

			// 3. 이미지 최대크기
			int fileMaxSize = 10 * 1024 * 1024 * 10;

			// 유효성 검사
			// 기존 해당 프로필 이미지 삭제
			// -> 현재 로그인한 사람의 프로필 값을 가져와야 함

			// session.getAttribute("mvo") -> Member로 다운캐스팅 -> .getMemId() : mvo getter 사용
			String memId = ((Member) session.getAttribute("mvo")).getMemId();
			// getMember 메서드는 memId와 일치하는 회원의 정보 (Member)를 가져옴
			String oldImg = mapper.getMember(memId).getMemProfile();
			System.out.println(oldImg);

			// -> 기존 프로필 사진 삭제
			// 해당 저장 경로 안에 이전의 사진 값을 삭제 하겠다
			File oldfile = new File(savePt + "/" + oldImg);
			if (oldfile.exists()) {
				// 있을때만 삭제하겠다!
				// 없을 때 삭제하면 500 에러남
				oldfile.delete();
			}

			// 4. 인코딩 : UTF-8
			// 5. 파일명 중복제거 : 동일 파일명에 +1을 해줌 ( DefaultFileRenamePolicy() )
			// ☆★예외사항 처리 : 파일 업로드에 대한 예외 처리는 IOException이 해줌!
			try {
				multi = new MultipartRequest(request, savePt, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			// 업로드한 파일의 이름 가져오는 코드
			File file = multi.getFile("memProfile");

			if (file != null) {
				System.out.println(file.getName());
				String ext = file.getName().substring(file.getName().lastIndexOf(".") + 1);
				System.out.println(ext);
				// file.getName().substring("." + 1) 이렇게만 해도 되지만
				// . 이 여러개 있는 경우
				// 마지막 . 뒤에 있는 확장자명만 가져오기 위해

				// 확장자가 소문자 , 대문자 인 경우 통일시켜주기 위해
				ext = ext.toUpperCase();

				if (!(ext.equals("PNG") || ext.equals("GIF") || ext.equals("JPG"))) {
					// 위 확장자명이 아니면 삭제해라
					if (file.exists()) {
						file.delete();
						rttr.addFlashAttribute("msgType", "실패 메세지");
						rttr.addFlashAttribute("msg", "이미지 파일만 가능합니다.(PNG, JPG, GIF)");
						return "redirect:/imgForm.do";
					}
				}
			}

			// 업로드한 파일의 이름을 가져오는 코드 : (key값) -> key값의 이름을 가져올 수 있음
			String newProfile = multi.getFilesystemName("memProfile");
			// System.out.println(memId + "/" + newProfile);

			Member mvo = new Member();
			mvo.setMemId(memId);
			mvo.setMemProfile(newProfile);

			// 해당되는 아이디의 프로필 값을 바꿔줌
			mapper.profileUpdate(mvo);
			
			// 사진 업데이트 후 수정된 회원정보를 다시 가져와서 세션에 담기
			// 아이디랑 일치하는 회원정보 가져오는 getMember 메서드 이용하기!
			Member m = mapper.getMember(memId);
			session.setAttribute("mvo", m);
			
			
			rttr.addFlashAttribute("msgType", "성공 메세지");
			rttr.addFlashAttribute("msg", "프로필 사진 변경 완료!");
			return "redirect:/";
		}

}
