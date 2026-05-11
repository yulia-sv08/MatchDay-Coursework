<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <title>MATCHDAY | Команди</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=8">
</head>
<body>
<img src="${pageContext.request.contextPath}/assets/images/leopard.png" class="leopard-bg" alt="Leopard">

<!-- Бічна панель -->
<div class="sidebar">
    <div class="logo-container">
        <div style="background: var(--gold); color: black; padding: 5px 10px; border-radius: 4px;">M</div>
        MATCHDAY
    </div>
    <div class="menu-title">НАВІГАЦІЯ</div>
    <ul class="league-list">
        <a href="${pageContext.request.contextPath}/home" style="text-decoration: none;">
            <li class="league-item">Усі матчі</li>
        </a>
        <li class="league-item active">Команди</li>
    </ul>
</div>

<!-- Основний контент  -->
<div class="main-content">
    <h1 class="page-title">УСІ КОМАНДИ</h1>

    <!-- Контейнер для списку -->
    <div style="display: flex; flex-direction: column; gap: 10px;">
        <c:forEach var="team" items="${teams}">
            <!-- Рядок кожної команди -->
            <a href="${pageContext.request.contextPath}/team?id=${team.id}"
               style="text-decoration: none; background: var(--bg-card); padding: 15px 20px; border-radius: 8px; display: flex; align-items: center; border: 1px solid rgba(220, 179, 109, 0.1); transition: 0.3s;"
               onmouseover="this.style.borderColor='var(--gold)'"
               onmouseout="this.style.borderColor='rgba(220, 179, 109, 0.1)'">

                <!-- Логотип зліва -->
                <img src="${pageContext.request.contextPath}/assets/images/${team.logo}"
                     style="width: 50px; height: 50px; object-fit: contain; margin-right: 20px;">

                <!-- Назва та країна -->
                <div style="display: flex; flex-direction: column; gap: 4px;">
                    <h3 style="color: var(--gold); font-size: 18px; margin: 0;">${team.name}</h3>
                    <p style="color: var(--text-muted); font-size: 13px; text-transform: uppercase; margin: 0;">${team.country}</p>
                </div>
            </a>
        </c:forEach>
    </div>
</div>
</body>
</html>