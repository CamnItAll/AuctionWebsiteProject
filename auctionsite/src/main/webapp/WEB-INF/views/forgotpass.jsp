<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>
</head>
<body style="text-align:center;">
    <h2>Forgot Password?</h2>

    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>

    <form method="post" action="${contextPath}/forgot-password">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <label for="username">Enter your username:</label><br>
        <input type="text" name="username" required><br><br>
        <button type="submit">Continue</button>
    </form><br>
    <a href="<c:url value='/login'/>"><button type="button">Back to Login</button></a>

</body>
</html>