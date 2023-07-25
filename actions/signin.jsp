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

  public boolean isPasswordValid(String password) {
    if (password == null) return false;

    if (password.length() > 20 || password.length() < 8) {
      return false;
    }
    else if (!password.matches("^[ -~]+$")) {
      return false;
    }
    else return true;
  }
%>

<%
  request.setCharacterEncoding("utf-8");
  String mail = request.getParameter("mail");
  String password = request.getParameter("password");
  boolean loginSucceeded = true;

  if (!isMailValid(mail) || !isPasswordValid(password)) {
    loginSucceeded = false;
  }
  else {
    // connect to db
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection(
      "jdbc:mysql://localhost/planner",
      "stageus",
      "stageus"
    );

    String sql = "SELECT idx, password FROM user WHERE mail=?;";
    PreparedStatement query = connect.prepareStatement(sql); 
    query.setString(1, mail);

    ResultSet data = query.executeQuery();

    if (data.next()) {
      String userIdx = data.getString("idx");
      String userPassword = data.getString("password");

      if (password.equals(userPassword)) {
        loginSucceeded = true;
        //session.setAttribute("idx", userIdx);
      }
      else {
        loginSucceeded = false;
      }
    }
    else {
      loginSucceeded = false;
    }
  }
%>

<script>
  const loginSucceeded = <%=loginSucceeded %>;
  if (loginSucceeded) {
    location.href = "/stageus-planner/pages/planner.jsp";
  }
  else {
    alert('잘못된 로그인 정보입니다.');
    history.back();
  }
</script>