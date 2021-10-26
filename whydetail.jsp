<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.*" %>
<%@ page import="boardweb.util.DBManager" %>
<%@ page import="boardweb.LoginUser" %> 
<%
	LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");

	String srarchType = (String)request.getParameter("searchType");
	String srarchValue = (String)request.getParameter("searchValue");
	
	String bno = (String)request.getParameter("bno");
	String mno = (String)request.getParameter("mno");
	
 	
 	Connection conn = null; 
    PreparedStatement psmt = null;
    ResultSet rs = null;
    
	try{
		conn = DBManager.getConnection();
		String sql="select bno,bcategory,btitle,to_char(bdate,'yyyy-mm-dd')as bdate,bcontent,img1,img2,img3,mname from board, mem where bno="+bno;
		//보드테이블에 대한 한줄만 가져올꺼니까 보드테이블에 bno만 가져오면 됨 list의 쿼리랑 같아야함
		
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		rs.next();
		
		//rs변수를 다시 선언해서 rs를 재사용하는 방법
		
	    ResultSet rs2 = null;
		
		String ctsql = "select * from reply";
	    
		psmt = conn.prepareStatement(ctsql);
		rs2 = psmt.executeQuery();
	    
		rs.next();
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html lang="en"></html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../style.css">
    <title>상세보기</title>
    <script>
	function delFn(){
		var yn = confirm("삭제하시겠습니까?");
		if(yn){
			location.href="delectOk.jsp?bno=<%=bno%>";
		}
	}
</script>
    <script src="https://kit.fontawesome.com/57da38e2a5.js" crossorigin="anonymous"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
    <style>
        .boardName{
            font-size: 14px;
            margin-left: 30px;
            padding-top: 10px;
        }
        .title{
            margin-top: 5px;
            margin-left: 30px;
            font-size: 26px;
        }
        .writer{
            font-size: 14px;
            margin-left: 30px;
        }
        .footbar{
            display:flex;
        }
        input[type=button]{
            text-align: right;
            background-color: #f4d4d4;
            border-radius: 6px;
            border: none;
            width: 50px;
            height: 30px;
            text-align: center;
            color: rgb(85, 83, 83);
        }
        .modify{
            margin-top: 10px;
        }
        .delete{
            margin-top: 10px;
            margin-left: 10px;
        }
        .mainlist{
            margin-top: 10px;
            margin-left: 840px;
        }
        .body{
            margin-top: 5px;
        }
        .middlebody{
            width: auto;
            height: 520px;
        }
        .commentTitle{
            margin-left: 30px;
            font-size: 20px;
        }
        .commentBox{
            margin-left: 30px;
            width: 94%;
            height: 100px;
            border: 0.5px solid gray;
            border-radius: 6px;
            background-color: #f4d4d4;
        }
        .commentWriter{
            margin-left: 20px;
            font-size: 14px;
            margin-top: 10px;
        }
        .commentText{
            margin-left: 20px;
            border: none;
            background-color: #f4d4d4;

        }
        .commentBtn{
            margin-top: 10px;
            margin-left: 880px;
            font-size: 10px;
        }
        .commentText:focus{
            border: none;
            outline: none;
        }
    </style>
</head>
<body>
    <div class="mainBox">
    	<div class="user bar">
                    <%if(loginUser == null){ %>
					<button class="loginBtn"onclick="location.href='login/login.jsp'">로그인</button>
					<%}else{ %>
					<button class="loginBtn" onclick="location.href='login/logout.jsp'">로그아웃</button>
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
                <li><a href="#">전체 게시글</a></li>
                <li><a href="#">안냥</a></li>
                <li><a href="#">궁굼하다냥</a></li>
                <li><a href="#">냥품생활</a></li>
                <li><a href="#">고영희씨 사진첩</a></li>
            </ul>
        </nav>
        <section >
            <div class="middleBar">
                
                <div class="bar">
                    <button class="writeBtn">게시글 작성</button>
                </div>
                <div class="search bar">
                    <button class="searchBtn"><i class="fas fa-search"></i></button>
                    <input class="searchBox" type="text" placeholder="검색"/>
                </div>
            </div>
            <div class="footbar">
                <div class="modify">
                    <input type="button" value="수정">
                </div>
                <div class="delete">
                    <input type="button" value="삭제">
                </div>
                <div class="mainlist">
                    <input type="button" value="목록">
                </div>
            </div>
            <div class="body">
          		  <%
            		String title = rs.getString("btitle");
            		String category = rs.getString("bcategory");
            		String date = rs.getString("bdate");
            		String content = rs.getString("bcontent");
            		String img1 = rs.getString("img1");
            		String img2 = rs.getString("img2");
            		String img3 = rs.getString("img3");
            		String name = rs.getString("mname");
            		
            		%>
                <div class="boardName">
                    <a href="#">궁금하다냥></a>
                </div>
                <div class="title">
                    제목 : <%= title %>
                </div>
                <div class="writer">
                    <i class="far fa-user"></i>
                    작성자 : 
                </div>
                <hr>
            	
            		<table border = "1">
						<tr>
							<th>내용</th>
							<td><%= content %></td>
						</tr>
						<tr>		
							<th>사진</th>
							<td><%= img1 %></td>
							<td><%= img2 %></td>
							<td><%= img3 %></td>
						</tr>
						<tr>
							<th>날짜</th>
							<td><%= date %></td>
						</tr>
						</table>
						
					
                <div class="middlebody">

                </div>
                <hr>
                <div class="footbody">
                    <div class="commentTitle">
                        댓글
                    </div>
                    <div class="comment">
                    <form action="Comment.jsp" id = "cf" >
                        <div class="commentBox">
                   
                            <div>
                                <input type = "hidden" id = "bno" name= "bno" value="<%=bno%>">
                                <textarea class="commentText" name="cmt"
                                placeholder="댓글을 남겨보세요." onfocus="this.placeholder=''" onblur="this.placeholder='댓글을 남겨보세요.'">
                    			</textarea>
                            </div>
                            <div class="commentBtn">
                                <input type="submit" value="등록">
                            </div>
                        </div>
                    </form>    
                    </div>
                </div>
            </div>
        </section>
    </div>
</body>