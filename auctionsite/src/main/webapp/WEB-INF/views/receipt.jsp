<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Receipt</title>
</head>
<body style="text-align:center;">
    <h2>Payment Processed</h2>

    <h3>Receipt</h3>
    <table border="1" align="center" cellpadding="8">
        <tr>
            <th>Item</th>
            <td>${item.name}</td>
        </tr>
        <tr>
            <th>Final Bid</th>
            <td><fmt:formatNumber value="${item.currentPrice}" type="currency"/></td>
        </tr>
        <tr>
            <th>Bought By</th>
            <td>${user.username}</td>
        </tr>
        <tr>
            <th>Shipping Price</th>
            <td><c:choose>
                    <c:when test="${payment.expedited}">
                        <fmt:formatNumber value="${item.shippingPrice}" type="currency"/> 
                        + <fmt:formatNumber value="${item.expeditedShippingPrice}" type="currency"/> 
                        = <fmt:formatNumber value="${item.shippingPrice + item.expeditedShippingPrice}" type="currency"/><br>
                        <b>Expedited:</b> Yes
                    </c:when>
                    <c:otherwise>
                        <fmt:formatNumber value="${item.shippingPrice}" type="currency"/><br>
                        <b>Expedited:</b> No
                    </c:otherwise>
            </c:choose></td>
        </tr>
        <tr>
            <th>Total Amount</th>
            <td><c:choose>
                    <c:when test="${payment.expedited}">
                        <fmt:formatNumber value="${item.currentPrice + item.shippingPrice + item.expeditedShippingPrice}" type="currency"/>
                    </c:when>
                    <c:otherwise>
                        <fmt:formatNumber value="${item.currentPrice + item.shippingPrice}" type="currency"/>
                    </c:otherwise>
            </c:choose></td>
        </tr>
    </table>
    <h3>Shipping Details</h3>
    <table border="1" align="center" cellpadding="8">
        <tr>
            <th>Shipping Location</th> 
            <td>${user.addressNo} ${user.addressStreet}, ${user.city}, ${user.country}, ${user.postalCode}</td>
        </tr>
        <tr>
            <th>Shipping Period</th>
            <td><c:choose>
                <c:when test="${payment.expedited}">This item will be shipped in 2 days.</c:when>
                <c:otherwise>This item will be shipped in ${item.shippingDays} days.</p></c:otherwise>
            </c:choose></td>
        </tr>
    </table><br>

    <div class="container">
      <a href="<c:url value='/catalogue'/>"><button type="button">Back to Catalog</button></a>
      <form action="<c:url value='/perform_logout'/>" method="post" style="display:inline;">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
          <button type="submit">Click here to Logout</button>
      </form>
  </div>
</body>
</html>
