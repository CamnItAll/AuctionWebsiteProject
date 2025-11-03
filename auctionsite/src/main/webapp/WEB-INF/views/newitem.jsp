<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>New Item</title>
</head>
<body style="text-align:center;">
    <h1>Create New Auction</h1>

    <form:form action="${contextPath}/catalogue/create" method="POST" modelAttribute="itemForm">
        <label for="name">Item Name:</label>
        <form:input path="name" id="name" required="true"/><br><br>

        <label for="description">Description:</label>
        <form:textarea path="description" id="description" required="true"/><br><br>

        <label for="startPrice">Starting Price:</label>
        <form:input path="startPrice" id="startPrice" type="number" step="0.01" required="true"/><br><br>

        <label for="auctionType">Auction Type:</label>
        <form:select path="auctionType" id="auctionType">
            <form:option value="FORWARD" label="Forward Auction"/>
            <form:option value="DUTCH" label="Dutch Auction"/>
        </form:select><br><br>

        <label for="endDate">End Date:</label>
        <form:input path="endDate" id="endDate" type="datetime-local" required="true"/><br><br>

        <label for="expeditedShippingPrice">Expedited Shipping Price:</label>
        <form:input path="expeditedShippingPrice" id="expeditedShippingPrice" type="number" step="0.01"/><br><br>

        <label for="shippingDays">Shipping Days:</label>
        <form:input path="shippingDays" id="shippingDays" type="number"/><br><br>

        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

        <button type="submit">Create Auction</button>
    </form:form><br>

    <a href="<c:url value='/catalogue'/>">Back to Catalog</a>
</body>
</html>