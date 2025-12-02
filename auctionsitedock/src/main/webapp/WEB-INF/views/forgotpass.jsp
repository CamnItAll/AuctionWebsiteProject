<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="<c:url value='/css/styles.css' />">
    <meta charset="UTF-8">
    <title>Forgot Password</title>
</head>
<body style="text-align:center;">
  
<div class="header">
    <div class="placeholder">
    </div>
</div>
    <div class="bubble_window">
        <div class="bubble_left">
            <span class="bubble_text_left">
                <h1 class="bubble_text">Forgot Password?</h1>
                <c:if test="${not empty error}">
                    <p style="color:red;">${error}</p>
                </c:if>
                <br><a class="bubble_text" href="<c:url value='/Login'/>">Return to login</a>
            </span>
        </div>
        <div class="bubble_right">
            <div class="form_container">
                <form method="post" action="${contextPath}/forgot-password">
                    <div class="form_element">
                        <span>
                            <span class="textbox_container">
                                <span class="textbox">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <input class="textbox_input" type="text" name="username" placeholder="Enter your username" required>
                                </span>
                            </span>
                        </span>
                    </div>
                    <button type="submit">Continue</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>