const dayNames = ['일', '월', '화', '수', '목', '금', '토', '일'];

const createPlanTime = (datetime) => {
  const planTime = document.createElement('span');
  planTime.classList.add('plan-time');

  const datetimeString =
    String(new Date(datetime).getHours()).padStart(2, '0') +
    ':' +
    String(new Date(datetime).getMinutes()).padStart(2, '0');
  planTime.innerHTML = datetimeString;

  return planTime;
};

const createPlanContent = (content) => {
  const planContent = document.createElement('span');
  planContent.classList.add('plan-content');
  planContent.innerHTML = content;

  return planContent;
};

const createPlanButtonImage = (width, height, pathD) => {
  const planEditButtonImage = document.createElement('svg');
  planEditButtonImage.width = width;
  planEditButtonImage.height = height;
  planEditButtonImage.viewBox = `0 0 ${width} ${height}`;
  planEditButtonImage.fill = 'none';

  const planEditButtonImagePath = document.createElement('path');
  planEditButtonImagePath.d = pathD;
  planEditButtonImagePath.strokeWidth = '2';

  planEditButtonImage.appendChild(planEditButtonImagePath);
  return planEditButtonImage;
};

const createPlanEditButton = () => {
  const planEditButton = document.createElement('button');
  planEditButton.classList.add('plan-button');
  planEditButton.appendChild(
    createPlanButtonImage('25', '26', 'M23.5 7L19 2L1 20V24.5H6L23.5 7Z')
  );
  return planEditButton;
};

const createPlanDeleteButton = () => {
  const planEditButton = document.createElement('button');
  planEditButton.classList.add('plan-button');
  planEditButton.appendChild(
    createPlanButtonImage('25', '26', 'M1 1L25 25M25 1L1 25')
  );
  return planEditButton;
};

const createPlan = (planId, datetime, content) => {
  const plan = document.createElement('article');
  plan.dataset.planId = planId;
  plan.appendChild(createPlanTime(datetime));
  plan.appendChild(createPlanContent(content));
  plan.appendChild(createPlanEditButton());
  plan.appendChild(createPlanDeleteButton());

  const planDate = new Date(datetime);
  if (new Date(Date.now()) > planDate) {
    plan.classList.add('past-plan');
  }

  return plan;
};

const createDaySection = (datetime) => {
  const day = new Date(datetime).getDate();
  const dayName = dayNames[new Date(datetime).getDay()];

  const daySection = document.createElement('section');
  daySection.dataset.day = `${day}`;

  const labelArea = document.createElement('div');
  labelArea.classList.add('label-area');
  daySection.appendChild(labelArea);

  const dayLabel = document.createElement('span');
  dayLabel.classList.add('day-label');
  dayLabel.innerHTML = `${day}`;
  labelArea.appendChild(dayLabel);

  const dayNameLabel = document.createElement('span');
  dayNameLabel.classList.add('day-name-label');
  dayNameLabel.innerHTML = `(${dayName})`;
  labelArea.appendChild(dayNameLabel);

  return daySection;
};
