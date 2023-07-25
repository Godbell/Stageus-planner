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
    if (password == null) {
      return false;
    }
    else if (password.length() > 20 || password.length() < 8) {
      return false;
    }
    else if (!password.matches("^[ -~]+$")) {
      return false;
    }
    else return true;
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

  public boolean isPositionValid(String position) {
    if (position == null) {
      return false;
    }
    else if (!position.equals("팀장") && !position.equals("직원")) {
      return false;
    }
    else return true;
  }

  interface UniqueCheck {
    boolean method(Connection connection, String checkedString) throws Exception;
  }
%>

<%
  request.setCharacterEncoding("utf-8");
  String mail = request.getParameter("mail");
  String name = request.getParameter("name");
  String tel = request.getParameter("phone-number");
  String password = request.getParameter("password");
  String position = request.getParameter("position");

  boolean isSignupSucceeded = false;
  String message = "\"no message specified\"";

  // connect to db
  Class.forName("com.mysql.jdbc.Driver");
  Connection connect = DriverManager.getConnection(
    "jdbc:mysql://localhost/planner",
    "stageus",
    "stageus"
  );

  UniqueCheck isMailUnique = new UniqueCheck() {
    public boolean method(Connection connection, String checkedString) throws Exception {
      String sql = "SELECT count(*) as cnt FROM user WHERE mail=?;";
      PreparedStatement query = connection.prepareStatement(sql); 
      query.setString(1, checkedString);

      ResultSet data = query.executeQuery();

      if (data.next()) {
        int mailCount = data.getInt("cnt");
        if (mailCount == 0) {
          return true;
        }
        else {
          return false;
        }
      }
      return false;
    }
  };

  UniqueCheck isTelUnique = new UniqueCheck() {
    public boolean method(Connection connection, String checkedString) throws Exception {
      String sql = "SELECT count(*) as cnt FROM user WHERE tel=?;";
      PreparedStatement query = connection.prepareStatement(sql); 
      query.setString(1, checkedString);

      ResultSet data = query.executeQuery();

      if (data.next()) {
        int telCount = data.getInt("cnt");
        if (telCount == 0) {
          return true;
        }
        else {
          return false;
        }
      }
      return false;
    }
  };

  boolean mailUniqueCheckResult = false;
  try {
    mailUniqueCheckResult = isMailUnique.method(connect, mail);
  }
  catch (Exception e) {
    message = e.getMessage();
    mailUniqueCheckResult = false;
  }

  boolean telUniqueCheckResult = false;
  try {
    telUniqueCheckResult = isTelUnique.method(connect, tel);
  }
  catch (Exception e) {
    message = e.getMessage();
    telUniqueCheckResult = false;
  }

  boolean isSignupInfoValid = 
    isMailValid(mail)
    && isNameValid(name)
    && isTelValid(tel)
    && isPasswordValid(password)
    && isPositionValid(position)
    && mailUniqueCheckResult == true
    && telUniqueCheckResult == true;

  if (isSignupInfoValid) {
    try {
      String sql
       = "INSERT INTO user (mail, name, tel, password, position) VALUES (?, ?, ?, ?, ?);";
      PreparedStatement query = connect.prepareStatement(sql); 
      query.setString(1, mail);
      query.setString(2, name);
      query.setString(3, tel);
      query.setString(4, password);
      query.setString(5, position);

      query.executeUpdate();
      isSignupSucceeded = true;
    }
    catch (Exception e) {
      isSignupSucceeded = false;
      message = "\'" + e.getMessage() + "\'";
    }
  }
  else {
    message = "\'invalid input\'";
    isSignupSucceeded = false;
  }
%>

<script>
  const isSignupSucceeded = <%=isSignupSucceeded %>;
  const message = <%=message %>;
  if (isSignupSucceeded) {
    alert('성공적으로 가입 완료하였습니다.');
    location.href = '/stageus-planner';
  }
  else {
    alert(`가입에 실패했습니다. message: <%=message %>`);
  }
</script>