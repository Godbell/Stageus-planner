<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<%
  boolean isValidAccess = false;

  if ((String)session.getAttribute("password-reset-user-idx") != null) {
    isValidAccess = true;
  }
%>

<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Check User</title>

    <link rel="shortcut icon" type="image/x-icon" href="/stageus-planner/favicon.png"/>
    <link rel="stylesheet" href="/stageus-planner/styles/general.css" />
    <link rel="stylesheet" href="/stageus-planner/styles/signform.css" />
  </head>
  <body>
    <div class="logo-area">
      <a href="/stageus-planner">
        <img src="/stageus-planner/imgs/Stageus Logo.png" />
      </a>
    </div>
    <div class="form-area">
      <h1>비밀번호 초기화</h1>
      <form 
        class="login-form"
        onsubmit="return validateForm();"
        action="/stageus-planner/actions/reset-password.jsp"
        method="post"
      >
        <div>
          <div class="form-row">
            <div class="form-row-label-area">
              <span class="form-row-label">비밀번호</span>
              <span id="password-notice" class="form-row-label-notice"></span>
            </div>
            <div class="form-row-input-area">
              <input
                id="password-input"
                type="password"
                name="password"
                class="text-input"
                placeholder="********"
                onchange="validatePassword()"
              />
            </div>
          </div>
          <div class="form-row">
            <div class="form-row-label-area">
              <span class="form-row-label">비밀번호 확인</span>
              <span
                id="password-confirm-notice"
                class="form-row-label-notice"
              ></span>
            </div>
            <div class="form-row-input-area">
              <input
                id="password-confirm-input"
                type="password"
                name="password-confirm"
                class="text-input"
                placeholder="********"
                onchange="validatePasswordConfirm()"
              />
            </div>
          </div>
        </div>
        <input type="submit" value="변경" />
      </form>
    </div>
  </body>
  <script src="/stageus-planner/scripts/signform.js"></script>
  <script>
    const isValidAccess = <%=isValidAccess %>;

    if (!isValidAccess) {
      alert('잘못된 접근입니다.');
      location.href = '/stageus-planner';
    }

    let validations = {
      password: false,
      passwordConfirm: false,
    };

    const validateForm = () => {
      let result = true;

      validatePassword();
      validatePasswordConfirm();

      if (
        Object.values(validations).filter(
          (validationResult) => validationResult === false
        ).length > 0
      ) {
        result = false;
      }

      return result;
    };
  </script>
</html>
