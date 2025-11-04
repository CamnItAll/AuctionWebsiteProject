<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reset Password</title>
</head>
<body style="text-align:center;">
    <h2>Reset ${username}'s Password</h2>

    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>

    <form method="post" action="${contextPath}/reset-password">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="hidden" name="username" value="${username}"/>
        <input type="password" name="password" placeholder="New password" required/><br><br>
        <input type="password" name="passwordConfirm" placeholder="Confirm password" required/><br><br>
        <button type="submit">Reset Password</button>
    </form><br>
    <a href="<c:url value='/login'/>"><button type="button">Back to Login</button></a>
</body>
</html>