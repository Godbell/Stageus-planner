<%@ page language="java" pageEncoding="utf-8" %>

<%@ page import="java.util.*" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%!
  public boolean isTelValid(String tel) {
    if (tel == null) {
      return false;
    }
    else if (tel.length() != 10 && tel.length() != 11) {
      return false;
    }
    else if (!tel.matches("^[0-9]+$")) {
      return false;
    }
    else return true;
  }
%>

<%
  request.setCharacterEncoding("utf-8");
  String tel = request.getParameter("tel");

  if (isTelValid(tel)) {
    // connect to db
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection(
      "jdbc:mysql://localhost/planner",
      "stageus",
      "stageus"
    );

    String sql = "SELECT count(*) as cnt FROM user WHERE tel=?;";
    PreparedStatement query = connect.prepareStatement(sql); 
    query.setString(1, tel);

    ResultSet data = query.executeQuery();

    if (data.next()) {
      int telCount = data.getInt("cnt");
      if (telCount > 0) {
        out.print("TEL_DUPLICATE");
      }
      else {
        out.print("TEL_VALID");
      }
    }
  }
  else {
    out.print("TEL_INVALID");
  }
%>