<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Find Password</title>

    <link rel="shortcut icon" type="image/x-icon" href="/stageus-planner/favicon.png"/>
    <link rel="stylesheet" href="/stageus-planner/styles/general.css" />
    <link rel="stylesheet" href="/stageus-planner/styles/signform.css" />
  </head>
  <body>
    <div class="logo-area">
      <a><img src="/stageus-planner/imgs/Stageus Logo.png" /></a>
    </div>
    <div class="form-area">
      <h1>비밀번호 찾기</h1>
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
                type="text"
                name="mail"
                placeholder="example@example.com"
                class="text-input"
                onchange="validateMail()"
              />
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
  <script>
    let validations = {
      name: false,
      phoneNumber: false,
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

    const validateName = () => {
      removeInputNotice('name');
      const validationResult = isNameValid(
        document.getElementById('name-input').value
      );
      validations.name = validationResult.isValid;
      if (validationResult.isValid === false) {
        showInputWarning('name', validationResult.message);
      }
    };

    const isNameValid = (name) => {
      const regex = new RegExp('^[a-zA-Z가-힣]+$');

      if (name.length == 0) {
        return {
          isValid: false,
          message: '이름을 입력해 주세요.',
        };
      } else if (name.length > 20) {
        return {
          isValid: false,
          message: '이름은 최대 20자까지 입력 가능합니다.',
        };
      } else if (!regex.test(name)) {
        return {
          isValid: false,
          message: '영문, 한글 완성형만 입력 가능합니다.',
        };
      } else {
        return {
          isValid: true,
        };
      }
    };

    const validatePhoneNumber = () => {
      removeInputNotice('phone-number');

      const validationResult = isPhoneNumberValid(
        document.getElementById('phone-number-input').value
      );
      validations.phoneNumber = validationResult.isValid;
      if (validationResult.isValid === false) {
        showInputWarning('phone-number', validationResult.message);
      }
    };

    const isPhoneNumberValid = (phoneNumber) => {
      const regex = new RegExp('^[0-9]+$');

      if (phoneNumber.length == 0) {
        return {
          isValid: false,
          message: '전화번호를 입력해 주세요.',
        };
      } else if (!regex.test(phoneNumber)) {
        return {
          isValid: false,
          message: '하이픈(-)을 제외한 숫자만 입력해 주세요.',
        };
      } else if (phoneNumber.length < 10 || phoneNumber.length > 11) {
        return {
          isValid: false,
          message: '전화번호는 10자리 혹은 11자리만 가능합니다.',
        };
      } else {
        return {
          isValid: true,
        };
      }
    };

    const validateForm = () => {
      let result = true;

      validateMail();
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
