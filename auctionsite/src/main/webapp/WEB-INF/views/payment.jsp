<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Payment Receipt</title>
</head>
<body style="text-align:center;">
    <h1>Payment Successful!</h1>
    <p>Total Paid: $${payment.amount}</p>
    <p>The item will be shipped in ${item.shippingDays} days.</p>
    <p>Expedited Shipping: $${item.expeditedShippingPrice}</p>
</body>