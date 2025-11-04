<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Login</title>
</head>

<body style="text-align:center;">
<div class="container">
    <h2>Login</h2>

    <c:if test="${not empty message}">
        <div style="color: green; font-weight: bold;">${message}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div style="color: red; font-weight: bold;">${error}</div>
    </c:if>

    <form action="${contextPath}/perform_login" method="post">
        <label>Username</label><br>
        <input type="text" name="username" required autofocus><br><br>

        <label>Password</label><br>
        <input type="password" name="password" required><br><br>

        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

        <button type="submit">Login</button>
    </form><br>

    <a href="<c:url value='/registration'/>"><button type="button">Register</button></a><br><br>
    <a href="<c:url value='/forgot-password'/>"><button type="button">Forgot Password?</button></a>
</div>
</body>
</html>