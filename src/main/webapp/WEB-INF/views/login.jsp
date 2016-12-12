<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Log in with your account</title>

  <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
  <link href="${contextPath}/resources/css/common.css" rel="stylesheet">

  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <style>
    a.colorfdkjgjdf{
      background-color: #39f;
      background: #000;
      color: #DDD;
      background: #212121;
    }
    @-webkit-keyframes colors {
      0% {background-color: #39f;}
      15% {background-color: #F246C9;}
      30% {background-color: #4453F2;}
      45% {background-color: #44F262;}
      60% {background-color: #F257D4;}
      75% {background-color: #EDF255;}
      90% {background-color: #F20006;}
      100% {background-color: #39f;}
    }
    body{
      background: #212121;
    }
    a.color{
      color:#999;
    }
    button.color, #log{
      color: #999;
      background-color: #000;
    }
  </style>

</head>

<body>

<div>


  <form method="POST" action="${contextPath}/login" class="form-signin">
    <h2 class="form-heading"></h2>

    <div class="form-group ${error != null ? 'has-error' : ''}">
      <span>${message}</span>
      <input name="username" type="text" class="form-control" placeholder="Username"
             autofocus="true"/>
      <input name="password" type="password" class="form-control" placeholder="Password"/>
      <span>${error}</span>
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

      <button class="btn btn-lg btn-primary btn-block color" type="submit">Log In</button>
      <h4 class="text-center"><a class="color" href="${contextPath}/registration">Create an account</a></h4>
    </div>

  </form>

</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>