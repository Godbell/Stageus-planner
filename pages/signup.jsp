<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Sign Up</title>

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
      <h1>회원가입</h1>
      <form class="login-form" method="post" onsubmit="return validateForm();">
        <div>
          <div class="form-row">
            <div class="form-row-label-area">
              <span class="form-row-label">메일</span>
              <span id="mail-notice" class="form-row-label-notice"></span>
            </div>
            <div class="form-row-input-area">
              <input
                id="mail-input"
                type="text"
                name="mail"
                placeholder="example@example.com"
                class="text-input"
                onchange="validateMail()"
              />
              <button
                class="dup-check-button"
                type="button"
                onclick="checkMailDuplication()"
              >
                중복확인
              </button>
            </div>
          </div>
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
                placeholder=""
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
              <button
                class="dup-check-button"
                type="button"
                onclick="checkPhoneNumberDuplication()"
              >
                중복확인
              </button>
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
                name="password"
                class="text-input"
                placeholder="********"
                onchange="validatePasswordConfirm()"
              />
            </div>
          </div>
        </div>
        <input type="submit" value="가입하기" />
      </form>
    </div>
  </body>
  <script src="/stageus-planner/scripts/signform.js"></script>
  <script>
    let validations = {
      mail: false,
      mailDupChecked: false,
      name: false,
      phoneNumber: false,
      phoneNumberDupChecked: false,
      password: false,
      passwordConfirm: false,
    };

    const checkMailDuplication = () => {
      validateMail();
      if (validations.mail === false) return;

      const mail = document.getElementById('mail-input').value;
      fetch(`/stageus-planner/actions/checkMailDuplication.jsp?mail=\${mail}`)
        .then((res) => res.text())
        .then((text) => text.trim())
        .then((text) => {
          switch (text) {
            case 'MAIL_VALID':
              validations.mailDupChecked = true;
              showInputAllowance('mail', '사용할 수 있는 메일 주소입니다.');
              break;
            case 'MAIL_DUPLICATE':
              validations.mailDupChecked = false;
              showInputWarning('mail', '이미 사용중인 메일 주소입니다.');
              break;
            case 'MAIL_INVALID':
              validations.mailDupChecked = false;
              showInputWarning('mail', '유효하지 않은 메일 주소입니다.');
              break;
            default:
              alert('잘못된 요청입니다.');
          }
        });
    };

    const validateForm = () => {
      let result = true;

      validateMail();
      if (validations.mailDupChecked === false) {
        showInputWarning('mail', '중복체크를 실행해 주세요.');
        result = false;
      }

      validatePhoneNumber();
      if (validations.phoneNumberDupChecked === false) {
        showInputWarning('phone-number', '중복체크를 실행해 주세요.');
        result = false;
      }

      validateName();
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
