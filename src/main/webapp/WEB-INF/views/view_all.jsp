<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ru" >
<head>
  <meta charset="windows-1251" />
  <meta content="width=device-width, initial-scale=1" name="ѕосмотретьport" />
  <title>Photos</title>

  <!-- add styles -->
  <link href="/resources/css/least.min.css" rel="stylesheet" type="text/css" />
  <link href="/resources/css/main.css" rel="stylesheet" type="text/css" />

  <!-- add scripts -->
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
  <script src="/resources/js/least.min.js"></script>
  <script src="/resources/js/jquery.lazyload.js"></script>
  <script type="text/javascript">
    $(document).ready(function(){
      $('#gallery').least();
    });
  </script>

</head>
<body>

<div class="topHeader">
  <button type="submit" onclick="window.location='/';" >Upload new photos</button>
</div>

<!--  least.js gallery -->
<section>
  <ul id="gallery">
    <c:choose>
      <c:when test="${id_set.size() ne 0}">
        <form action="/delete_or_load" method="POST">
          <input type="submit" id="butt" name="removeOrLoad" value="Remove selected">
          <input type="submit" id="butt" name="removeOrLoad" value="Load selected">

    <li id="fullPreview"></li>

    <c:forEach items="${id_set}" var="s">

      <li>
        <img data-original="/photo/${s}" src="/resources/img/effects/white.gif" />
        <input type="checkbox" name="photos_id" value="${s}"><a href="/photo/${s}"></a>


        <div class="overLayer"></div>
        <div class="infoLayer">
          <ul>
            <li><h2>Photo</h2></li>
            <li><p>ID</p></li>
            <li><p><input value="${s}"></p></li>
          </ul>
        </div>
        <div class="projectInfo">
        </div>
      </li>

    </c:forEach>

        </form>
    </c:when>

      <c:otherwise>
        <h1>Photos not found!</h1>
      </c:otherwise>

    </c:choose>

  </ul>
</section>

<!-- pcvector.net -->
<script type="text/javascript" src="http://pcvector.net/templates/pcv/js/pcvector.js"></script>
<!-- /pcvector.net -->
</body>
</html>