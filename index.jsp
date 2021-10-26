<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="boardweb.LoginUser" %>
<%
	LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>나만 없어 고양이</title>
    <script src="https://kit.fontawesome.com/57da38e2a5.js" crossorigin="anonymous"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
    <style>
        .youtube{
            width: 600px;
            height: 350px;
            background-color: #f4d4d4;
            text-align: center;
            justify-self: center;
            margin-left: auto;
            margin-right: auto;
            position: relative;
            top: 30px;

        }
        .vod{
            position: relative;
            top: 16px;
        }
        .board{
            display: flex;
        }
        .total{
            width: 400px;
            height: 350px;
            background-color:#f4d4d4;
            margin-top: 80px;
            margin-left: 70px;
        }
        .notice{
            width: 400px;
            height: 350px;
            background-color:#f4d4d4;
            margin-top: 80px;
            margin-left: 60px;
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
                    <select class="searchS">
                    	<option value="1">제목+내용</option>
                    	<option value="2">작성자</option>
                    </select>
                    <input class="searchBox" type="text" placeholder="검색"/>
                </div>
            </div>
            <div class="body">
                <div class="youtube">
                    <iframe class="vod"width="560" height="315" src="https://www.youtube.com/embed/U6gXFcywFug" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                </div>
                <div class="board">
                    <div class="total">
                        <div class="t_title">
                            전체 게시글
                        </div>
                        <table>
                        	<tr>
                        		<td></td>
                        	</tr>
                        </table>
                    </div>
                    <div class="notice">
                        <div class="n_title">
                            공지사항
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    
</body>