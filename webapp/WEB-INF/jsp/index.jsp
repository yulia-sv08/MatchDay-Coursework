<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <title>MATCHDAY | Усі матчі</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=8">
</head>
<body>

<img src="${pageContext.request.contextPath}/assets/images/leopard.png" class="leopard-bg" alt="Leopard">

<div class="sidebar">
    <div class="logo-container">
        <div style="background: var(--gold); color: black; padding: 5px 10px; border-radius: 4px;">M</div>
        MATCHDAY
    </div>

    <div class="menu-title">НАВІГАЦІЯ</div>
    <ul class="league-list" style="margin-bottom: 30px;">
        <li class="league-item nav-item active" data-status="all">
            <span style="font-size: 16px;">  </span> Усі матчі
        </li>
        <li class="league-item nav-item" data-status="live">
            <span style="font-size: 16px; color: var(--red-live);"> </span> Live матчі
        </li>
        <li class="league-item nav-item" data-status="planned">
            <span style="font-size: 16px;"> </span> Заплановані
        </li>
        <li class="league-item nav-item" data-status="finished">
            <span style="font-size: 16px;"> </span> Завершені
        </li>
        <a href="${pageContext.request.contextPath}/teams" style="text-decoration: none; color: inherit;">
            <li class="league-item">
                <span style="font-size: 16px;"> </span> Команди
            </li>
        </a>
    </ul>

    <div class="menu-title">ЛІГИ</div>
    <ul class="league-list">
        <li class="league-item" data-filter="Ліга чемпіонів">
            <img src="${pageContext.request.contextPath}/assets/images/leagues/UEFA_Champions_League_logo.png" alt=""> Ліга чемпіонів
        </li>
        <li class="league-item" data-filter="Прем'єр-ліга">
            <img src="${pageContext.request.contextPath}/assets/images/leagues/Premier-League-Logo-White-png.png" alt=""> Прем'єр-ліга
        </li>
        <li class="league-item" data-filter="Ла Ліга">
            <img src="${pageContext.request.contextPath}/assets/images/leagues/LaLiga_EA_Sports_2023_Vertical_Logo.svg" alt=""> Ла Ліга
        </li>
        <li class="league-item" data-filter="Бундесліга">
            <img src="${pageContext.request.contextPath}/assets/images/leagues/Bundesliga_logo_(2017).svg" alt=""> Бундесліга
        </li>
        <li class="league-item" data-filter="Серія А">
            <img src="${pageContext.request.contextPath}/assets/images/leagues/Serie_A_logo_2022.svg" alt=""> Серія А
        </li>
        <li class="league-item" data-filter="УПЛ">
            <img src="${pageContext.request.contextPath}/assets/images/leagues/Ukrainian_Premier_League_Logo_UK.svg" alt=""> УПЛ
        </li>
        <li class="league-item active-league" data-filter="all" style="border: 1px solid var(--gold); margin-top: 10px;">
            Усі ліги
        </li>
    </ul>
</div>

