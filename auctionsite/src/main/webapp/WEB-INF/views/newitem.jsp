<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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

    <form action="<c:url value='/auction/create'/>" method="POST">
        <label for="name">Item Name:</label>
        <input type="text" id="name" name="name" required><br><br>

        <label for="description">Description:</label>
        <textarea id="description" name="description" required></textarea><br><br>

        <label for="startPrice">Starting Price:</label>
        <input type="number" id="startPrice" name="startPrice" step="0.01" required><br><br>

        <label for="auctionType">Auction Type:</label>
        <select id="auctionType" name="auctionType">
            <option value="forward">Forward Auction</option>
            <option value="dutch">Dutch Auction</option>
        </select><br><br>

        <label for="endDate">End Date:</label>
        <input type="datetime-local" id="endDate" name="endDate" required><br><br>

        <label for="expeditedShippingPrice">Expedited Shipping Price:</label>
        <input type="number" id="expeditedShippingPrice" name="expeditedShippingPrice" step="0.01"><br><br>

        <label for="shippingDays">Shipping Days:</label>
        <input type="number" id="shippingDays" name="shippingDays"><br><br>

        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

        <button type="submit">Create Auction</button>
    </form><br>

    <a href="<c:url value='/catalogue'/>">Back to Catalog</a>
</body>
</html>