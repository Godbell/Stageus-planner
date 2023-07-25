<%@ page language="java" pageEncoding="utf-8" %>

<%@ page import="java.util.*" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%!
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

  String idx = (String)session.getAttribute("password-reset-user-idx");
  session.setAttribute("password-reset-user-idx", null);
  session.setMaxInactiveInterval(0);

  String password = request.getParameter("password");

  boolean isUpdateSucceeded = false;
  String message = "\"no message specified\"";

  // connect to db
  Class.forName("com.mysql.jdbc.Driver");
  Connection connect = DriverManager.getConnection(
    "jdbc:mysql://localhost/planner",
    "stageus",
    "stageus"
  );

  boolean isUpdateInfoValid = 
    idx != null
    && isPasswordValid(password);

  if (isUpdateInfoValid) {
    try {
      String sql
       = "UPDATE user SET password=? WHERE idx=?";
      PreparedStatement query = connect.prepareStatement(sql); 
      query.setString(1, password);
      query.setString(2, idx);

      query.executeUpdate();
      isUpdateSucceeded = true;
    }
    catch (Exception e) {
      isUpdateSucceeded = false;
      message = "\'" + e.getMessage() + "\'";
    }
  }
  else {
    message = "\'invalid input\'";
    isUpdateSucceeded = false;
  }
%>

<script>
  const isUpdateSucceeded = <%=isUpdateSucceeded %>;
  const message = <%=message %>;
  if (isUpdateSucceeded) {
    alert('비밀번호가 성공적으로 변경되었습니다.')
    location.href = '/stageus-planner';
  }
  else {
    alert('문제가 발생했습니다. 다시 시도해 주세요.');
    location.href = '/stageus-planner/pages/reset-password-check-user.jsp';
  }
</script>