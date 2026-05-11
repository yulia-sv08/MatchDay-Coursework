<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <title>MATCHDAY | ${team.name}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=6">
</head>
<body>

<img src="${pageContext.request.contextPath}/assets/images/leopard.png" class="leopard-bg" alt="Leopard">

<div class="sidebar">
    <div class="logo-container">
        <div style="background: var(--gold); color: black; padding: 5px 10px; border-radius: 4px;">M</div>
        MATCHDAY
    </div>
    <div class="menu-title">НАВІГАЦІЯ</div>
    <ul class="league-list">
        <a href="${pageContext.request.contextPath}/home" style="text-decoration: none;">
            <li class="league-item"> Повернутися до матчів</li>
        </a>
    </ul>
</div>

<div class="main-content">
    <div class="top-nav">
        <div class="top-links" style="margin-left: auto;">
            <a href="${pageContext.request.contextPath}/teams">УСІ КОМАНДИ</a>
            <a href="${pageContext.request.contextPath}/login">УВІЙТИ</a>
        </div>
    </div>

    <div style="display: flex; align-items: center; gap: 40px; margin-bottom: 50px; background: rgba(39, 16, 21, 0.7); padding: 40px; border-radius: 12px; border: 1px solid rgba(220, 179, 109, 0.2);">
        <img src="${pageContext.request.contextPath}/assets/images/${team.logo}" style="width: 120px; height: 120px; object-fit: contain;">
        <div>
            <h1 style="color: var(--gold); font-size: 32px; text-transform: uppercase; margin-bottom: 10px;">${team.name}</h1>
            <p style="color: var(--text-muted); margin-bottom: 5px;">Країна: <span style="color: white;">${team.country}</span></p>
            <p style="color: var(--text-muted);">Рік заснування: <span style="color: white;">${team.foundationYear}</span></p>
        </div>
    </div>

    <h2 class="page-title">МАТЧІ КОМАНДИ</h2>
    <div id="matchesContainer">
        <c:forEach var="match" items="${matches}">
            <div class="match-card ${match.status == 'live' ? 'live-match' : ''}">
                <div class="match-header">
                    <span>${match.tournament}</span>
                    <span>${match.stadium}</span>
                </div>
                <div class="match-body">
                    <div class="team home">
                        <img src="${pageContext.request.contextPath}/assets/images/${match.homeTeam.logo}">
                        <span class="team-name">${match.homeTeam.name}</span>
                    </div>
                    <div class="score-board">
                        <div class="score">
                            <c:choose>
                                <c:when test="${match.status == 'planned'}">${match.matchDate.toString().substring(11, 16)}</c:when>
                                <c:when test="${not empty resultsMap[match.id]}">${resultsMap[match.id].homeScore} : ${resultsMap[match.id].awayScore}</c:when>
                                <c:otherwise>- : -</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="badge badge-${match.status}">${match.status}</div>
                    </div>
                    <div class="team away">
                        <img src="${pageContext.request.contextPath}/assets/images/${match.awayTeam.logo}">
                        <span class="team-name">${match.awayTeam.name}</span>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>