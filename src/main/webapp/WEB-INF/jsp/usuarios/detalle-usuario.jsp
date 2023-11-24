<%@ page language="java"
         pageEncoding="UTF-8" %>
<%@page import="java.util.List" %>
<%@ page import="org.iesbelen.model.Usuario" %>
<%@ page import="java.util.Optional" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Usuarios</title>
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
                    <h1>Detalle Usuario</h1>
                </div>
                <div style="float: none;width: auto;overflow: hidden;min-height: 80px;position: relative;">

                    <div style="position: absolute; left: 52%; top : 39%;">
                        <form action="${pageContext.request.contextPath}/usuarios/">
                            <input type="submit" value="Volver"/>
                        </form>
                    </div>

                </div>
            </div>

            <div class="clearfix">
                <hr/>
            </div>

                <div style="margin-top: 6px;" class="clearfix">
                    <% Optional<Usuario> optUser = (Optional<Usuario>) request.getAttribute("usuario");
                        if (optUser.isPresent()) {
                    %>

                    <div style="margin-top: 6px;" class="clearfix">
                        <div style="float: left;width: 50%">
                            <label>Código Usuario</label>
                        </div>
                        <div style="float: none;width: auto;overflow: hidden;">
                            <input value="<%= optUser.get().getIdUsuario() %>" readonly="readonly"/>
                        </div>
                    </div>
                    <div style="margin-top: 6px;" class="clearfix">
                        <div style="float: left;width: 50%">
                            <label>Usuario</label>
                        </div>
                        <div style="float: none;width: auto;overflow: hidden;">
                            <input value="<%= optUser.get().getUsuario() %>" readonly="readonly"/>
                        </div>
                        <div style="float: left;width: 50%">
                            <label>Contraseña</label>
                        </div>
                        <div style="float: none;width: auto;overflow: hidden;">
                            <input value="<%=  optUser.get().getPassword() %>" readonly="readonly"/>
                        </div>
                        <div style="float: left;width: 50%">
                            <label>Rol</label>
                        </div>
                        <div style="float: none;width: auto;overflow: hidden;">
                            <input value="<%= optUser.get().getRol() %>" readonly="readonly"/>
                        </div>
                    </div>

                    <% } else {

                            response.sendRedirect("usuarios/");

                   } %>
                </div>
                </div>
    </section>
</main>
<%@ include file="/WEB-INF/jsp/fragmentos/footer.jspf" %>

<%@include file="/WEB-INF/jsp/fragmentos/boostrap.jspf" %>

</body>
</html>