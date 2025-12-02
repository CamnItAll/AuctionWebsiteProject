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
    <title>Receipt</title>
</head>
<body style="text-align:center;">
    <div class="header">
        <div class="placeholder">
        </div>
    </div>
    <div class="page_body receipt_total">
        <div style="text-align:left;">
            <h1 style="font-weight:bold;float:right;">Order Receipt</h1>
            <h4 style="font-weight:bold;">Billed To</h4>
            <h3>${user.username}</h3>
            <p>${user.addressNo} ${user.addressStreet}</p>
            <p>${user.city}, ${user.country}, ${user.postalCode}</p>
        </div>
        <div>
            <table style="border-bottom:solid;width:100%;text-align:right;">
                <tr>
                    <th style="text-align:left;">Item</th>
                    <th>Final Bid</th>
                    <th>Shipping Cost</th>
                </tr>
                <tr>
                    <td style="text-align:left;">${item.name}</td>
                    <td><fmt:formatNumber value="${item.currentPrice}" type="currency"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${payment.expedited}">
                                <fmt:formatNumber value="${item.currentPrice + item.shippingPrice + item.expeditedShippingPrice}" type="currency"/>
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${item.currentPrice + item.shippingPrice}" type="currency"/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </table>
        </div>
        <div style="width:50%; display:inline-block; float:right;">
            <table style="width:100%;text-align:right;">
                <tr>
                    <td style="text-align:left;">Subtotal</td>
                    <td>
                    <c:choose>
                        <c:when test="${payment.expedited}">
                            <fmt:formatNumber value="${item.currentPrice + item.shippingPrice + item.expeditedShippingPrice}" type="currency"/>
                        </c:when>
                        <c:otherwise>
                            <fmt:formatNumber value="${item.currentPrice + item.shippingPrice}" type="currency"/>
                        </c:otherwise>
                    </c:choose>
                    </td>
                </tr>
                <tr style="border-bottom:solid">
                    <td style="text-align:left;">Sales tax (13%)</td>
                    <td>
                    <c:choose>
                        <c:when test="${payment.expedited}">
                            <fmt:formatNumber value="${(item.currentPrice + item.shippingPrice + item.expeditedShippingPrice) * 0.13}" type="currency"/>
                        </c:when>
                        <c:otherwise>
                            <fmt:formatNumber value="${(item.currentPrice + item.shippingPrice) * 0.13}" type="currency"/>
                        </c:otherwise>
                    </c:choose>
                    </td>
                </tr>
                <tr style="border-bottom:solid">
                    <td style="text-align:left;">Total</td>
                    <td>
                    <c:choose>
                        <c:when test="${payment.expedited}">
                            <fmt:formatNumber value="${(item.currentPrice + item.shippingPrice + item.expeditedShippingPrice) * 1.13}" type="currency"/>
                        </c:when>
                        <c:otherwise>
                            <fmt:formatNumber value="${(item.currentPrice + item.shippingPrice) * 1.13}" type="currency"/>
                        </c:otherwise>
                    </c:choose>
                    </td>
                </tr>
            </table>
        </div>
        <p style="text-align:left;">
        <c:choose>
            <c:when test="${payment.expedited}">This item will be shipped in 2 days.</c:when>
            <c:otherwise>This item will be shipped in ${item.shippingDays} days.</p></c:otherwise>
        </c:choose>
        </p>
        <div class="container">
            <a href="<c:url value='/catalogue'/>"><button type="button">Back to Catalog</button></a>
            <form action="<c:url value='/perform_logout'/>" method="post" style="display:inline;">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <button type="submit">Click here to Logout</button>
            </form>
        </div>
    </div>
</body>
</html>
