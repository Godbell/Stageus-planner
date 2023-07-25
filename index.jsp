<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Stageus Planner</title>

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
      <h1>로그인</h1>
      <form 
        class="login-form"
        onsubmit="return validateForm();"
        action="/stageus-planner/actions/signin.jsp"
        method="post"
      >
        <div>
          <div class="form-row">
            <div class="form-row-label-area">
              <span class="form-row-label">메일</span>
              <span id="mail-notice" class="form-row-label-notice"></span>
            </div>
            <div class="form-row-input-area">
              <input
                id="mail-input"
                class="text-input"
                type="text"
                name="mail"
                placeholder="example@example.com"
                onchange="validateMail()"
              />
            </div>
          </div>
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
        </div>
        <input type="submit" value="로그인" />
      </form>
      <div class="signin-data-find-area">
        <div class="signin-data-find-row">
          <span>계정이 없으신가요?</span>
        </div>
        <div class="signin-data-find-row">
          <a href="/stageus-planner/pages/signup.jsp">회원가입</a>
        </div>
        <div class="signin-data-find-row">
          <span>로그인 정보가 기억나지 않나요?</span>
        </div>
        <div class="signin-data-find-row">
          <a href="/stageus-planner/pages/find-mail.jsp">메일 찾기</a>
          <a href="/stageus-planner/pages/find-password.jsp">비밀번호 초기화</a>
        </div>
      </div>
    </div>
  </body>
  <script src="/stageus-planner/scripts/signform.js"></script>
  <script>
    let validations = {
      mail: false,
      password: false,
    };

    const validateForm = () => {
      let result = true;

      validateMail();
      validatePassword();

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
