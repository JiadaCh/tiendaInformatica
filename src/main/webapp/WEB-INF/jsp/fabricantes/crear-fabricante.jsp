<%@ page language="java"
         pageEncoding="UTF-8" %>
<%@page import="org.iesbelen.model.Fabricante" %>
<%@page import="java.util.Optional" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Crear Fabricante</title>
    <style>

        input{
            background-color: #d3d3d0;
            border-radius: 3px;
        }
        .clearfix::after {
            content: "";
            display: block;
            clear: both;
        }
        body {
            background-color: wheat;
             margin: 0 auto;
             background-position:center;
             background-size: contain;
         }

    </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/fragmentos/header.jspf" %>
<%@ include file="/WEB-INF/jsp/fragmentos/nav.jspf" %>
<main>
    <section>
        <div id="contenedora" style="float:none; margin: 0 auto;width: 900px;">

            <div class="clearfix">
                <div style="float: left; width: 50%">
                    <h1>Crear Fabricante</h1>
                </div>
                <div style="float: none;width: auto;overflow: hidden;min-height: 80px;position: relative;">


                    <div style="position: absolute; left: 52%; top : 39%;">
                        <form action="${pageContext.request.contextPath}/tienda/fabricantes/">
                            <input type="submit" value="Volver"/>
                        </form>
                    </div>
                </div>
            </div>

            <div class="clearfix">
                <hr/>
            </div>
            <form action="${pageContext.request.contextPath}/tienda/fabricantes/crear/" method="post">
                <div style="float: none;width: auto;position: relative;">

                    <div style="position: absolute;left: 70%;margin-top: -66.7px">
                        <input type="submit" value="Crear"/>
                    </div>
                </div>
                <div style="margin-top: 6px;" class="clearfix">
                    <div style="float: left;width: 50%">
                        Nombre
                    </div>
                    <div style="float: none;width: auto;overflow: hidden;">
                        <label>
                            <input type="text" name="nombre"/>
                        </label>
                    </div>
                </div>

            </form>
        </div>
    </section>
</main>

<%@ include file="/WEB-INF/jsp/fragmentos/footer.jspf" %>

<%@include file="/WEB-INF/jsp/fragmentos/boostrap.jspf" %>
</body>
</html>