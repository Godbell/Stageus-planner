const validations = {
  date: false,
  time: false,
  content: false,
};

const validateDate = () => {
  const regex = /\d\d\d\d\-\d\d-\d\d/;

  const dateValue = document.forms[0].date.value;
  if (
    dateValue !== null &&
    dateValue !== undefined &&
    dateValue.length > 0 &&
    regex.test(dateValue)
  ) {
    validations.date = true;
  } else {
    validations.date = false;
  }
};

const validateTime = () => {
  const regex = /\d\d\:\d\d/;

  const timeValue = document.forms[0].time.value;
  if (
    timeValue !== null &&
    timeValue !== undefined &&
    timeValue.length > 0 &&
    regex.test(timeValue)
  ) {
    validations.time = true;
  } else {
    validations.time = false;
  }
};

const validateContent = () => {
  const regex = /^[ -~\r\n]+/;

  const contentValue = document.forms[0].content.value;
  if (
    contentValue !== null &&
    contentValue !== undefined &&
    contentValue.length > 0 &&
    regex.test(contentValue)
  ) {
    validations.content = true;
  } else {
    validations.content = false;
  }
};

const validateForm = () => {
  let result = true;

  validateDate();
  validateTime();
  validateContent();

  if (
    Object.values(validations).filter(
      (validationResult) => validationResult === false
    ).length > 0
  ) {
    result = false;
    alert('날짜, 시간, 내용을 모두 입력했는지 확인해 주세요.');
  }

  return result;
};
