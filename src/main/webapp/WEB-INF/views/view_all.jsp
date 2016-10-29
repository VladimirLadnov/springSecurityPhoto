<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Photos</title>
</head>
<body>
<div align="center">

  <c:choose>

    <c:when test="${id_set.size() ne 0}">
      <form action="/delete_or_load" method="POST">
        <table>
          <c:forEach items="${id_set}" var="s">
            <tr>
              <th><input type="checkbox" name="photos_id" value="${s}"></th>
              <td><img src="/photo/${s}" width="150" height="100" /></td>
              <th><c:out value="${s}"/></th>
            </tr>
          </c:forEach>
        </table>
        <input type="submit" name="removeOrLoad" value="Remove selected">
        <input type="submit" name="removeOrLoad" value="Load selected">
      </form>
    </c:when>

    <c:otherwise>
      <h1>Photos not found!</h1>
    </c:otherwise>

  </c:choose>

  <input type="submit" value="Back" onclick="window.location='/';" />
</div>
</body>
</html>
