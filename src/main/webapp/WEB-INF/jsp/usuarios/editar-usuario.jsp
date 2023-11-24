<%@ page
         pageEncoding="UTF-8" %>
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
            <form action="${pageContext.request.contextPath}/usuarios/editar/" method="post">
                <input type="hidden" name="__method__" value="put"/>
                <div class="clearfix">
                    <div style="float: left; width: 50%">
                        <h1>Editar Usuario</h1>
                    </div>
                    <div style="float: none;width: auto;overflow: hidden;min-height: 80px;position: relative;">

                        <div style="position: absolute; left: 39%; top : 39%;">
                            <input type="submit" value="Guardar"/>
                        </div>

                    </div>
                </div>

                <div class="clearfix">
                    <hr/>
                </div>

                <% Optional<Usuario> optUser = (Optional<Usuario>) request.getAttribute("usuario");
                    if (optUser.isPresent()) {
                %>

                <div style="margin-top: 6px;" class="clearfix">
                    <div style="float: left;width: 50%">
                        <label>Código Usuario</label>
                    </div>
                    <div style="float: none;width: auto;overflow: hidden;">
                        <label>
                            <input name="codigo" value="<%= optUser.get().getIdUsuario() %>" readonly="readonly"/>
                        </label>
                    </div>
                </div>
                <div style="margin-top: 6px;" class="clearfix">
                    <div style="float: left;width: 50%">
                        <label>Nombre</label>
                    </div>
                    <div style="float: none;width: auto;overflow: hidden;">
                        <label>
                            <input name="nombre" value="<%= optUser.get().getUsuario() %>"/>
                        </label>
                    </div>
                    <div style="float: left;width: 50%">
                        <label>Contraseña</label>
                    </div>
                    <div style="float: none;width: auto;overflow: hidden;">
                        <label>
                            <input name="password" value="<%= optUser.get().getPassword() %>" readonly="readonly"/>
                        </label>
                    </div>
                    <div style="margin-top: 6px;" class="clearfix">
                        <div style="float: left;width: 50%">
                            Rol:
                        </div>
                        <div style="float: none;width: auto;overflow: hidden;">
                            <label>
                                <select name="rol">
                                    <option value="Administrador">Administrador</option>
                                    <option value="Cliente">Cliente</option>
                                    <option value="Vendedor">Vendedor</option>
                                </select>
                            </label>
                        </div>
                    </div>
                </div>

                <% } else { %>

                request.sendRedirect("usuarios/");

                <% } %>
            </form>
        </div>

    </section>
</main>
<%@ include file="/WEB-INF/jsp/fragmentos/footer.jspf" %>

<%@include file="/WEB-INF/jsp/fragmentos/boostrap.jspf" %>

</body>
</html>