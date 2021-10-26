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
	String cno = (String)request.getParameter("cno");
	
 	
 	Connection conn = null; 
    PreparedStatement psmt = null;
    ResultSet rs = null;
    ResultSet rs2 = null;
    
	try{
		conn = DBManager.getConnection();
		String sql="select bno,bcategory,btitle,to_char(bdate,'yyyy-mm-dd')as bdate,bcontent,img1,img2,img3,mname from board, mem where bno="+bno;
		//�������̺� ���� ���ٸ� �����ò��ϱ� �������̺� bno�� �������� �� list�� ������ ���ƾ���
		
		
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		rs.next();
		
	
		//��� â �����ֱ� ���� ���� �ٽ� ������
		String csql="select cno,ccontent,to_char(cdate,'yyyy-mm-dd')as cdate,bno,mem.mno,mname from reply,mem where bno="+bno;
		
		System.out.println(csql);
		psmt = conn.prepareStatement(csql);
		rs2 = psmt.executeQuery();
	    
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../style.css">
    <title>�󼼺���</title>
    <script>
	function delFn(){
		var yn = confirm("�����Ͻðڽ��ϱ�?");
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
    <script src = "jquery-3.6.0.min.js"></script>
    <script>
    $(document).ready(function(){
    	$("#bt").click(function(){
    		$.ajax({
    			url:"Comment.jsp",
    			type:"post",
    			data:$(".cf").serialize(),
    			datatype:"html",
    			success:function(data){
    				$(".commentText").append(data);
    			},
    			error:function(){
    				console.log("error");
    			}
    		})
    	});
    });
    </script>
</head>
<body>
    <div class="mainBox">
    	<div class="user bar">
                    <%if(loginUser == null){ %>
					<button class="loginBtn"onclick="location.href='login/login.jsp'">�α���</button>
					<%}else{ %>
					<button class="loginBtn" onclick="location.href='login/logout.jsp'">�α׾ƿ�</button>
                    <b><%=loginUser.getName() %></b>�� �����Դϴ�.
                    <%} %>
                </div>
        <header class="head">
            <i class="fas fa-paw"></i>
            <a href="#" class="title">���� ���� �����</a>
        </header>
        <nav class="menuBar">
            <ul class="menu">
                <li><a href="#">��������</a></li>
                <li><a href="#">��ü �Խñ�</a></li>
                <li><a href="#">�ȳ�</a></li>
                <li><a href="#">�ñ��ϴٳ�</a></li>
                <li><a href="#">��ǰ��Ȱ</a></li>
                <li><a href="#">���� ����ø</a></li>
            </ul>
        </nav>
        <section >
            <div class="middleBar">
                
                <div class="bar">
                    <button class="writeBtn">�Խñ� �ۼ�</button>
                </div>
                <div class="search bar">
                    <button class="searchBtn"><i class="fas fa-search"></i></button>
                    <input class="searchBox" type="text" placeholder="�˻�"/>
                </div>
            </div>
            <div class="footbar">
                <div class="modify">
                    <input type="button" value="����">
                </div>
                <div class="delete">
                    <input type="button" value="����">
                </div>
                <div class="mainlist">
                    <input type="button" value="���">
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
                    <a href="#">�ȳ�></a>
                </div>
                <div class="title">
                    ���� : <%= title %>
                </div>
                <div class="writer">
                    <i class="far fa-user"></i>
                    �ۼ��� : 
                </div>
                <hr>
            		<h2>���� �󼼺���</h2>
            		<table border = "1">
						<tr>
							<th>����</th>
							<td><%= content %></td>
						</tr>
						<tr>		
							<th>����</th>
							<td><%= img1 %></td>
							<td><%= img2 %></td>
							<td><%= img3 %></td>
						</tr>
						<tr>
							<th>��¥</th>
							<td><%= date %></td>
						</tr>
						</table>
						
					
                <div class="middlebody">

                </div>
                <hr>
                <div class="footbody">
                    <div class="commentTitle">
                        ���
                    </div>
                    <form class="cf">
                    <div class="comment">
                    	<table>
                    	<% //�� ���ٸ� ���;ߵǴϱ� ���̺� ���ʿ��� �����ϰ� 
                    		while(rs2.next()){
                    			String ccontent = rs2.getString("ccontent");
                    			String cdate = rs2.getString("cdate");
                    			String cname = rs2.getString("mname");
                    		
                    	%>
                    	
                    		<tr>
                    			<td><%=cname %></td>
                    			<td><%=ccontent %></td>
                    			<td><%=cdate %></td>
                    		</tr>
                    		<%
                    		} //�� ������ �����°� ��������~
                    		%>
                    	</table>
                    	
                    	
                        <div class="commentBox">
                            <div class="commentWriter">
                                �ۼ�
                            </div>
                            <div>
                            	<input type="hidden" id="bno" name="bno" value="<%=bno%>">
                                <textarea "text" class="commentText" name="comment"
                                placeholder="����� ���ܺ�����." onfocus="this.placeholder=''" onblur="this.placeholder='����� ���ܺ�����.'">
                                </textarea>
                            </div>
                            <div class="commentBtn">
                                <button id="bt"> ���</button>
                            </div>
                        </div>
                    </div>
                    </form>
                </div>
            </div>
        </section>
    </div>
</body>