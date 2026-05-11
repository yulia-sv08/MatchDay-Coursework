<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <title>MATCHDAY | Панель керування</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        .team-logo-small { width: 30px; height: 30px; vertical-align: middle; margin: 0 5px; object-fit: contain; }
        .btn-gold-small { background: var(--gold); color: black; border: none; padding: 6px 12px; border-radius: 4px; font-weight: 600; cursor: pointer; text-decoration: none; font-size: 12px; display: inline-block; }
        .btn-red-small { background: #8b0000; color: white; border: none; padding: 6px 12px; border-radius: 4px; font-weight: 600; cursor: pointer; text-decoration: none; font-size: 12px; display: inline-block; }
        .score-cell { text-align: center; font-size: 16px; font-weight: bold; color: var(--gold); min-width: 80px; }
    </style>
</head>
<body>

<div class="sidebar">
    <div class="logo-container">
        <div style="background: var(--gold); color: black; padding: 5px 10px; border-radius: 4px;">M</div>
        MATCHDAY
    </div>

    <div class="menu-title">КЕРУВАННЯ</div>
    <ul class="league-list">
        <li class="league-item active" style="border: 1px solid var(--gold); padding: 8px; border-radius: 8px;">Dashboard</li>
    </ul>
</div>

<div class="main-content">

    <div class="top-nav">
        <h1 class="page-title" style="margin: 0;">КОМАНДИ</h1>
        <div class="top-links">
            <a href="${pageContext.request.contextPath}/home">НА САЙТ</a>
            <a href="${pageContext.request.contextPath}/logout">ВИЙТИ</a>
        </div>
    </div>

    <a href="${pageContext.request.contextPath}/admin/team-form" class="btn-gold-small" style="padding: 10px 20px; font-size: 14px; margin-bottom: 20px;">+ ДОДАТИ КОМАНДУ</a>

    <table class="admin-table">
        <thead>
        <tr>
            <th>Назва / Логотип</th>
            <th>Країна</th>
            <th>Рік заснування</th>
            <th>Дії</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="team" items="${teams}">
            <tr>
                <td>
                    <img src="${pageContext.request.contextPath}/assets/images/${team.logo}" class="team-logo-small">
                        ${team.name}
                </td>
                <td>${team.country}</td>
                <td>${team.foundationYear}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/team-form?id=${team.id}" class="btn-gold-small" style="margin-right: 5px;">Ред.</a>
                    <form action="${pageContext.request.contextPath}/admin/delete-team" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="${team.id}">
                        <button type="submit" class="btn-red-small" onclick="return confirm('Видалити цю команду?');">Видалити</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="top-nav" style="margin-top: 50px;">
        <h1 class="page-title" style="margin: 0;">МАТЧІ</h1>
    </div>

    <a href="${pageContext.request.contextPath}/admin/match-form" class="btn-gold-small" style="padding: 10px 20px; font-size: 14px; margin-bottom: 20px;">+ ДОДАТИ МАТЧ</a>

    <table class="admin-table">
        <thead>
        <tr>
            <th>Матч</th>
            <th style="text-align: center;">Рахунок</th>
            <th>Дата</th>
            <th>Статус</th>
            <th>Дії</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="match" items="${matches}">
            <tr>
                <td>
                    <img src="${pageContext.request.contextPath}/assets/images/${match.homeTeam.logo}" class="team-logo-small">
                        ${match.homeTeam.name} — ${match.awayTeam.name}
                    <img src="${pageContext.request.contextPath}/assets/images/${match.awayTeam.logo}" class="team-logo-small">
                </td>

                <td class="score-cell">
                    <c:choose>
                        <c:when test="${not empty resultsMap[match.id]}">
                            ${resultsMap[match.id].homeScore} : ${resultsMap[match.id].awayScore}
                        </c:when>
                        <c:otherwise>— : —</c:otherwise>
                    </c:choose>
                </td>

                <td>${match.matchDate}</td>
                <td>
                            <span style="color: ${match.status == 'live' ? '#e63946' : 'var(--gold)'}; font-weight: bold; text-transform: uppercase; font-size: 11px;">
                                    ${match.status}
                            </span>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/match-form?id=${match.id}" class="btn-gold-small" style="margin-right: 5px;">Редагувати</a>
                    <form action="${pageContext.request.contextPath}/admin/delete-match" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="${match.id}">
                        <button type="submit" class="btn-red-small" onclick="return confirm('Видалити цей матч?');">Видалити</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>