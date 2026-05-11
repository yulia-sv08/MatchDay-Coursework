<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Налаштування матчу</title>
    <style>
        body { background: #140709; font-family: sans-serif; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; padding: 20px;}
        .form-box { background: #271015; padding: 40px; border-radius: 12px; border: 1px solid rgba(220, 179, 109, 0.2); width: 500px; box-shadow: 0 10px 30px rgba(0,0,0,0.5); }
        .form-group { margin-bottom: 15px; }
        label { color: #dcb36d; font-size: 12px; font-weight: bold; }
        input, select { width: 100%; padding: 10px; background: rgba(0,0,0,0.3); border: 1px solid rgba(220, 179, 109, 0.3); color: white; border-radius: 4px; margin-top: 5px; box-sizing: border-box; }
        button { width: 100%; padding: 12px; background: #dcb36d; color: black; border: none; border-radius: 4px; font-weight: bold; cursor: pointer; margin-top: 15px; }
        .score-row { display: flex; gap: 15px; }
    </style>
</head>
<body>
<div class="form-box">
    <h2 style="color: #dcb36d; text-align: center; margin-top: 0; text-transform: uppercase;">${empty match ? 'Створити матч' : 'Редагувати матч'}</h2>

    <form action="${pageContext.request.contextPath}/admin/match-form" method="post">
        <input type="hidden" name="id" value="${match.id}">

        <div class="form-group">
            <label>Господарі</label>
            <select name="homeTeamId">
                <c:forEach var="t" items="${teams}">
                    <option value="${t.id}" ${match.homeTeamId == t.id ? 'selected' : ''}>${t.name}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label>Гості</label>
            <select name="awayTeamId">
                <c:forEach var="t" items="${teams}">
                    <option value="${t.id}" ${match.awayTeamId == t.id ? 'selected' : ''}>${t.name}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label>Дата та час (обов'язково)</label>
            <input type="datetime-local" name="matchDate" value="${match.matchDate}" required>
        </div>

        <div class="form-group">
            <label>Турнір (Ліга)</label>
            <select name="tournament" required>
                <option value="Ліга чемпіонів" ${match.tournament == 'Ліга чемпіонів' ? 'selected' : ''}>Ліга чемпіонів</option>
                <option value="Прем\'єр-ліга" ${match.tournament == 'Прем\'єр-ліга' ? 'selected' : ''}>Прем'єр-ліга</option>
                <option value="Ла Ліга" ${match.tournament == 'Ла Ліга' ? 'selected' : ''}>Ла Ліга</option>
                <option value="Бундесліга" ${match.tournament == 'Бундесліга' ? 'selected' : ''}>Бундесліга</option>
                <option value="Серія А" ${match.tournament == 'Серія А' ? 'selected' : ''}>Серія А</option>
                <option value="Ліга 1" ${match.tournament == 'Ліга 1' ? 'selected' : ''}>Ліга 1</option>
                <option value="Ліга Європи" ${match.tournament == 'Ліга Європи' ? 'selected' : ''}>Ліга Європи</option>
                <option value="УПЛ" ${match.tournament == 'УПЛ' ? 'selected' : ''}>УПЛ</option>
            </select>
        </div>
        <div class="form-group"><label>Стадіон</label><input type="text" name="stadium" value="${match.stadium}"></div>

        <div class="form-group">
            <label>Статус матчу</label>
            <select name="status">
                <option value="planned" ${match.status == 'planned' ? 'selected' : ''}>Заплановано</option>
                <option value="live" ${match.status == 'live' ? 'selected' : ''}>LIVE (Грається)</option>
                <option value="finished" ${match.status == 'finished' ? 'selected' : ''}>Завершено</option>
            </select>
        </div>

        <hr style="border: 0; border-top: 1px solid rgba(220, 179, 109, 0.2); margin: 25px 0;">
        <label style="font-size: 14px; display: block; margin-bottom: 10px; text-align: center;">РАХУНОК</label>
        <div class="score-row">
            <div class="form-group" style="flex: 1;"><input type="number" name="homeScore" value="${result.homeScore}" placeholder="Голи (Господарі)"></div>
            <div class="form-group" style="flex: 1;"><input type="number" name="awayScore" value="${result.awayScore}" placeholder="Голи (Гості)"></div>
        </div>

        <button type="submit">Зберегти матч</button>
        <a href="${pageContext.request.contextPath}/admin/dashboard" style="display:block; text-align:center; color:#dcb36d; margin-top:15px; text-decoration:none; font-size:12px;">Скасувати</a>
    </form>
</div>
</body>
</html>