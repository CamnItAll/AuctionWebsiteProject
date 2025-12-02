<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="<c:url value='/css/styles.css' />">
    <meta charset="utf-8">
    <title>Payment</title>
</head>
<body style="text-align:center;">
    <h2>Pay Now</h2>

    <table border="1" align="center" cellpadding="8">
        <tr>
            <th>Item</th>
            <td>${item.name}</td>
        </tr>
        <tr>
            <th>Description</th>
            <td style="width: 700px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">${item.description}</td>
        </tr>
        <tr>
            <th>Final Bid</th>
            <td><fmt:formatNumber value="${item.currentPrice}" type="currency"/></td>
        </tr>
        <tr>
            <th>Shipping</th>
            <td>
                Regular: <fmt:formatNumber value="${item.shippingPrice}" type="currency"/>  | 
                with Expedited: +<fmt:formatNumber value="${item.expeditedShippingPrice}" type="currency"/>
            </td>
        </tr>
    </table><br>
    <c:if test="${not empty error}">
        <div style="color:red">${error}</div>
    </c:if>
    <c:if test="${not empty formError}">
        <div>${formError}</div>
    </c:if><br>

    <form:form action="${contextPath}/payment/${item.itemId}/pay" method="post" modelAttribute="paymentForm">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

        <label for="cardName">Name on Card</label><br/>
        <form:input name="cardName" path="cardName" required="true"/><br><br>

        <label for="cardNum">Card Number</label><br/>
        <form:input name="cardNum" path="cardNum" placeholder="XXXX XXXX XXXX XXXX" maxlength="19" required="true"/><br><br>

        <label for="expireDate">Expiry (MM / YYYY)</label><br/>
        <form:input name="expireDate" path="expireDate" maxlength="7" required="true"/><br><br>

        <label for="cvv">CVV</label><br/>
        <form:input name="cvv" path="cvv" maxlength="3" required="true"/><br><br>

        <label for="isExpedited">Expedite Shipment?</label>
        <form:checkbox path="expedited" id="isExpedited" /><br><br>

        <button type="submit">Submit Payment</button>
    </form:form>
</body>
</html>