<div class="main-content">
    <div class="top-nav">
        <div style="display: flex; align-items: center; gap: 10px;">
            <input type="text" id="searchInput" class="search-bar" placeholder="Пошук команди...">
            <button id="searchBtn">Пошук</button>
        </div>

        <div class="top-links">
            <a href="${pageContext.request.contextPath}/home" style="border-bottom: 2px solid var(--gold); padding-bottom: 5px;">МАТЧІ</a>
            <a href="${pageContext.request.contextPath}/login">УВІЙТИ</a>
        </div>
    </div>

    <h1 class="page-title">РОЗКЛАД МАТЧІВ</h1>

    <div id="matchesContainer">
        <c:forEach var="match" items="${matches}">
            <div class="match-card ${match.status == 'live' ? 'live-match' : ''}" data-league="${match.tournament}" data-status="${match.status}">
                <div class="match-header">
                    <span>${match.tournament}</span>
                    <span>Стадіон: ${match.stadium}</span>
                </div>

                <div class="match-body">
                    <!-- КОМАНДА ГОСПОДАРІВ -->
                    <a href="${pageContext.request.contextPath}/team?id=${match.homeTeam.id}" class="team home" style="text-decoration: none; color: inherit; transition: 0.2s;" onmouseover="this.style.opacity='0.7'" onmouseout="this.style.opacity='1'">
                        <img src="${pageContext.request.contextPath}/assets/images/${match.homeTeam.logo}" alt="${match.homeTeam.name}">
                        <div style="display: flex; flex-direction: column; gap: 2px;">
                            <span class="team-name">${match.homeTeam.name}</span>
                            <span style="font-size: 11px; color: var(--text-muted); font-weight: 500; text-transform: uppercase;">${match.homeTeam.country}</span>
                        </div>
                    </a>

                    <!-- РАХУНОК ТА СТАТУС -->
                    <div class="score-board">
                        <c:choose>
                            <c:when test="${match.status == 'planned'}">
                                <div style="font-size: 11px; color: var(--text-muted); margin-bottom: 4px; font-weight: 500; letter-spacing: 1px;">
                                        ${match.matchDate.toString().substring(0, 10)}
                                </div>
                                <div class="score" style="font-size: 24px;">${match.matchDate.toString().substring(11, 16)}</div>
                                <div class="badge badge-planned">ЗАПЛАНОВАНО</div>
                            </c:when>
                            <c:when test="${match.status == 'live'}">
                                <div class="score"><c:choose><c:when test="${not empty resultsMap[match.id]}">${resultsMap[match.id].homeScore} : ${resultsMap[match.id].awayScore}</c:when><c:otherwise>0 : 0</c:otherwise></c:choose></div>
                                <div class="badge badge-live">• LIVE</div>
                            </c:when>
                            <c:when test="${match.status == 'finished'}">
                                <div style="font-size: 11px; color: var(--text-muted); margin-bottom: 4px; font-weight: 500; letter-spacing: 1px;">
                                        ${match.matchDate.toString().substring(0, 10)} | ${match.matchDate.toString().substring(11, 16)}
                                </div>
                                <div class="score"><c:choose><c:when test="${not empty resultsMap[match.id]}">${resultsMap[match.id].homeScore} : ${resultsMap[match.id].awayScore}</c:when><c:otherwise>- : -</c:otherwise></c:choose></div>
                                <div class="badge badge-finished">ЗАВЕРШЕНО</div>
                            </c:when>
                        </c:choose>
                    </div>

                    <!-- КОМАНДА ГОСТЕЙ -->
                    <a href="${pageContext.request.contextPath}/team?id=${match.awayTeam.id}" class="team away" style="text-decoration: none; color: inherit; transition: 0.2s;" onmouseover="this.style.opacity='0.7'" onmouseout="this.style.opacity='1'">
                        <img src="${pageContext.request.contextPath}/assets/images/${match.awayTeam.logo}" alt="${match.awayTeam.name}">
                        <div style="display: flex; flex-direction: column; gap: 2px;">
                            <span class="team-name">${match.awayTeam.name}</span>
                            <span style="font-size: 11px; color: var(--text-muted); font-weight: 500; text-transform: uppercase;">${match.awayTeam.country}</span>
                        </div>
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>

    <div id="noMatchesMsg" style="display: none; text-align: center; padding: 50px; color: var(--text-muted); font-size: 18px; border: 1px dashed rgba(220, 179, 109, 0.3); border-radius: 12px; margin-top: 20px;">
        На жаль, за вашим запитом матчів не знайдено ️
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const searchInput = document.getElementById("searchInput");
        const searchBtn = document.getElementById("searchBtn");
        const leagueButtons = document.querySelectorAll(".league-list:last-of-type .league-item"); // Тільки кнопки ліг
        const navItems = document.querySelectorAll(".nav-item"); // Навігація статусів
        const matchCards = document.querySelectorAll(".match-card");
        const noMatchesMsg = document.getElementById("noMatchesMsg");

        function filterMatches() {
            const searchText = searchInput.value.trim().toLowerCase();

            const activeLeagueBtn = document.querySelector(".league-list:last-of-type .active-league");
            const activeLeague = activeLeagueBtn ? activeLeagueBtn.getAttribute("data-filter").toLowerCase() : "all";

            const activeStatusBtn = document.querySelector(".nav-item.active");
            const activeStatus = activeStatusBtn ? activeStatusBtn.getAttribute("data-status").toLowerCase() : "all";

            let visibleCount = 0;

            matchCards.forEach(card => {
                const homeTeam = card.querySelector(".team.home .team-name").innerText.toLowerCase();
                const awayTeam = card.querySelector(".team.away .team-name").innerText.toLowerCase();
                const matchLeague = card.getAttribute("data-league").toLowerCase();
                const matchStatus = card.getAttribute("data-status").toLowerCase();

                const matchesSearch = searchText === "" || homeTeam.includes(searchText) || awayTeam.includes(searchText);
                const matchesLeague = (activeLeague === "all" || matchLeague === activeLeague);
                const matchesStatus = (activeStatus === "all" || matchStatus === activeStatus);

                if (matchesSearch && matchesLeague && matchesStatus) {
                    card.style.display = "block";
                    visibleCount++;
                } else {
                    card.style.display = "none";
                }
            });

            noMatchesMsg.style.display = visibleCount === 0 ? "block" : "none";
        }

        searchBtn.addEventListener("click", filterMatches);
        searchInput.addEventListener("keypress", (e) => { if(e.key === "Enter") filterMatches(); });

        // Кліки по лігах
        leagueButtons.forEach(btn => {
            btn.addEventListener("click", function() {
                leagueButtons.forEach(b => b.classList.remove("active-league", "active"));
                this.classList.add("active-league", "active");
                searchInput.value = "";
                filterMatches();
            });
        });

        // Кліки по навігації (Усі / LIVE / Заплановані / Завершені)
        navItems.forEach(item => {
            item.addEventListener("click", function() {
                navItems.forEach(i => i.classList.remove("active"));
                this.classList.add("active");
                filterMatches();
            });
        });

        filterMatches();
    });
</script>
</body>
</html>