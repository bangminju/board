<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="boardweb.LoginUser" %> <%
	request.setCharacterEncoding("UTF-8");
	String id = (String)request.getParameter("id");
	String password = (String)request.getParameter("password");
	String name = (String)request.getParameter("name");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "tester2";
		String dbpass = "1234";
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,dbpass);
		
		
		String sql = "";
				sql += "insert into mem(mno,mid,mpass,mname,adminyn) ";
				sql += "values(SEQ_MEM_MNO.nextval,'"+id+"','"+password+"','"+name+"','N')";
				
		System.out.println(sql);
		psmt = conn.prepareStatement(sql);
		 psmt.executeUpdate();
		
		conn.commit();
		conn.setAutoCommit(true);
		
		
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		conn.close();
		psmt.close();
	}
	
	response.sendRedirect("login.jsp");
%>