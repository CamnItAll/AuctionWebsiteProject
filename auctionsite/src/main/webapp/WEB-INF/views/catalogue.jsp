<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Home</title>
</head>
<body style="text-align:center;">
  <div class="container">
    <c:if test="${pageContext.request.userPrincipal.name != null}">
        <form id="logoutForm" method="POST" action="${contextPath}/perform_logout">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>

        <h1>Welcome, ${pageContext.request.userPrincipal.name}!</h1>
    </c:if>
  </div>
  <div class="container" id="catalogue">
    <form action="<c:url value='/catalogue'/>" method="get">
        <input type="text" name="keyword" placeholder="Search auctions">
        <button type="submit">Search</button>
    </form><br>
    
    <c:if test="${empty items}">
        <p>No items found.</p>
    </c:if>
        <table border="1" align="center" cellpadding="8" cellspacing="0">
        <tr>
            <th>Item Name</th>
            <th style="width: 300px;">Description</th>
            <th>Latest Price</th>
            <th>Latest Bidder</th>
            <th>Auction Type</th>
            <th>Time Left</th>
            <th>Select</th>
        </tr>

        <c:forEach var="item" items="${items}">
            <tr>
                <td>${item.name}</td>
                <td style="width: 300px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">${item.description}</td>
                <td><fmt:formatNumber value="${item.currentPrice}" type="currency"/></td>
                <td><c:choose>
                        <c:when test="${item.highestBidder.username != null}">${item.highestBidder.username}</c:when>
                        <c:otherwise>N/A</c:otherwise>
                </c:choose></td>
                <td>${item.auctionType}</td>
                <td><c:choose>
                        <c:when test="${item.auctionStatus == 'OPEN' && item.auctionType == 'FORWARD'}">
                            <span class="countdown" data-end="${item.endDate}" date-ended-text="Ended"></span>
                        </c:when>
                        <c:otherwise>N/A</c:otherwise>
                </c:choose></td>
                <td>
                    <form action="<c:url value='/auction/${item.itemId}'/>" method="get">
                        <button type="submit">Bid on ${item.name}</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table><br>
    <a href="<c:url value='/catalogue/new'/>"><button type="button">Create New Auction</button></a>
  </div><br>
  <div class="container">
      <button onclick="document.forms['logoutForm'].submit()">Click here to logout.</button>
  </div>

  <!--Script for countdown timer-->
    <script>
    (function () {
    function pad(n) { return n.toString().padStart(2, '0'); }

    function formatDuration(ms) {
        if (ms <= 0) return null;
        const totalSeconds = Math.floor(ms / 1000);
        const days = Math.floor(totalSeconds / 86400);
        const hours = Math.floor((totalSeconds % 86400) / 3600);
        const minutes = Math.floor((totalSeconds % 3600) / 60);
        const seconds = totalSeconds % 60;
        // Show D days HH:MM:SS (omit days if 0)
        return (days > 0 ? (days + "d ") : "") + pad(hours) + ":" + pad(minutes) + ":" + pad(seconds);
    }

    function parseEnd(el) {
        const raw = el.getAttribute('data-end');
        if (!raw) return null;
        const d = new Date(raw.replace(' ', 'T')); // just in case any space sneaks in
        return isNaN(d.getTime()) ? null : d;
    }

    function tick() {
        const now = Date.now();
        document.querySelectorAll('.countdown').forEach(function (el) {
        if (!el._endDate) el._endDate = parseEnd(el);
        const endedText = el.getAttribute('data-ended-text') || 'Ended';
        if (!el._endDate) { el.textContent = endedText; return; }

        const remaining = el._endDate.getTime() - now;
        const pretty = formatDuration(remaining);
        if (pretty) {
            el.textContent = pretty;
            el.classList.remove('ended');
        } else {
            el.textContent = endedText;
            el.classList.add('ended');
        }
        });
    }

    // Kick off immediately, then every second
    document.addEventListener('DOMContentLoaded', function () {
        tick();
        setInterval(tick, 1000);
    });
    })();
    </script>
</body>
</html>