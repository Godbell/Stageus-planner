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
  <body>
    <form>
      <div class="form-row">
        <input type="date" name="date" class="form-text">
        <input type="time" name="time" class="form-text">
      </div>
      <span class="content-label form-text">내용</span>
      <textarea name="content" class="form-rect"></textarea>
      <input type="submit" value="등록" class="form-rect form-text">
    </form>
  </body>
</html>