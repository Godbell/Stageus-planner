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

  public boolean isNameValid(String name) {
    if (name == null) {
      return false;
    }
    else if (name.length() < 2 || name.length() > 20) {
      return false;
    }
    else if (!name.matches("^[a-zA-Z가-힣]+$")) {
      return false;
    }
    else return true;
  }
%>

<%
  request.setCharacterEncoding("utf-8");
  String name = request.getParameter("name");
  String tel = request.getParameter("phone-number");

  boolean isFindingSucceeded = false;
  String foundMail = null;
  String message = "\"no message specified\"";

  // connect to db
  Class.forName("com.mysql.jdbc.Driver");
  Connection connect = DriverManager.getConnection(
    "jdbc:mysql://localhost/planner",
    "stageus",
    "stageus"
  );

  boolean isFindingInfoValid = isNameValid(name) && isTelValid(tel);

  if (isFindingInfoValid) {
    try {
      String sql
       = "SELECT mail FROM user WHERE name=? AND tel=?";
      PreparedStatement query = connect.prepareStatement(sql); 
      query.setString(1, name);
      query.setString(2, tel);

      ResultSet data = query.executeQuery();
      if (data.next()) {
        isFindingSucceeded = true;
        foundMail = data.getString("mail");
      }
      else {
        isFindingSucceeded = false;
      }
    }
    catch (Exception e) {
      isFindingSucceeded = false;
      message = "\'" + e.getMessage() + "\'";
    }
  }
  else {
    message = "\'invalid input\'";
    isFindingSucceeded = false;
  }
%>

<script>
  const isFindingSucceeded = <%=isFindingSucceeded %>;
  const message = <%=message %>;
  if (isFindingSucceeded) {
    alert(`<%=name %>님의 메일 주소는 <%=foundMail %>입니다.`);
    location.href = '/stageus-planner';
  }
  else {
    alert(`가입 정보가 없습니다.`);
    history.back();
  }
</script>