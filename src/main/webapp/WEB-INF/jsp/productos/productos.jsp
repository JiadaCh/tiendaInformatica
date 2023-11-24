<%@ page
         pageEncoding="UTF-8" %>
<%@page import="java.util.List" %>
<%@ page import="org.iesbelen.model.Producto" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Productos</title>
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
    <%@include file="/WEB-INF/jsp/fragmentos/boostrap.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jsp/fragmentos/header.jspf" %>
<%@ include file="/WEB-INF/jsp/fragmentos/nav.jspf" %>
<main>
    <section>
        <div id="contenedora" style="float:none; margin: 0 auto;width: 900px;">
            <div class="clearfix">
                <div style="float: left; width: 50%; margin-bottom: 25px">
                    <h1>Productos</h1>

                </div>
                <div style="float: none;position: relative">
                    <div style="position: absolute; left: 2%;margin-top: 7%">
                        <form action="${pageContext.request.contextPath}/tienda/productos/" method="get">

                                <i class="bi bi-search"></i>


                            <label>
                                <input type="text" name="filtrar-por-nombre" placeholder="Nombre del producto"
                                       enterkeyhint="enter" autofocus autocomplete="disabled">
                            </label>
                        </form>
                    </div>
                </div>
                <div style="float: none;width: auto;overflow: hidden;min-height: 82px;position: relative;">

                    <div style="position: absolute; left: 39%; top : 39%;">
                        <form action="${pageContext.request.contextPath}/tienda/productos/crear">
                            <input type="submit" value="Crear" <%=deshabilitar%>>
                        </form>
                    </div>

                </div>
            </div>
            <div class="clearfix">
                <hr/>
            </div>
            <div class="clearfix">
                <div style="float: left;width: 10%">Código</div>
                <div style="float: left;width: 30%">Nombre</div>
                <div style="float: left;width: 20%">Precio</div>
                <div style="float: left;width: 20%;overflow: hidden;">Acción</div>
            </div>
            <div class="clearfix">
                <hr/>
            </div>
            <%
                List<Producto> listaProducto = (List<Producto>) request.getAttribute("listaProductos");

                if (listaProducto != null && !listaProducto.isEmpty()) {

                    for (Producto producto : listaProducto) {
            %>

            <div style="margin-top: 6px;" class="clearfix">
                <div style="float: left;width: 10%"><%= producto.getIdProducto()%>
                </div>
                <div style="float: left;width: 30%"><%= producto.getNombre()%>
                </div>
                <div style="float: left;width: 20%"><%= producto.getPrecio()%>
                </div>
                <div style="float: none;width: auto;overflow: hidden;">
                    <form action="${pageContext.request.contextPath}/tienda/productos/<%= producto.getIdProducto()%>"
                          style="display: inline;">
                        <input type="submit" value="Ver Detalle"/>
                    </form>
                    <form action="${pageContext.request.contextPath}/tienda/productos/editar/<%= producto.getIdProducto()%>"
                          style="display: inline;">
                        <input type="submit" value="Editar" <%=deshabilitar%>/>
                    </form>
                    <form action="${pageContext.request.contextPath}/tienda/productos/borrar/" method="post"
                          style="display: inline;">
                        <input type="hidden" name="__method__" value="delete"/>
                        <input type="hidden" name="codigo" value="<%= producto.getIdProducto()%>"/>
                        <input type="submit" value="Eliminar" <%=deshabilitar%>/>
                    </form>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <h2>No hay registros de producto</h2>
            <% } %>
        </div>
    </section>
</main>
<%@ include file="/WEB-INF/jsp/fragmentos/footer.jspf" %>



</body>
</html>