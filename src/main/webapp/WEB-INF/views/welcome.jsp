<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Welcome</title>

  <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div align="center">
  <form id="logoutForm" method="post" action="${contextPath}/logout">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
  </form>
  <h2>Welcome ${pageContext.request.userPrincipal.name} | <a onclick="document.forms['logoutForm'].submit()">Logout</a>
  </h2>
  <!--показать уже загруженную фотку по id -->
  <form action="/view" method="POST">
    Photo id: <input type="text" name="photo_id">
    <input type="submit" />
  </form>
  <!--загрузить новую фотку -->
  <form action="/add_photo" enctype="multipart/form-data" method="POST">

<span id="table">
    <table border=0 cellspacing=0 cellpadding=3>
      <tr>
        <th><a href="#" onclick="return addline();">add more</a></th>
      </tr>
      <tr id="newline" nomer="[0]">
        <td>Photo: <input type="file" name="photo">
        </td>
      </tr>
    </table>
</span>

    <script>
      var c=0;
      function addline()
      {
        c++;
        s=document.getElementById('table').innerHTML;
        s=s.replace(/[\r\n]/g,'');
        re=/(.*)(<tr id=.*>)(<\/table>)/gi;
        re2=/\[\d+\]/gi;
        s1=s.replace(re,'$2');
        s2=s1.replace(re2,'['+c+']');
        s2=s2.replace(/(rmline\()(\d+\))/gi,'$1'+c+')');
        s=s.replace(re,'$1$2'+s2+'$3');
        document.getElementById('table').innerHTML=s;
        return false;
      }
    </script>

    <input type="submit" />
  </form>

  <input type="submit" value="Show all photos" onclick="window.location='/view_all';" />
</div>
</body>
</html>