<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <title>MATCHDAY | Вхід</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        body {
            background-color: var(--bg-dark);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            flex-direction: column;
            position: relative;
        }
        .back-link {
            position: absolute;
            top: 30px;
            left: 40px;
            color: var(--gold);
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: 0.3s;
        }
        .back-link:hover { opacity: 0.8; }

        .login-logo {
            background: var(--gold);
            color: var(--bg-dark);
            font-size: 40px;
            font-weight: 700;
            width: 80px;
            height: 80px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 16px;
            margin-bottom: 20px;
            box-shadow: 0 0 20px rgba(220, 179, 109, 0.2);
        }
        .login-title { color: var(--gold); font-size: 24px; margin-bottom: 5px; letter-spacing: 2px; }
        .login-subtitle { color: var(--text-muted); font-size: 11px; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 40px; }

        .login-box {
            background-color: var(--bg-card);
            border: 1px solid rgba(220, 179, 109, 0.1);
            border-radius: 12px;
            padding: 40px;
            width: 350px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.6);
        }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; color: var(--text-muted); font-size: 10px; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 8px; }
        .form-group input {
            width: 100%; padding: 12px; background: rgba(0,0,0,0.3); border: 1px solid rgba(220, 179, 109, 0.2);
            color: white; border-radius: 6px; outline: none; box-sizing: border-box; transition: 0.3s;
        }
        .form-group input:focus { border-color: var(--gold); }
        .btn-submit {
            width: 100%; padding: 14px; background-color: var(--gold); color: var(--bg-dark);
            border: none; border-radius: 6px; font-weight: 700; font-size: 14px; cursor: pointer; margin-top: 10px; transition: 0.3s;
        }
        .btn-submit:hover { background-color: #cda25c; }
        .error-msg { color: var(--red-live); font-size: 12px; text-align: center; margin-bottom: 15px; font-weight: bold; }
    </style>
</head>
<body>

<a href="${pageContext.request.contextPath}/home" class="back-link">← Назад до матчів</a>

<div class="login-logo">M</div>
<div class="login-title">Вхід</div>
<div class="login-subtitle">ТІЛЬКИ ДЛЯ АДМІНІСТРАТОРІВ</div>

<div class="login-box">
    <c:if test="${not empty error}">
        <div class="error-msg">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-group">
            <label>Логін</label>
            <input type="text" name="username" required>
        </div>
        <div class="form-group">
            <label>Пароль</label>
            <input type="password" name="password" required>
        </div>
        <button type="submit" class="btn-submit">Увійти</button>
    </form>
</div>

</body>
</html>