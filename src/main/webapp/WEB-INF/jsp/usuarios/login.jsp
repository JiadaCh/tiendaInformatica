<%@ page language="java"
         pageEncoding="UTF-8" %>
<%@page import="java.util.List" %>
<%@ page import="org.iesbelen.model.Usuario" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Usuarios</title>
    <style>
        input {
            background-color: rgba(211, 211, 208, 0.78);
            border: 1px solid black;
            border-radius: 3px;
            margin: 15px auto;
        }

        .clearfix::after {
            content: "";
            display: block;
            clear: both;
        }

        body {
            background-color: wheat;
            margin: 0 auto;
            background-position: center;
            background-size: contain;
        }
        form{
            display: flex;
            margin: 0 auto;
            flex-direction: column;
            align-content: center;
            text-align: center;
            font-size: 18px;
        }

        #login{
            padding: 5px;
            width: 150px;
        }
        #contenedora{
            color: #0d9ff8;
            border: 1px solid black;
            border-radius: 5px;
            box-shadow: 2px 2px 5px 5px rgba(59, 58, 58, 0.51);
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/fragmentos/header.jspf" %>
<%@ include file="/WEB-INF/jsp/fragmentos/nav.jspf" %>
<main>
    <section>
        <div id="contenedora" style="float:none; margin: 15px auto;width: 350px;background-color: #2b2d30;">
            <div class="clearfix">
                <div style="padding: 5px ;font-size: 25px;text-align: center">
                    <h1>Login</h1>
                </div>
            </div>
            <div style="margin-top: 6px;" class="clearfix">
                <form action="${pageContext.request.contextPath}/tienda/login"  method="post">
                    <div style="margin-top: 6px;" class="clearfix">
                        <label style="float: none;">
                            Usuario:
                            <input name="nombre" placeholder="Usuario"/>
                        </label>
                    </div>

                    <div style="margin-top: 6px;" class="clearfix">

                        <label style="margin-left: -23px">
                            Contraseña:
                            <input name="password" placeholder="contraseña"/>
                        </label>
                    </div>
                    <input id="login" type="submit" name="__method__" style="margin-bottom: 25px" value="Login"/>
                </form>
            </div>

        </div>
    </section>
</main>
<%@ include file="/WEB-INF/jsp/fragmentos/footer.jspf" %>

<%@include file="/WEB-INF/jsp/fragmentos/boostrap.jspf" %>

</body>
</html>