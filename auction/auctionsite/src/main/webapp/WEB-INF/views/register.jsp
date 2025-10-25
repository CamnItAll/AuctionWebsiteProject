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
          <form:input type="text" path="username" placeholder="Username" autofocus="true"/>
          <form:errors path="username" cssClass="error"/>
        </spring:bind><br><br>

        <spring:bind path="password">
          <label>Password</label>
          <form:input type="password" path="password" placeholder="Password"/>
          <form:errors path="password" cssClass="error"/>
        </spring:bind><br><br>

        <spring:bind path="passwordConfirm">
          <label>Confirm Password</label>
          <form:input type="password" path="passwordConfirm" placeholder="Confirm Password"/>
          <form:errors path="passwordConfirm" cssClass="error"/>
        </spring:bind><br><br>

        <spring:bind path="firstName">
          <label>First Name</label>
          <form:input type="text" path="firstName" placeholder="First Name"/>
          <form:errors path="firstName" cssClass="error"/>
        </spring:bind><br><br>

        <spring:bind path="lastName">
          <label>Last Name</label>
          <form:input type="text" path="lastName" placeholder="Last Name"/>
          <form:errors path="lastName" cssClass="error"/>
        </spring:bind><br><br>

        <spring:bind path="addressStreet">
          <label>Street</label>
          <form:input type="text" path="addressStreet" placeholder="Street Name"/>
          <form:errors path="addressStreet" cssClass="error"/>
        </spring:bind><br><br>

        <spring:bind path="addressNo">
          <label>Street Number</label>
          <form:input type="text" path="addressNo" placeholder="House/Apartment Number"/>
          <form:errors path="addressNo" cssClass="error"/>
        </spring:bind><br><br>

        <spring:bind path="city">
          <label>City</label>
          <form:input type="text" path="city" placeholder="City"/>
          <form:errors path="city" cssClass="error"/>
        </spring:bind><br><br>

        <spring:bind path="country">
          <label>Country</label>
          <form:input type="text" path="country" placeholder="Country"/>
          <form:errors path="country" cssClass="error"/>
        </spring:bind><br><br>

        <spring:bind path="postalCode">
          <label>Postal Code</label>
          <form:input type="text" path="postalCode" placeholder="Postal Code"/>
          <form:errors path="postalCode" cssClass="error"/>
        </spring:bind><br><br>

        <button type="submit">Register</button>
      </form:form>
    </div>
  </body>
</html>