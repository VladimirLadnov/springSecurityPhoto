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
  <link rel="stylesheet" type="text/css" href="/resources/css/normalize.css" />
  <link rel="stylesheet" type="text/css" href="/resources/css/vicons-font.css" />
  <link rel="stylesheet" type="text/css" href="/resources/css/base.css" />
  <link rel="stylesheet" type="text/css" href="/resources/css/buttons.css" />

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
  <button type="submit" class="button button--wayra button--border-medium button--text-upper button--size-s button--text-thick button--inverted" onclick="window.location='/';" >Upload new photos</button>
</div>


<!--  least.js gallery -->
<section>
  <ul id="gallery">
    <c:choose>
      <c:when test="${id_set.size() ne 0}">

          <form action="/delete_or_load" method="POST" style="margin-top: 100px">
            <button type="submit" name="removeOrLoad" value="Remove selected" class="button button--wayra button--border-medium button--text-upper button--size-s button--text-thick button1--inverted">Remove selected</button>
            <button type="submit" name="removeOrLoad" value="Load selected" class="button button--wayra button--border-medium button--text-upper button--size-s button--text-thick button2--inverted">Load selected</button>

    <li id="fullPreview"></li>

    <c:forEach items="${id_set}" var="s">

      <li>
        <img data-original="/photo/${s}" src="/resources/img/effects/white.gif" />
        <input type="checkbox" id="check" name="photos_id" value="${s}"><a href="/photo/${s}"></a>


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