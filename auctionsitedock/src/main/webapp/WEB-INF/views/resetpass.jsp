<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="<c:url value='/css/styles.css' />">
    <meta charset="UTF-8">
    <title>Reset Password</title>
</head>
<body style="text-align:center;">
	<div class="header">
		<div class="placeholder">
		</div>
	</div>

	<div class="bubble_window">
		<div class="bubble_left">
			<span class="bubble_text_left">
				<h1 class="bubble_text">Reset ${username}'s Password</h1>
				<c:if test="${not empty error}">
					<p style="color:red;">${error}</p>
				</c:if>
                <br><a class="bubble_text" href="<c:url value='/Login'/>">Return to login</a>
			</span>
		</div>
		<div class="bubble_right">
			<div class="form_container">
				<form method="post" action="${contextPath}/reset-password">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					<input type="hidden" name="username" value="${username}"/>
					<div class="form_element">
						<span>
							<span class="textbox_container">
								<span class="textbox">
									<input class="textbox_input" type="password" name="password" placeholder="New password" required/>
								</span>
							</span>
						</span>
					</div>
					<div class="form_element">
						<span>
							<span class="textbox_container">
								<span class="textbox">
									<input class="textbox_input" type="password" name="passwordConfirm" placeholder="Confirm password" required/>
								</span>
							</span>
						</span>
					</div>
					<button type="submit">Reset Password</button>
				</form>
			</div>
		</div>
	</div>    
</body>
</html>