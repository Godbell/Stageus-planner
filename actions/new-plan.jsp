<%@ page language="java" pageEncoding="utf-8" %>

<%@ page import="java.util.*" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%!
  public boolean isDateValid(String date) {
    if (date == null) {
      return false;
    }
    else if (date.length() != 10) {
      return false;
    }
    else if (!date.matches("\\d\\d\\d\\d\\-\\d\\d\\-\\d\\d")) {
      return false;
    } else return true;
  }

  public boolean isTimeValid(String time) {
    if (time == null) {
      return false;
    }
    else if (time.length() != 5) {
      return false;
    }
    else if (!time.matches("\\d\\d\\:\\d\\d")) {
      return false;
    } else return true;
  }

  public boolean isContentValid(String content) {
    if (content == null) {
      return false;
    }
    else if (content.length() == 0) {
      return false;
    }
    else if (!content.matches("^[ -~\\r\\n]+")) {
      return false;
    } else return true;
  }
%>

<%
  request.setCharacterEncoding("utf-8");
  String userIdx = (String)session.getAttribute("idx");
  String date = request.getParameter("date");
  String time = request.getParameter("time");
  String content = request.getParameter("content");

  boolean isUploadSucceeded = false;
  String errorMessage = "no message specified";

  // connect to db
  Class.forName("com.mysql.jdbc.Driver");
  Connection connect = DriverManager.getConnection(
    "jdbc:mysql://localhost/planner",
    "stageus",
    "stageus"
  );

  boolean isUploadInfoValid = 
    userIdx != null &&
    isDateValid(date) &&
    isTimeValid(time) &&
    isContentValid(content);

  if (isUploadInfoValid) {
    try {
      String sql
        = "INSERT INTO plan (datetime, content, user_idx) VALUES (?, ?, ?);";
      PreparedStatement query = connect.prepareStatement(sql); 
      query.setString(1, date + " " + time);
      query.setString(2, content);
      query.setString(3, userIdx);

      query.executeUpdate();
      isUploadSucceeded = true;
    }
    catch (Exception e) {
      isUploadSucceeded = false;
      errorMessage = e.getMessage();
    }
  }
  else {
    isUploadSucceeded = false;
  }
%>

<script>
  const isUploadSucceeded = <%=isUploadSucceeded %>;
  const errorMessage = "<%=errorMessage %>";
  if (isUploadSucceeded) {
    alert('성공적으로 업로드하였습니다.');
  }
  else {
    alert('업로드에 실패했습니다.');
    console.log(`
      <%=userIdx != null %>
      <%=isDateValid(date) %>
      <%=isTimeValid(time) %>
      <%=isContentValid(content) %>
    `)
  }
  window.close();
</script>