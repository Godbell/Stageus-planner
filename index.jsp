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
      <form class="login-form" onsubmit="return validateForm();">
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
  <script>
    let validations = {
      mail: false,
      password: false,
    };

    const showInputWarning = (inputSubject, message) => {
      const inputElement = document.getElementById(`${inputSubject}-input`);
      const noticeElement = document.getElementById(`${inputSubject}-notice`);

      inputElement.classList.add('input-warning');
      noticeElement.classList.add('notice-warning');
      noticeElement.innerHTML = message;
    };

    const removeInputNotice = (inputSubject) => {
      const inputElement = document.getElementById(`${inputSubject}-input`);
      const noticeElement = document.getElementById(`${inputSubject}-notice`);

      inputElement.classList.remove('input-warning');
      inputElement.classList.remove('input-accepted');
      noticeElement.classList.remove('notice-warning');
      noticeElement.classList.remove('notice-accepted');
      noticeElement.innerHTML = '';
    };

    const validateMail = () => {
      removeInputNotice('mail');

      const validationResult = isMailValid(
        document.getElementById('mail-input').value
      );
      validations.mail = validationResult.isValid;
      if (validationResult.isValid === false) {
        showInputWarning('mail', validationResult.message);
      }
    };

    const isMailValid = (mail) => {
      const address = mail.split('@')[0] ?? '';
      const domain = mail.split('@')[1] ?? '';

      const regex = new RegExp(
        '^[a-zA-Z0-9+-_.]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$'
      );
      if (mail.length == 0) {
        return {
          isValid: false,
          message: '메일 주소를 입력해 주세요.',
        };
      } else if (address.length > 64 || domain.length > 255) {
        return {
          isValid: false,
          message: '메일 주소가 너무 깁니다.',
        };
      } else if (!regex.test(mail)) {
        return {
          isValid: false,
          message: '메일 주소는 example@example.com 형식이어야 합니다.',
        };
      } else {
        return {
          isValid: true,
        };
      }
    };

    const validatePassword = () => {
      removeInputNotice('password');

      const validationResult = isPasswordValid(
        document.getElementById('password-input').value
      );
      validations.password = validationResult.isValid;
      if (validationResult.isValid === false) {
        showInputWarning('password', validationResult.message);
      }
    };

    const isPasswordValid = (password) => {
      const regex = new RegExp('^[ -~]+$');

      if (password.length == 0) {
        return {
          isValid: false,
          message: '비밀번호를 입력해 주세요.',
        };
      } else {
        return {
          isValid: true,
        };
      }
    };

    const validateForm = () => {
      event.preventDefault();
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