<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.*" %>
<%@ page import="boardweb.util.DBManager" %>
<%@ page import="boardweb.LoginUser" %>    
<%
	String bno = (String)request.getParameter("bno");
	String comment = (String)request.getParameter("comment");
	
	//jsp로 할때
	String searchType = (String)request.getParameter("searchType");
	String searchValue =(String)request.getParameter("searchValue");
	//--------------------------------------------------------------
	
	//out.print(bno+","+comment);
	
	LoginUser lu = (LoginUser)session.getAttribute("loginUser");
	
	int mno = lu.getNo();
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();
		String sql = "insert into reply values(seq_reply_cno.nextval,?,sysdate,?,?)";
		
		psmt = conn.prepareStatement(sql);
		
		
		psmt.setString(1,comment);
		psmt.setInt(2,Integer.parseInt(bno));
		psmt.setInt(3,mno);
		psmt.executeUpdate();
		conn.commit();
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt, conn);
	}
	
	//response.sendRedirect("whydetail.jsp?bno="+bno+"&searchType="+searchType+"&searchValue="+searchValue); 

%>