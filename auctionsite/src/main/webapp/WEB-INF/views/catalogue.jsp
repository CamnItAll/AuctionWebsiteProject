<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    </form>
    
    <c:if test="${empty items}">
        <p>No items found.</p>
    </c:if>
    <c:forEach var="item" items="${items}">
        <form action="<c:url value='/auction/${item.itemId}'/>" method="get">
            <p>${item.name}</p>
            <p>${item.description}</p>
            <p>Start Price: ${item.startPrice}</p>
            <p>Auction Type: ${item.auctionType}</p>
            <button type="submit">Bid on ${item.name}</button>
        </form>
    </c:forEach>
    <a href="<c:url value='/catalogue/new'/>">
        <button>Create New Auction</button>
    </a>
  </div>
  <div class="container">
      <button onclick="document.forms['logoutForm'].submit()">Click here to logout.</button>
  </div>
</body>
</html>