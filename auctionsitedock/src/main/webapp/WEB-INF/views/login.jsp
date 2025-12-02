<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="<c:url value='/css/styles.css' />">
    <meta charset="utf-8">
    <title>Login</title>
</head>

<body style="text-align:center;">
    
    <div class="header">
        <div class="placeholder">
        </div>
    </div>
    
    <div class="bubble_window">
        <div class="bubble_left">
            <span class="bubble_text_left">
                <h1 class="bubble_text">Login to your account</h1>
                
                <c:if test="${not empty message}">
                    <div style="color: green; font-weight: bold;">${message}</div>
                </c:if>

                <c:if test="${not empty error}">
                    <div style="color: red; font-weight: bold;">${error}</div>
                </c:if>

                <br><a class="bubble_text" href="<c:url value='/registration'/>">Create account</a>
            </span>
        </div>
        <div class="bubble_right">
            <div class="form_container">
                <form action="${contextPath}/perform_login" method="post">
                    <div class="form_element">
                        <span>
                            <span class="textbox_container">
                                <span class="textbox">
                                    <input class="textbox_input" type="text" name="username" placeholder="Username" required autofocus/>
                                </span>
                            </span>
                        </span>
                    </div>
                    <div class="form_element">
                        <span>
                            <span class="textbox_container">
                                <span class="textbox">
                                    <input class="textbox_input" type="password" name="password" placeholder="Password" required/>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                </span>
                            </span>
                        </span>
                    </div>
                    <button class="horizontal" type="submit">Login</button>
                    <a href="<c:url value='/forgot-password'/>"><button class="horizontal" type="button">Forgot Password?</button></a>
                </form>
            </div>
        </div>
    </div> 
</body>
</html>