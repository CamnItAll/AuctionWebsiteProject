<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="iid" value="${empty item.itemId ? item.id : item.itemId}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Payment</title>
</head>
<body style="text-align:center;">
    <h2>Pay Now</h2>

    <c:if test="${not empty error}">
        <div style="color:red">${error}</div>
    </c:if>
    <c:if test="${not empty formError}">
        <div style="color:red">${formError}</div>
    </c:if>

    <p><b>Item:</b> ${item.name}</p>
    <p><b>Final Price:</b>
    <fmt:formatNumber value="${item.currentPrice}" type="currency"/>
    </p>
    <p><b>Shipping:</b>
    Expedited +<fmt:formatNumber value="${item.expeditedShippingPrice}" type="currency"/>
    </p>

    <form:form action="${contextPath}/payment/${item.itemId}/pay" method="post" modelAttribute="paymentForm">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

        <label>Name on Card</label><br/>
        <form:input name="cardName" path="cardName" required="true"/><br/><br/>

        <label>Card Number</label><br/>
        <form:input name="cardNum" path="cardNum" placeholder="XXXX XXXX XXXX XXXX" required="true"/><br/><br/>

        <label>Expiry (MM / YYYY)</label><br/>
        <form:input name="expireDate" path="expireDate" size="7" required="true"/><br/><br/>

        <label>CVV</label><br/>
        <form:input name="cvv" path="cvv" size="4" required="true"/><br/><br/>

        <button type="submit">Submit Payment</button>
    </form:form>
</body>
</html>
