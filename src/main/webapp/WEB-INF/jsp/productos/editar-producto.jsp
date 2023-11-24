<%@ page
         pageEncoding="UTF-8" %>
<%@page import="java.util.Optional" %>
<%@ page import="org.iesbelen.model.Producto" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Producto</title>
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
            <form action="${pageContext.request.contextPath}/tienda/productos/editar/" method="post">
                <input type="hidden" name="__method__" value="put"/>
                <div class="clearfix">
                    <div style="float: left; width: 50%">
                        <h1>Editar Producto</h1>
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

                <% Optional<Producto> optProd = (Optional<Producto>) request.getAttribute("producto");
                    if (optProd.isPresent()) {
                %>

                <div style="margin-top: 6px;" class="clearfix">
                    <div style="float: left;width: 50%">
                        <label>Código Producto</label>
                    </div>
                    <div style="float: none;width: auto;overflow: hidden;">
                        <label>
                            <input name="codigoProd" value="<%= optProd.get().getIdProducto() %>" readonly="readonly"/>
                        </label>
                    </div>
                </div>
                <div style="margin-top: 6px;" class="clearfix">
                    <div style="float: left;width: 50%">
                        <label>Nombre</label>
                    </div>
                    <div style="float: none;width: auto;overflow: hidden;">
                        <label>
                            <input name="nombre" value="<%= optProd.get().getNombre() %>"/>
                        </label>
                    </div>
                    <div style="float: left;width: 50%">
                        <label>Precio</label>
                    </div>
                    <div style="float: none;width: auto;overflow: hidden;">
                        <label>
                            <input name="precio" value="<%= optProd.get().getPrecio() %>" readonly="readonly"/>
                        </label>
                    </div>
                    <div style="float: left;width: 50%">
                        <label>Código fabricante</label>
                    </div>
                    <div style="float: none;width: auto;overflow: hidden;">
                        <label>
                            <input name="codigoFab" value="<%= optProd.get().getCodigo_fabricante() %>"
                                   readonly="readonly"/>
                        </label>
                    </div>
                </div>

                <% } else { %>

                request.sendRedirect("fabricantes/");

                <% } %>
            </form>
        </div>
    </section>
</main>

<%@ include file="/WEB-INF/jsp/fragmentos/footer.jspf" %>

<%@include file="/WEB-INF/jsp/fragmentos/boostrap.jspf" %>

</body>
</html>