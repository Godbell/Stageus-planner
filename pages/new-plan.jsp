<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Plan</title>
  
    <link rel="shortcut icon" type="image/x-icon" href="/stageus-planner/favicon.png"/>
    <link rel="stylesheet" href="/stageus-planner/styles/general.css">
    <link rel="stylesheet" href="/stageus-planner/styles/planform.css">
  </head>
  <body>o
    <form
      onsubmit="return validateForm();"
      action="/stageus-planner/actions/new-plan.jsp"
      method="post"
    >
      <div class="form-row">
        <input type="date" name="date" class="form-text" onchange="validateDate()">
        <input type="time" name="time" class="form-text" onchange="validateTime()">
      </div>
      <span class="content-label form-text">내용</span>
      <textarea name="content" class="form-rect" oninput="validateContent()"></textarea>
      <input type="submit" value="등록" class="form-rect form-text">
    </form>

    <script src="/stageus-planner/scripts/planform.js"></script>
  </body>
</html>