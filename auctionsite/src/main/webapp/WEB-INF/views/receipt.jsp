<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="iid" value="${empty item.itemId ? item.id : item.itemId}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Receipt</title>
</head>
<body style="text-align:center;">
    <h2>Payment Processed</h2>

    <h3>Receipt</h3>
    <p><b>Item:</b> ${item.name}</p>
    <p><b>Final Bid:</b>
    <fmt:formatNumber value="${item.currentPrice}" type="currency"/>
    </p>
    <p><b>Shipping Price:</b>
    </p>
    <p><b>Total Amount:</b>
    </p>

    <h3>Shipping Details</h3>
    <p>This item will be shipped in ${item.shippingDays} days.</p>

    <div class="container">
      <a href="<c:url value='/catalogue'/>"><button type="button">Back to Catalog</button></a>
      <button onclick="document.forms['logoutForm'].submit()">Click here to logout.</button>
  </div>
</body>
</html>
