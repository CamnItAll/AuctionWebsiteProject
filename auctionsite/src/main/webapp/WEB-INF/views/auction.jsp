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
        <c:when test="${item.auctionStatus == 'OPEN' && item.auctionType == 'FORWARD'}">
            <p>Time Remaining:
                <span class="countdown"
                    data-end="${item.endDate}"
                    date-ended-text="This auction is over."></span>
            </p>
        </c:when>
        <c:when test="${item.auctionStatus == 'OPEN' && item.auctionType == 'DUTCH'}">
            <p>Time until seller can update price:
                <span class="countdown"
                    data-end="${item.startDate.plusMinutes(dutchWaitTime)}"
                    date-ended-text="This auction is over."></span>
            </p>
        </c:when>
        <c:otherwise>
            <p>This auction is over.</p>
        </c:otherwise>
    </c:choose>
    <table border="1" align="center" cellpadding="8">
        <tr>
            <th>Starting Price</th>
            <td><fmt:formatNumber value="${item.startPrice}" type="currency"/></td>
        </tr>
        <tr>
            <th><c:choose>
                <c:when test="${item.auctionType == 'FORWARD'}">Highest Bid Offer</c:when>
                <c:when test="${item.auctionType == 'DUTCH'}">Latest Dutch Offer</c:when>
            </c:choose></th>
            <td><fmt:formatNumber value="${item.currentPrice}" type="currency"/></td>
        </tr>
        <tr>
            <th>Latest Bidder</th>
            <td><c:choose>
                    <c:when test="${item.highestBidder.username != null}">${item.highestBidder.username}</c:when>
                    <c:otherwise>N/A</c:otherwise>
            </c:choose></td>
        </tr>
        <tr>
            <th>Auction Type</th>
            <td>${item.auctionType}</td>
        </tr>
    </table><br>

    <c:if test="${canBid}">
        <form action="<c:url value='/auction/placeBid/${item.itemId}'/>" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <table border="1" align="center" cellpadding="8">
                <tr>
                    <th>Place Your Bid</th>
                    <td><input type="number" name="bidAmount" min="${auction.currentPrice}" step="0.01" required></td>
                </tr>
                <tr>
                    <td colspan="2"><button type="submit">Place Bid</button></td>
                </tr>
            </table>
        </form>
    </c:if>
    <c:if test="${canBuyNow}">
        <form action="<c:url value='/auction/pay/${item.itemId}'/>" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <table border="1" align="center" cellpadding="8">
                <tr>
                    <th colspan="2">Buy Now</th>
                </tr>
                <tr>
                    <td colspan="2"><button type="submit">Buy Now</button></td>
                </tr>
            </table>
        </form>
    </c:if>
    <c:if test="${isOwnerD}">
        <c:choose>
            <c:when test="${ownerCanEdit}">
                <form action="<c:url value='/auction/updateDutchPrice/${item.itemId}'/>" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <table border="1" align="center" cellpadding="8">
                        <tr>
                            <th>Update Dutch Price</th>
                            <td><input type="number" name="newPrice" value="${item.startPrice}" step="0.01" required></td>
                        </tr>
                        <tr>
                            <td colspan="2"><button type="submit">Update Price</button></td>
                        </tr>
            </table></form></c:when>
            <c:otherwise>
                <table border="1" align="center" cellpadding="8">
                    <tr><td colspan="2">Dutch prices can be lowered anytime 1 hour after the auction's start date.</td></tr>
                </table>
            </c:otherwise>
        </c:choose>
    </c:if>
    <c:if test="${isOwnerF}">
        <table border="1" align="center" cellpadding="8">
            <tr><td colspan="2">This is your forward auction.</td></tr>
        </table>
    </c:if>
    <c:if test="${auctionEnded}">
        <table border="1" align="center" cellpadding="8">
            <tr><td>Only the highest bidder can make their payment.</td></tr>
        </table>
    </c:if>
    <c:if test="${auctionEndedBuy}">
        <form action="<c:url value='/payment/${item.itemId}/pay'/>" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <table border="1" align="center" cellpadding="8">
                <tr><td><button type="submit">Make Your Payment</button></td></tr>
            </table>
        </form>
    </c:if><br>

    <c:if test="${not empty successMessage}">
        <div style="color: green; font-weight: bold;">
            ${successMessage}
        </div><br>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div style="color: red; font-weight: bold;">
            ${errorMessage}
        </div><br>
    </c:if>

    <a href="<c:url value='/catalogue'/>"><button type="button">Back to Catalog</button></a>

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
