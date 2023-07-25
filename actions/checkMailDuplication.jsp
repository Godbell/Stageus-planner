<%@ page language="java" pageEncoding="utf-8" %>

<%@ page import="java.util.*" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%!
  public boolean isMailValid(String mail) {
    if (mail == null) return false;

    String[] mailTokens = mail.split("@");
    
    if (mailTokens.length != 2) {
      return false;
    }
    
    String username = mailTokens[0];
    String domain = mailTokens[1];

    if (username.length() > 64) {
      return false;
    }
    else if (domain.length() > 255) {
      return false;
    }
    else if (!mail.matches("^[a-zA-Z0-9+-_.]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$")) {
      return false;
    } else return true;
  }
%>

<%
  request.setCharacterEncoding("utf-8");
  String mail = request.getParameter("mail");

  if (isMailValid(mail)) {
    // connect to db
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection(
      "jdbc:mysql://localhost/planner",
      "stageus",
      "stageus"
    );

    String sql = "SELECT count(*) as cnt FROM user WHERE mail=?;";
    PreparedStatement query = connect.prepareStatement(sql); 
    query.setString(1, mail);

    ResultSet data = query.executeQuery();

    if (data.next()) {
      int mailCount = data.getInt("cnt");
      if (mailCount > 0) {
        out.print("MAIL_DUPLICATE");
      }
      else {
        out.print("MAIL_VALID");
      }
    }
  }
  else {
    out.print("MAIL_INVALID");
  }
%>