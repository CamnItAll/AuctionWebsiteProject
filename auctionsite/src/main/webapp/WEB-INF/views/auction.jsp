<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Auction</title>
</head>
<body style="text-align:center;">
    <h1>${item.name}</h1>
    <p>${item.description}</p>
    <c:choose>
        <c:when test="${item.auctionStatus == 'OPEN'}">
            <p>Time Remaining:
                <span class="countdown"
                    data-end="${item.endDate}"
                    date-ended-text="This auction is over."></span>
            </p>
        </c:when>
        <c:otherwise>
            <p>This auction is over.</p>
        </c:otherwise>
    </c:choose>
    <p>Current Price: <fmt:formatNumber value="${item.currentPrice}" type="currency"/></p>

    <c:if test="${canBid}">
        <form action="<c:url value='/auction/placeBid/${item.itemId}'/>" method="post">
            <p>Latest Bidder: ${item.highestBidder.username}</p>
            <p>Auction Type: ${item.auctionType}</p>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input type="number" name="bidAmount" min="${auction.currentPrice}" step="0.01" required>
            <button type="submit">Place Bid</button>
        </form>
    </c:if>
    <c:if test="${canBuyNow}">
        <form action="<c:url value='/auction/pay/${item.itemId}'/>" method="post">
            <p>Latest Bidder: ${item.highestBidder.username}</p>
            <p>Auction Type: ${item.auctionType}</p>
            <p>Time Remaining: ${item.endDate}</p>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <button type="submit">Buy Now</button>
        </form>
    </c:if>
    <c:if test="${isOwnerD}">
        <form action="<c:url value='/auction/updateDutchPrice/${item.itemId}'/>" method="post">
            <p>Latest Bidder: ${item.highestBidder.username}</p>
            <p>Auction Type: ${item.auctionType}</p>
            <p>Time Remaining: ${item.endDate}</p>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input type="number" name="newPrice" value="${item.startPrice}" step="0.01" required>
            <button type="submit">Update Dutch Auction Price</button>
        </form>
    </c:if>
    <c:if test="${isOwnerF}">
        <p>Latest Bidder: ${item.highestBidder.username}</p>
        <p>Auction Type: ${item.auctionType}</p>
        <p>Time Remaining: ${item.endDate}</p>
        <p>This is your forward auction.</p>
    </c:if>
    
    <c:if test="${auctionEnded}">
        <p>Latest Bidder: ${item.highestBidder.username}</p>
        <p>Auction Type: ${item.auctionType}</p>
        <p>Only the highest bidder can make their payment.</p>
    </c:if>
    <c:if test="${auctionEndedBuy}">
        <form action="<c:url value='/payment/${item.itemId}/pay'/>" method="post">
            <p>Latest Bidder: ${item.highestBidder.username}</p>
            <p>Auction Type: ${item.auctionType}</p>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <button type="submit">Make Your Payment</button>
        </form>
    </c:if><br>

    <a href="<c:url value='/catalogue'/>">Back to Catalog</a>

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
