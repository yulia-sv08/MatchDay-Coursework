<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Форма команди</title>
  <style>
    body { background: #140709; font-family: sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
    .form-box { background: #271015; padding: 40px; border-radius: 12px; border: 1px solid rgba(220, 179, 109, 0.2); width: 400px; box-shadow: 0 10px 30px rgba(0,0,0,0.5); }
    .form-group { margin-bottom: 15px; }
    label { color: #dcb36d; font-size: 12px; font-weight: bold; }
    input { width: 100%; padding: 10px; background: rgba(0,0,0,0.3); border: 1px solid rgba(220, 179, 109, 0.3); color: white; border-radius: 4px; margin-top: 5px; box-sizing: border-box; }
    button { width: 100%; padding: 12px; background: #dcb36d; color: black; border: none; border-radius: 4px; font-weight: bold; cursor: pointer; margin-top: 15px; }
  </style>
</head>
<body>
<div class="form-box">
  <h2 style="color: #dcb36d; text-align: center; margin-top: 0;">${empty team ? 'Нова команда' : 'Редагувати команду'}</h2>
  <form action="${pageContext.request.contextPath}/admin/team-form" method="post">
    <input type="hidden" name="id" value="${team.id}">
    <div class="form-group"><label>Назва</label><input type="text" name="name" value="${team.name}" required></div>
    <div class="form-group"><label>Країна</label><input type="text" name="country" value="${team.country}" required></div>
    <div class="form-group"><label>Місто</label><input type="text" name="city" value="${team.city}"></div>
    <div class="form-group"><label>Рік заснування</label><input type="number" name="foundationYear" value="${team.foundationYear}"></div>
    <div class="form-group"><label>Шлях до логотипу (напр. teams/arsenal.png)</label><input type="text" name="logo" value="${team.logo}"></div>
    <button type="submit">Зберегти</button>
    <a href="${pageContext.request.contextPath}/admin/dashboard" style="display:block; text-align:center; color:#dcb36d; margin-top:15px; text-decoration:none; font-size:12px;">Скасувати</a>
  </form>
</div>
</body>
</html>