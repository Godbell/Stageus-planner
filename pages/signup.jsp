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

    const validateMail = () => {
      removeInputNotice('mail');
      validations.mailDupChecked = false;

      const validationResult = isMailValid(
        document.getElementById('mail-input').value
      );
      validations.mail = validationResult.isValid;
      if (validationResult.isValid === false) {
        showInputWarning('mail', validationResult.message);
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

    const validatePhoneNumber = () => {
      removeInputNotice('phone-number');
      validations.phoneNumberDupChecked = false;

      const validationResult = isPhoneNumberValid(
        document.getElementById('phone-number-input').value
      );
      validations.phoneNumber = validationResult.isValid;
      if (validationResult.isValid === false) {
        showInputWarning('phone-number', validationResult.message);
      }
    };

    const validatePassword = () => {
      removeInputNotice('password');
      validations.passwordConfirm = false;

      const validationResult = isPasswordValid(
        document.getElementById('password-input').value
      );
      validations.password = validationResult.isValid;
      if (validationResult.isValid === false) {
        showInputWarning('password', validationResult.message);
      }
    };

    const validatePasswordConfirm = () => {
      removeInputNotice('password-confirm');

      const validationResult = isPasswordConfirmValid(
        document.getElementById('password-input').value,
        document.getElementById('password-confirm-input').value
      );
      validations.passwordConfirm = validationResult.isValid;
      if (validationResult.isValid === false) {
        showInputWarning('password-confirm', validationResult.message);
      }
    };

    const showInputWarning = (inputSubject, message) => {
      const inputElement = document.getElementById(`${inputSubject}-input`);
      const noticeElement = document.getElementById(`${inputSubject}-notice`);

      inputElement.classList.add('input-warning');
      noticeElement.classList.add('notice-warning');
      noticeElement.innerHTML = message;
    };

    const showInputAllowance = (inputSubject, message) => {
      const inputElement = document.getElementById(`${inputSubject}-input`);
      const noticeElement = document.getElementById(`${inputSubject}-notice`);

      inputElement.classList.add('input-accepted');
      noticeElement.classList.add('notice-accepted');
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

    const checkMailDuplication = () => {
      // check code here

      validateMail();
      if (validations.mail === true) {
        validations.mailDupChecked = true;
        showInputAllowance('mail', '사용할 수 있는 메일 주소입니다.');
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

    const checkPhoneNumberDuplication = () => {
      // check code here

      validatePhoneNumber();
      if (validations.phoneNumber == true) {
        validations.phoneNumberDupChecked = true;
        showInputAllowance('phone-number', '사용할 수 있는 전화번호입니다.');
      }
    };

    const isPasswordValid = (password) => {
      const regex = new RegExp('^[ -~]+$');

      if (password.length == 0) {
        return {
          isValid: false,
          message: '비밀번호를 입력해 주세요.',
        };
      } else if (password.length < 8 || password.length > 20) {
        return {
          isValid: false,
          message: '비밀번호는 최소 8자, 최대 20자까지 가능합니다.',
        };
      } else if (!regex.test(password)) {
        return {
          isValid: false,
          message: '영문, 숫자, 특수문자만 사용 가능합니다.',
        };
      } else {
        return {
          isValid: true,
        };
      }
    };

    const isPasswordConfirmValid = (password, passwordConfirm) => {
      if (passwordConfirm !== password) {
        return {
          isValid: false,
          message: '비밀번호가 다릅니다.',
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

      if (validations.mailDupChecked === false) {
        showInputWarning('mail', '중복체크를 실행해 주세요.');
        result = false;
      }
      if (validations.phoneNumberDupChecked === false) {
        showInputWarning('phone-number', '중복체크를 실행해 주세요.');
        result = false;
      }

      validateMail();
      validateName();
      validatePhoneNumber();
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