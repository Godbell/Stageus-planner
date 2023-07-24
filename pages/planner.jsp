<%@ page language="java" contentType="text/html" pageEncoding="utf-8" buffer="1000kb"%>

<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Planner</title>

    <link rel="shortcut icon" type="image/x-icon" href="/stageus-planner/favicon.png"/>
    <link rel="stylesheet" href="/stageus-planner/styles/general.css" />
    <link rel="stylesheet" href="/stageus-planner/styles/planner.css" />
  </head>
  <body>
    <div class="logo-area">
      <div class="logo-area-section">
        <a href="/stageus-planner" class="logo">
          <img src="/stageus-planner/imgs/Stageus Logo.png" />
        </a>
        <a class="new-plan-button">새 일정</a>
      </div>
      <button id="nav-button" class="hamburger-button">
        <img src="/stageus-planner/icons/planner_hamburger.svg">
      </button>
    </div>
    <div class="filter-menu">
      <div class="filter-area">
        <a id="year-decrease-button" class="year-modifier-button">
          <img src="/stageus-planner/icons/planner_year_decrease.svg">
        </a>
        <div id="year-selector" class="filter-menu-selector">
          <span id="year-selector-text" class="filter-menu-selector-text">
          </span>
          <svg
            width="15"
            height="9"
            viewBox="0 0 15 9"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path d="M1.5 1L7.5 7L13.5 1" stroke="white" stroke-width="2" />
          </svg>
        </div>
        <span class="filter-menu-label">년</span>
        <a id="year-increase-button" class="year-modifier-button">
          <img src="/stageus-planner/icons/planner_year_increase.svg">
        </a>
        <div id="year-modal-selectbox" class="modal-selectbox">
          <button
            id="year-modal-selectbox-left-scroll-button"
            class="year-modal-selectbox-scroll-button"
          >
            <
          </button>
          <button
            id="year-modal-selectbox-right-scroll-button"
            class="year-modal-selectbox-scroll-button"
          >
            >
          </button>
        </div>
      </div>
      <div class="filter-area">
        <div id="month-selector" class="filter-menu-selector">
          <span id="month-selector-text" class="filter-menu-selector-text">
          </span>
          <svg
            width="15"
            height="9"
            viewBox="0 0 15 9"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path d="M1.5 1L7.5 7L13.5 1" stroke="white" stroke-width="2" />
          </svg>
        </div>
        <span class="filter-menu-label">월</span>
        <div id="month-modal-selectbox" class="modal-selectbox">
          <a class="modal-selectbox-item modal-selectbox-item-selected">01</a>
          <a class="modal-selectbox-item">02</a>
          <a class="modal-selectbox-item">03</a>
          <a class="modal-selectbox-item">04</a>
          <a class="modal-selectbox-item">05</a>
          <a class="modal-selectbox-item">06</a>
          <a class="modal-selectbox-item">07</a>
          <a class="modal-selectbox-item">08</a>
          <a class="modal-selectbox-item">09</a>
          <a class="modal-selectbox-item">10</a>
          <a class="modal-selectbox-item">11</a>
          <a class="modal-selectbox-item">12</a>
        </div>
      </div>
    </div>
    <main></main>
    <nav>
      <div class="nav-menu">
        <div class="nav-menu-profile">
          <h1>내 정보</h1>
          <div class="nav-menu-profile-row">
            <span class="nav-menu-profile-row-label">메일</span>
            <span id="profile-mail" class="nav-menu-profile-row-value"></span>
          </div>
          <div class="nav-menu-profile-row">
            <span class="nav-menu-profile-row-label">이름</span>
            <span id="profile-name" class="nav-menu-profile-row-value"></span>
          </div>
          <div class="nav-menu-profile-row">
            <span class="nav-menu-profile-row-label">전화번호</span>
            <span id="profile-tel" class="nav-menu-profile-row-value"></span>
          </div>
          <div class="nav-menu-profile-row">
            <span class="nav-menu-profile-row-label">직급</span>
            <span id="profile-position" class="nav-menu-profile-row-value"></span>
          </div>
        </div>
        <div class="nav-menu-signout-button">로그아웃</div>
      </div>
    </nav>
  </body>
  <script src="/stageus-planner/scripts/plan.js"></script>
  <script>
    const getURLParam = (paramNameToFind) => {
      // ...://location/to/the/page ? paramNameToFind=value&other=value
      const queryString = window.location.href.split('?')[1];
      if (queryString === undefined) return undefined;

      // paramNameToFind=value & other=value
      const params = queryString.split('&');

      for (let param of params) {
        // paramNameToFind = value
        const paramName = param.split('=')[0];
        const paramValue = param.split('=')[1];

        if (paramName == paramNameToFind) return paramValue;
      }

      return undefined;
    };

    // date filter init
    const dateNow = new Date(Date.now());
    const filterYear = String(getURLParam('year') ?? dateNow.getFullYear());
    const filterMonth =
      getURLParam('month')?.padStart(2, '0') ??
      String(dateNow.getMonth() + 1).padStart(2, '0');

    const yearText = document.getElementById('year-selector-text');
    yearText.innerHTML = filterYear;
    const monthText = document.getElementById('month-selector-text');
    monthText.innerHTML = filterMonth;

    // year filter
    const yearSelectButton = document.getElementById('year-selector');
    const yearModalSelectBox = document.getElementById('year-modal-selectbox');
    yearModalSelectBox.style.display = 'none';

    const showYearModalSelectBox = () => {
      yearModalSelectBox.style.display = '';
      const contentItems = document.getElementsByClassName(
        'year-modal-selectbox-content'
      );
      Array.from(contentItems).forEach((item) => {
        item.style.display = '';
      });
      yearSelectButton.removeEventListener('click', showYearModalSelectBox);
      yearSelectButton.addEventListener('click', hideYearModalSelectBox);
      hideMonthModalSelectBox();
    };
    const hideYearModalSelectBox = () => {
      yearModalSelectBox.style.display = 'none';
      const contentItems = document.getElementsByClassName(
        'year-modal-selectbox-content'
      );
      Array.from(contentItems).forEach((item) => {
        item.style.display = 'none';
      });
      yearSelectButton.removeEventListener('click', hideYearModalSelectBox);
      yearSelectButton.addEventListener('click', showYearModalSelectBox);
    };
    yearSelectButton.addEventListener('click', showYearModalSelectBox);

    // year filter modifier buttons
    const yearDecreaseButton = document.getElementById('year-decrease-button');
    yearDecreaseButton.href = `/stageus-planner/pages/planner.jsp?year=\${
      Number(filterYear) - 1
    }&month=\${filterMonth}`;
    const yearIncreaseButton = document.getElementById('year-increase-button');
    yearIncreaseButton.href = `/stageus-planner/pages/planner.jsp?year=\${
      Number(filterYear) + 1
    }&month=\${filterMonth}`;

    // year filter content
    let currentYearModalSelectBoxIndex = 0;
    let yearModalSeletBoxContents = {};
    const createYearModalSelectBoxContent = (yearStart, index) => {
      const contentPosition = `\${20 + 236 * index}px`;
      const yearModalSelectBoxContent = document.createElement('div');
      yearModalSelectBoxContent.classList.add('year-modal-selectbox-content');
      yearModalSelectBoxContent.style.left = contentPosition;
      for (let year = yearStart; year < yearStart + 16; year++) {
        const yearButton = document.createElement('a');
        yearButton.classList.add('modal-selectbox-item');
        yearButton.innerHTML = String(year);
        yearButton.href = `/stageus-planner/pages/planner.jsp?year=\${yearButton.innerText}&month=\${filterMonth}`;
        if (year === Number(filterYear)) {
          yearButton.classList.add('modal-selectbox-item-selected');
        }
        // yearButton.href = `/planner.jsp?year=\${year}&month=\${filterMonth}
        yearModalSelectBoxContent.appendChild(yearButton);
      }
      yearModalSeletBoxContents[index] = yearModalSelectBoxContent;

      return yearModalSelectBoxContent;
    };

    for (let i = -5; i < 6; i++) {
      yearModalSelectBox.appendChild(
        createYearModalSelectBoxContent(Number(filterYear) + 16 * i, i)
      );
    }

    // year filter transition
    const yearFilterLeftScrollButton = document.getElementById(
      'year-modal-selectbox-left-scroll-button'
    );
    yearFilterLeftScrollButton.addEventListener('click', () => {
      if (
        yearModalSeletBoxContents[currentYearModalSelectBoxIndex - 1] !==
        undefined
      ) {
        currentYearModalSelectBoxIndex--;
        for (let index of Object.keys(yearModalSeletBoxContents)) {
          yearModalSeletBoxContents[index].style.left = `\${
            20 + 236 * (index - currentYearModalSelectBoxIndex)
          }px`;
        }
      }
    });
    const yearFilterRightScrollButton = document.getElementById(
      'year-modal-selectbox-right-scroll-button'
    );
    yearFilterRightScrollButton.addEventListener('click', () => {
      if (
        yearModalSeletBoxContents[currentYearModalSelectBoxIndex + 1] !==
        undefined
      ) {
        currentYearModalSelectBoxIndex++;
        for (let index of Object.keys(yearModalSeletBoxContents)) {
          yearModalSeletBoxContents[index].style.left = `\${
            20 + 236 * (index - currentYearModalSelectBoxIndex)
          }px`;
        }
      }
    });

    // month filter
    const monthSelectButton = document.getElementById('month-selector');
    const monthModalSelectBox = document.getElementById(
      'month-modal-selectbox'
    );
    monthModalSelectBox.style.display = 'none';

    const showMonthModalSelectBox = () => {
      monthModalSelectBox.style.display = '';
      monthSelectButton.removeEventListener('click', showMonthModalSelectBox);
      monthSelectButton.addEventListener('click', hideMonthModalSelectBox);
      hideYearModalSelectBox();
    };
    const hideMonthModalSelectBox = () => {
      monthModalSelectBox.style.display = 'none';
      monthSelectButton.removeEventListener('click', hideMonthModalSelectBox);
      monthSelectButton.addEventListener('click', showMonthModalSelectBox);
    };
    monthSelectButton.addEventListener('click', showMonthModalSelectBox);

    const monthButtons = Array.from(
      document.querySelectorAll(
        '#month-modal-selectbox > .modal-selectbox-item'
      )
    );
    monthButtons.forEach((monthButton) => {
      monthButton.href = `/stageus-planner/pages/planner.jsp?year=\${filterYear}&month=\${monthButton.innerText}`;
    });

    // nav
    const nav = document.getElementsByTagName('nav')[0];
    nav.style.display = 'none';
    const navButton = document.getElementById('nav-button');

    const showNav = () => {
      nav.style.display = '';
      navButton.removeEventListener('click', showNav);
      navButton.addEventListener('click', hideNav);
    };
    const hideNav = () => {
      nav.style.display = 'none';
      navButton.removeEventListener('click', hideNav);
      navButton.addEventListener('click', showNav);
    };
    navButton.addEventListener('click', showNav);

    const initProfile = (mail, name, tel, position) => {
      document.getElementById('profile-mail').innerHTML = mail;
      document.getElementById('profile-name').innerHTML = name;
      document.getElementById('profile-tel').innerHTML = tel;
      document.getElementById('profile-position').innerHTML = position;
    }

    const createMemberLink = (memberId, mail, name) => {
      const memberLink = document.createElement('a');
      memberLink.classList.add('nav-menu-member-button');
      memberLink.href = `/stageus-planner/pages/planner.jsp?view-member=\${memberId}`;
      memberLink.innerHTML = `\${name} (\${mail})`;

      return memberLink;
    }

    const createMemberList = () => {
      const memberList = document.createElement('div');
      memberList.classList.add('nav-menu-member-list');

      const title = document.createElement('h1');
      title.innerHTML = '직원 목록';
      memberList.appendChild(title);

      const contentArea = document.createElement('div');
      contentArea.id = 'nav-member-list-content';
      contentArea.classList.add('nav-menu-member-list-content');
      memberList.appendChild(contentArea);

      return memberList;
    }
  </script>
  <script>
    // dummy
    initProfile('example@example.com', '스어스', '01012341234', '팀장');

    const mainContent = document.getElementsByTagName('main')[0];
    for (let i = 1; i <= 31; i++) {
      const daySection = createDaySection(`2023-07-\${String(i).padStart(2, '0')}`)
      for (let j = 0; j < 5 ; j++) {
        const plan = createPlan('id', `2023-07-\${String(i).padStart(2, '0')} 23:\${String(j).padStart(2, '0')}`, 'content');
        daySection.appendChild(plan);
      }
      mainContent.appendChild(daySection);
    }

    const navMenu = document.querySelector('nav > div');
    const navMemberList = createMemberList();
    for (let i = 0; i < 10; i++) {
      const memberLink = createMemberLink('1', '직원', 'mail@mail.com');
      navMemberList.querySelector('#nav-member-list-content').appendChild(memberLink);
    }
    navMenu.insertBefore(navMemberList, navMenu.childNodes[navMenu.childNodes.length - 2]);

  </script>
</html>
