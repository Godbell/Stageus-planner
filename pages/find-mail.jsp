<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Find Mail</title>

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
      <h1>메일 찾기</h1>
      <form 
        class="login-form"
        onsubmit="return validateForm();"
        action="/stageus-planner/actions/find-mail.jsp"
        method="post"
      >
        <div>
          <div class="form-row">
            <div class="form-row-label-area">
              <span class="form-row-label">이름</span>
              <span id="name-notice" class="form-row-label-notice"></span>
            </div>
            <div class="form-row-input-area">
              <input
                id="name-input"
                class="text-input"
                type="text"
                name="name"
                placeholder="김종하"
                onchange="validateName()"
              />
            </div>
          </div>
          <div class="form-row">
            <div class="form-row-label-area">
              <span class="form-row-label">전화번호</span>
              <span
                id="phone-number-notice"
                class="form-row-label-notice"
              ></span>
            </div>
            <div class="form-row-input-area">
              <input
                id="phone-number-input"
                type="text"
                name="phone-number"
                class="text-input"
                placeholder="01012341234"
                onchange="validatePhoneNumber()"
              />
            </div>
          </div>
        </div>
        <input type="submit" value="찾기" />
      </form>
    </div>
  </body>
  <script src="/stageus-planner/scripts/signform.js"></script>
  <script>
    let validations = {
      name: false,
      phoneNumber: false,
    };

    const validateForm = () => {
      let result = true;

      validateName();
      validatePhoneNumber();

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