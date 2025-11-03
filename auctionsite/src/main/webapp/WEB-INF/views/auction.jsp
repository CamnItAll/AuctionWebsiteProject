<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
    <p>Current Price: $${item.currentPrice}</p>

    <p>D${isOwnerD} F${isOwnerF} Bid${canBid} Buy${canBuyNow} E${auctionEnded} EB${auctionEndedBuy}</p>
    <c:if test="${canBid}">
        <form action="<c:url value='/auction/placeBid/${item.itemId}'/>" method="post">
            <p>Latest Bidder: ${item.highestBidder.username}</p>
            <p>Auction Type: ${item.auctionType}</p>
            <p>Time Remaining: ${item.endDate}</p>
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
        <p>This auction is over.</p>
    </c:if>
    <c:if test="${auctionEndedBuy}">
        <form action="<c:url value='/auction/updateDutchPrice/${item.itemId}'/>" method="post">
            <p>Latest Bidder: ${item.highestBidder.username}</p>
            <p>Auction Type: ${item.auctionType}</p>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <button type="submit">Make Your Payment</button>
        </form>
    </c:if><br>

    <a href="<c:url value='/catalogue'/>">Back to Catalog</a>
</body>
</html>
