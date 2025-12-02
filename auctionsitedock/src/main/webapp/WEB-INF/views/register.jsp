<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
  <head>
      <link rel="stylesheet" href="<c:url value='/css/styles.css' />">
      <meta charset="utf-8">
      <title>Create an account</title>
  </head>

<body style="text-align:center;">
	<div class="header">
		<div class="placeholder">
		</div>
	</div>
	
	<div class="bubble_window">
		<div class="bubble_left">
			<span class="bubble_text_left">
				<h1 class="bubble_text">Create your account</h1>
				<a class="bubble_text" href="<c:url value='/login'/>">←Back to Login</a>
			</span>
		</div>
		<div class="bubble_right">
			<div class="form_container">
				<form:form method="POST" modelAttribute="userForm">

					<div class="elementfn">
						<span>
							<span class="textbox_container">
								<span class="textbox">
									<form:input class="textbox_input" type="text" path="firstName" placeholder="First Name"/>
								</span>
							</span>
						</span>
					</div>

					<div class="elementln">
						<span>
							<span class="textbox_container">
								<span class="textbox">
									<form:input class="textbox_input" type="text" path="lastName" placeholder="Last Name"/>
								</span>
							</span>	
						</span>
					</div>

					<spring:bind path="username">
					<div class="form_element">
						<span>
							<span class="textbox_container">
								<span class="textbox">
									<form:input class="textbox_input" type="text" path="username" placeholder="Username" autofocus="true"/>
								</span>
							</span>
							<form:errors path="username" cssClass="error"/>
						</span>
					</div>
					</spring:bind>

					<spring:bind path="password">
					<div class="form_element">
						<span>
							<span class="textbox_container">
								<span class="textbox">
									<form:input class="textbox_input" type="password" path="password" placeholder="Password"/>
								</span>
							</span>
              <form:errors path="password" cssClass="error"/>
						</span>
					</div>
					</spring:bind>

					<spring:bind path="passwordConfirm">
					<div class="form_element">
						<span>
							<span class="textbox_container">
								<span class="textbox">
									<form:input class="textbox_input" type="password" path="passwordConfirm" placeholder="Confirm Password"/>
								</span>
							</span>
              <form:errors path="passwordConfirm" cssClass="error"/>
						</span>
					</div>
					</spring:bind>

					<div class="form_element">
						<span>
							<span class="textbox_container">
								<span class="textbox">
									<form:input class="textbox_input" type="text" path="addressStreet" placeholder="Street Name"/>
								</span>
							</span>
						</span>
					</div>

					<div class="form_element">
						<span>
							<span class="textbox_container">
								<span class="textbox">
									<form:input class="textbox_input" type="text" path="addressNo" placeholder="House/Apartment Number"/>
								</span>
							</span>
						</span>
					</div>

					<div class="form_element">
						<span>
							<span class="textbox_container">
								<span class="textbox">
									<form:input class="textbox_input" type="text" path="city" placeholder="City"/>
								</span>
							</span>
						</span>
					</div>

					<div class="form_element">
						<span>
							<span class="textbox_container">
								<span class="textbox">
									<form:input class="textbox_input" type="text" path="country" placeholder="Country"/>
								</span>
							</span>
						</span>
					</div>

					<div class="form_element">
						<span>
							<span class="textbox_container">
								<span class="textbox">
									<form:input class="textbox_input" type="text" path="postalCode" placeholder="Postal Code" maxlength="7"/>
								</span>
							</span>
						</span>
					</div>

					<button type="submit">Register</button>
				</form:form>
			</div>
		</div>
	</div>
</body>
</html>