<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardweb.LoginUser" %>
<%@ page import="java.sql.*" %>
<%@ page import="boardweb.util.PagingUtil" %>
<%@ page import="boardweb.util.DBManager" %>

<%
	request.setCharacterEncoding("UTF-8");

	LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");

	
	//현재 페이지 파라미터 얻어오기
	String nowPageStr = (String)request.getParameter("nowPage");
	if(nowPageStr == null){
		nowPageStr = "1";
	}
	//한 화면에서의 게시글 갯수
	int perPage = 20;
	
	String searchType = (String)request.getParameter("searchType");
	String searchValue =(String)request.getParameter("searchValue");
	
	if(searchType == null){
		searchType = "";
	}
	if(searchValue == null){
		searchValue = "";
	}
	
	//DB연결후 board 테이블 데이터 목록 가져오기
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	conn = DBManager.getConnection();
	
	
	String totalSql  = "select count(*) as cnt ";
		   totalSql +=" from board b ,mem m";
		   totalSql +=" where b.mno = m.mno";
	   if(searchValue != null && !searchValue.equals("")){
		   	if(searchType.equals("title")){
		   		totalSql +=" and b.btitle like '%"+searchValue+"%'";
		   	}else if(searchType.equals("writer")){
		   		totalSql += " and m.mname = '"+searchValue+"'";
		   	}
	   }
	   
	psmt = conn.prepareStatement(totalSql);
	rs = psmt.executeQuery();
	
	int total = 0;
	if(rs.next()){
		total = rs.getInt("cnt");
	}
	
	PagingUtil paging 
		= new PagingUtil(total
				        ,Integer.parseInt(nowPageStr)
				        ,perPage);
	

	System.out.println("게시글 총 갯수->"+total);
	
	psmt = null;
	rs = null;
	
	String sql = "";  
		   sql +="select B.* from ";
	       sql +=" (select rownum as rnum, A.* from ";
		   sql +=" (select m.mname,b.bno,b.btitle,";
		   sql +="to_char(b.bdate,'yyyy-mm-dd') as bdate,bcategory ";
		   sql +=" from board b ,mem m";
		   sql +=" where b.mno = m.mno";
		   if(searchValue != null && !searchValue.equals("")){
			   	if(searchType.equals("title")){
			   		sql +=" and b.btitle like '%"+searchValue+"%'";
			   	}else if(searchType.equals("writer")){
			   		sql += " and m.mname = '"+searchValue+"'";
			   	}
		   	
		   }
		   sql +=" order by b.bno) A";
		   sql +=" where rownum <= "+paging.getEnd() +") B" ;// 게시글 끝번호
		   sql +=" where B.rnum >="+paging.getStart();
	
	System.out.println(sql);
		   
	psmt = conn.prepareStatement(sql);
	
	rs = psmt.executeQuery();
	
	

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../style.css">
    <title>나만 없어 고양이</title>
    <script src="https://kit.fontawesome.com/57da38e2a5.js" crossorigin="anonymous"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
    <script>
		function goWrite(){
			var login = '<%=loginUser%>';
			if(login != 'null'){
				location.href="write.jsp";
			}else{
				alert("접근권한이 없습니다.");
			}
		}
	</script>
    <style>
    a:hover{
    	color:#060606;
    }
    </style>
</head>
<body>
    <div class="mainBox">
    	<div class="user bar">
                    <%if(loginUser == null){ %>
					<button class="loginBtn"onclick="location.href='login.jsp'">로그인</button>
					<%}else{ %>
					<button class="loginBtn" onclick="location.href='logout.jsp'">로그아웃</button>
                    <b><%=loginUser.getName() %></b>님 계정입니다.
                    <%} %>
                </div>
        <header class="head">
            <i class="fas fa-paw"></i>
            <a href="#" class="title">나만 없어 고양이</a>
        </header>
        <nav class="menuBar">
            <ul class="menu">
                <li><a href="#">공지사항</a></li>
                <li><a href="totalList.jsp">전체 게시글</a></li>
                <li><a href="#">안냥</a></li>
                <li><a href="">궁굼하다냥</a></li>
                <li><a href="#">냥품생활</a></li>
                <li><a href="#">고영희씨 사진첩</a></li>
            </ul>
        </nav>
        <section >
        <form action="list.jsp" method="get">
            <div class="middleBar">
               
                <div class="bar">
                    <button class="writeBtn">게시글 작성</button>
                </div>
                <div class="search bar">
                    <button class="searchBtn"><i class="fas fa-search"></i></button>
                    <select class="searchS">
                    	<option value="1">제목+내용</option>
                    	<option value="2">작성자</option>
                    </select>
                    <input class="searchBox" type="text" placeholder="검색"/>
                </div>
            </div>
             </form>
            <div class="body">
                <div class="name">
                    전체 게시글
                </div>
                <hr/>
                <table class="list" border="1">
                    <tr>
                        <th>순번</th>
                        <th>카테고리</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>날짜</th>
                    </tr>
                   
				<%
						int count =1;
						while(rs.next()){
							String title = rs.getString("btitle");
							String wdate = rs.getString("bdate");
							int bno = rs.getInt("bno");
							String writer = rs.getString("mname");
							String cg = rs.getString("bcategory");
					%>
					<tr>
						<td><%= bno %></td> <!-- ★ -->
						<td><%= cg %></td>
						<td><a href="HelloDetail.jsp?bno=<%= bno%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>&nowPage=<%=nowPageStr%>"><%= title %></a></td>
						<td><%= writer %></td>
						<td><%= wdate %></td> 
					</tr>	
					<%		
							count++;
						}
					
						DBManager.close(psmt,conn,rs);
					%>
					
                </table>
                <div class="number">
                    <a href="#">&lt;</a>
                    <a href="#">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <a href="#">4</a>
                    <a href="#">5</a>
                    <a href="#">6</a>
                    <a href="#">7</a>
                    <a href="#">8</a>
                    <a href="#">9</a>
                    <a href="#">10</a>
                    <a href="#">&gt;</a>
                </div>
            </div>
        </section>
    </div>
</body>