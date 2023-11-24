<%@ page
         pageEncoding="UTF-8" %>
<%@page import="java.util.Optional" %>
<%@ page import="org.iesbelen.model.Producto" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Detalle Producto</title>
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
                    <h1>Detalle Producto</h1>
                </div>
                <div style="float: none;width: auto;overflow: hidden;min-height: 80px;position: relative;">

                    <div style="position: absolute; left: 39%; top : 39%;">

                        <form action="${pageContext.request.contextPath}/tienda/productos/">
                            <input type="submit" value="Volver"/>
                        </form>
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
                        <input value="<%= optProd.get().getIdProducto() %>" readonly="readonly"/>
                    </label>
                </div>
            </div>
            <div style="margin-top: 6px;" class="clearfix">
                <div style="float: left;width: 50%">
                    <label>Nombre</label>
                </div>
                <div style="float: none;width: auto;overflow: hidden;">
                    <label>
                        <input value="<%= optProd.get().getNombre() %>" readonly="readonly"/>
                    </label>
                </div>
                <div style="float: left;width: 50%">
                    <label>Precio</label>
                </div>
                <div style="float: none;width: auto;overflow: hidden;">
                    <label>
                        <input value="<%= optProd.get().getPrecio() %>" readonly="readonly"/>
                    </label>
                </div>
                <div style="float: left;width: 50%">
                    <label>Código fabricante</label>
                </div>
                <div style="float: none;width: auto;overflow: hidden;">
                    <label>
                        <input value="<%= optProd.get().getCodigo_fabricante() %>" readonly="readonly"/>
                    </label>
                </div>
            </div>

            <% } else {

            response.sendRedirect("productos/");

           } %>

        </div>
    </section>
</main>

<%@ include file="/WEB-INF/jsp/fragmentos/footer.jspf" %>

<%@include file="/WEB-INF/jsp/fragmentos/boostrap.jspf" %>
</body>
</html>