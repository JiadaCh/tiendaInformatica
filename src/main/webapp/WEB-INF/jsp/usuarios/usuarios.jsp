<%@ page
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
            background-position: center;
            background-size: contain;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/fragmentos/header.jspf" %>
<%@ include file="/WEB-INF/jsp/fragmentos/nav.jspf" %>
<main>
    <section>
        <div id="contenedora" style="float:none; margin: 0 auto;width: 1200px;">
            <div class="clearfix">
                <div style="float: left; width: 50%;">
                    <h1>Usuarios</h1>
                </div>
                <div style="float: none;width: auto;overflow: hidden;min-height: 82px;position: relative;">

                    <div style="position: absolute; left: 39%; top : 39%;">
                        <form action="${pageContext.request.contextPath}/usuarios/crear">
                            <input type="submit" value="Crear">
                        </form>
                    </div>
                </div>
            </div>
            <div class="clearfix">
                <hr/>
            </div>
            <div class="clearfix">
                <div style="float: left;width: 10%">Código</div>
                <div style="float: left;width: 15%">Nombre</div>
                <div style="float: left;width: 45%">Contraseña</div>
                <div style="float: left;width: 10%">Rol</div>
                <div style="float: left;width: auto;overflow: hidden;">Acción</div>
            </div>
            <div class="clearfix">
                <hr/>
            </div>
            <%
                List<Usuario> listaUsuario = (List<Usuario>) request.getAttribute("listaUsuarios");

                if (!listaUsuario.isEmpty()) {

                    for (Usuario user : listaUsuario) {
            %>

                    <div style="margin-top: 6px;" class="clearfix">
                        <div style="float: left;width: 10%"><%= user.getIdUsuario()%>
                        </div>
                        <div style="float: left;width: 15%"><%= user.getUsuario()%>
                        </div>
                        <div style="float: left;width: 45%"><%= user.getPassword()%>
                        </div>
                        <div style="float: left;width: 10%"><%= user.getRol()%>
                        </div>
                        <div style="float: none;width: auto;overflow: hidden;">
                            <form action="${pageContext.request.contextPath}/usuarios/<%= user.getIdUsuario()%>"
                                  style="display: inline;">
                                <input type="submit" value="Ver Detalle"/>
                            </form>
                            <form action="${pageContext.request.contextPath}/usuarios/editar/<%= user.getIdUsuario()%>"
                                  style="display: inline;">
                                <input type="submit" value="Editar" />
                            </form>
                            <form action="${pageContext.request.contextPath}/usuarios/borrar/" method="post"
                                  style="display: inline;">
                                <input type="hidden" name="__method__" value="delete"/>
                                <input type="hidden" name="codigo" value="<%= user.getIdUsuario()%>"/>
                                <input type="submit" value="Eliminar"  />
                            </form>
                        </div>
                    </div>
            <%
                }
            } else {
            %>
            <h2>No hay usuarios registrados</h2>
            <% } %>
        </div>
    </section>
</main>
<%@ include file="/WEB-INF/jsp/fragmentos/footer.jspf" %>

<%@include file="/WEB-INF/jsp/fragmentos/boostrap.jspf" %>

</body>
</html>