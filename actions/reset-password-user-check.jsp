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
  String mail = request.getParameter("mail");
  String name = request.getParameter("name");
  String tel = request.getParameter("phone-number");

  boolean isFindingSucceeded = false;
  String message = "\"no message specified\"";

  // connect to db
  Class.forName("com.mysql.jdbc.Driver");
  Connection connect = DriverManager.getConnection(
    "jdbc:mysql://localhost/planner",
    "stageus",
    "stageus"
  );

  boolean isFindingInfoValid = 
    isMailValid(mail)
    && isNameValid(name)
    && isTelValid(tel);

  if (isFindingInfoValid) {
    try {
      String sql
       = "SELECT idx FROM user WHERE mail=? AND name=? AND tel=?";
      PreparedStatement query = connect.prepareStatement(sql); 
      query.setString(1, mail);
      query.setString(2, name);
      query.setString(3, tel);

      ResultSet data = query.executeQuery();

      if (data.next()) {
        String idx = data.getString("idx");
        session.setAttribute("password-reset-user-idx", idx);
        session.setMaxInactiveInterval(1800);
        isFindingSucceeded = true;
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
    location.href = '/stageus-planner/pages/reset-password.jsp';
  }
  else {
    alert(`사용자 정보가 올바르지 않습니다.`);
  }
</script>