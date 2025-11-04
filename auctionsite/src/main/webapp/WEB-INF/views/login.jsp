<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
  <head>
      <meta charset="utf-8">
      <title>Log in with your account</title>
  </head>

  <body style="text-align:center;">
    <div class="container">
      <form method="POST" action="${contextPath}/perform_login">
        <h2>Log in</h2>

        <div>
          <span>${message}</span><br><br>
          <input name="username" type="text" placeholder="Username" autofocus="true"/><br><br>
          <input name="password" type="password" placeholder="Password"/><br><br>
          <span>${error}</span><br>
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

          <button type="submit">Log In</button><br>
          <a href="${contextPath}/registration"><button type="button">Create an Account</button></a><br>
          <a href="${contextPath}/forgot-password"><button type="button">Forgot Password?</button></a><br>
        </div>
      </form>
    </div>
  </body>
</html>