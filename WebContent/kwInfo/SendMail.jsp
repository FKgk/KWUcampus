<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="dbPractice.Management.*"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
 
String from = request.getParameter("Fmail");
String[] to = request.getParameterValues("Tmail");
String subject = request.getParameter("subject");
String content = request.getParameter("contents");
// 입력값 받음
System.out.println(from);
System.out.println(to[0]);
System.out.println(subject);
System.out.println(content);
 
Properties p = new Properties(); // 정보를 담을 객체
 
p.put("mail.smtp.host","smtp.naver.com");
 
p.put("mail.smtp.port", "587");
p.put("mail.smtp.starttls.enable", "true");
p.put("mail.smtp.auth", "true");
p.put("mail.smtp.debug", "true");
//p.put("mail.smtp.ssl.enable", "true");
//p.put("mail.smtp.socketFactory.port", "465");
//p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
//p.put("mail.smtp.socketFactory.fallback", "false");
// SMTP 서버에 접속하기 위한 정보들
 

	for (int i = 0; i < to.length; i++) {
		
		try {
			Authenticator auth = new SMTPAuthenticator(from, request.getParameter("Fpass"));
			Session ses = Session.getInstance(p, auth);

			ses.setDebug(true);

			MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체
			msg.setSubject(subject); // 제목

			Address fromAddr = new InternetAddress(from);
			msg.setFrom(fromAddr); // 보내는 사람

			Address toAddr = new InternetAddress(to[i]);
			msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람

			msg.setContent(content, "text/html;charset=UTF-8"); // 내용과 인코딩

			Transport.send(msg); // 전송
		} catch (Exception e) {
			e.printStackTrace();
			out.println("<script>alert('Send Mail Failed..');history.back();</script>");
		}
	}
	response.sendRedirect("Smanagement.jsp");


	//System.out.println("<script>alert('Send Mail Success!!');location.href='Smanagement.jsp';</script>");
	// 성공 시
%>