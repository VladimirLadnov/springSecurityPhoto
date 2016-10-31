<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Photos</title>
  <link href="/resources/css/view_all.css" rel="stylesheet">

</head>

<body>
<div align="center">
 <!-- <input type="submit" value="Back" onclick="window.location='/';" /> -->
  <button type="submit" onclick="window.location='/';" class="button1">Back</button>
  <c:choose>

    <c:when test="${id_set.size() ne 0}">
      <form action="/delete_or_load" method="POST">
        <table>
          <c:forEach items="${id_set}" var="s">
            <table>
              <tr>
              <th><input type="checkbox" name="photos_id" value="${s}"></th>
              <td><img src="/photo/${s}" width="150" height="100" onmouseover="bigImg(this)" border="0"
                      onmouseout="normalImg(this)"/>
              </td>
              <th><c:out value="${s}"/></th>
              </tr>
            </table>
          </c:forEach>
        </table>



        <input type="submit" id="butt" name="removeOrLoad" value="Remove selected">
        <input type="submit" id="butt" name="removeOrLoad" value="Load selected">
      </form>
    </c:when>

    <c:otherwise>
      <h1>Photos not found!</h1>
    </c:otherwise>

  </c:choose>
  <script>
    function bigImg(x) {
      x.style.height = "600px";
      x.style.width = "950px";
    }
    function normalImg(x) {
      x.style.height = "100px";
      x.style.width = "155px";
    }


  </script>


</div>
</body>

</html>
