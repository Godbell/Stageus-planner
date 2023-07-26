<%@ page language="java" pageEncoding="utf-8" %>

<%
  session.setAttribute("idx", null);
  session.setMaxInactiveInterval(0);
  response.sendRedirect("/stageus-planner");
%>