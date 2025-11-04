<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
  <head>
      <meta charset="utf-8">
      <title>Create an account</title>
  </head>

  <body style="text-align:center;">
    <div class="container">
      <form:form method="POST" modelAttribute="userForm">
        <h2>Create your account</h2>

        <spring:bind path="username">
          <label>Username</label>
          <form:input type="text" path="username" placeholder="Username" autofocus="true"/><br>
          <form:errors path="username" cssClass="error"/>
        </spring:bind><br>

        <spring:bind path="password">
          <label>Password</label>
          <form:input type="password" path="password" placeholder="Password"/><br>
          <form:errors path="password" cssClass="error"/>
        </spring:bind><br>

        <spring:bind path="passwordConfirm">
          <label>Confirm Password</label>
          <form:input type="password" path="passwordConfirm" placeholder="Confirm Password"/><br>
          <form:errors path="passwordConfirm" cssClass="error"/>
        </spring:bind><br>

        <label>First Name</label>
        <form:input type="text" path="firstName" placeholder="First Name"/><br><br>

        <label>Last Name</label>
        <form:input type="text" path="lastName" placeholder="Last Name"/><br><br>

        <label>Street</label>
        <form:input type="text" path="addressStreet" placeholder="Street Name"/><br><br>

        <label>Street Number</label>
        <form:input type="text" path="addressNo" placeholder="House/Apartment Number"/><br><br>

        <label>City</label>
        <form:input type="text" path="city" placeholder="City"/><br><br>

        <label>Country</label>
        <form:input type="text" path="country" placeholder="Country"/><br><br>

        <label>Postal Code</label>
        <form:input type="text" path="postalCode" placeholder="Postal Code" maxlength="7"/><br><br>

        <button type="submit">Register</button>
      </form:form><br>

      <a href="<c:url value='/login'/>"><button type="button">Back to Login</button></a>
    </div>
  </body>
</html>