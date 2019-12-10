<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.SQLException"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>

<%
 //1.사용자가 입력한 아이디 얻어오기
    request.setCharacterEncoding("UTF-8");
    String id=request.getParameter("id");
 //2.해당아이디가 존재하는지 검사

  Connection conn=null;
  PreparedStatement pstmt=null;
  ResultSet rs=null;
  boolean result=false;
  Context init = new InitialContext();
  DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
  conn = ds.getConnection();

 try{
  String sql="select * from client where client_id=?";
  pstmt=conn.prepareStatement(sql);
  pstmt.setString(1, id);
  rs=pstmt.executeQuery();
  if(rs.next()){
   result=true;
  }


 }catch(SQLException se){
  System.out.println(se.getMessage());
  
 }finally{
  rs.close();
  pstmt.close();
  conn.close();
 }
 
 ////////// 3.xml로 결과 응답하기 ///////////
 response.setContentType("text/xml;charset=euc-kr");
 PrintWriter pw=response.getWriter();
 pw.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
 pw.println("<data>");
 pw.println("<result>" + result + "</result>");
 pw.println("</data>");
 pw.close();
 
%>