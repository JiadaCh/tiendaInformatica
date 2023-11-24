<%@ page language="java" pageEncoding="UTF-8" %>
<%@page import="org.iesbelen.model.Fabricante" %>
<%@page import="java.util.List" %>
<%@ page import="org.iesbelen.dto.FabricanteDTO" %>
<%@ page import="java.util.Objects" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fabricantes</title>
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
            margin: 0 auto;
            background-color: wheat;
            background-position:center;
            background-size: contain;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/fragmentos/header.jspf" %>
<%@ include file="/WEB-INF/jsp/fragmentos/nav.jspf" %>
<%
    String modo = (String) request.getAttribute("modo");
    String ordenarPor =  (String)request.getAttribute("ordenarPor");
    if (modo == null){
        modo = "";
    }
    if (ordenarPor == null){
        ordenarPor = "";
    }
%>
<main>
    <section>
        <div id="contenedora" style="float:none; margin: 0 auto;width: 1000px;">
            <div class="clearfix">
                <div style="float: left; width: 50% ;">
                    <h1>Fabricantes</h1>
                    <div style="float: none;width: 100%;position: relative;padding-bottom: 10px">
                        <div style="position: absolute;left: 3%">
                            <form action="${pageContext.request.contextPath}/tienda/fabricantes/" method="get">
                                <label>
                                    Ordenar por:
                                    <select name="ordenarPor" style="margin-right: 5px" onchange="this.form.submit()">
                                        <option value="codigo">Código</option>
                                        <% if ("nombre".equals(ordenarPor)){%>
                                            <option value="nombre" selected>Nombre</option>
                                        <%}else{%>
                                            <option value="nombre">Nombre</option>
                                        <%}%>

                                    </select>
                                </label>

                                <label>
                                    Modo:
                                    <select name="modo" style="margin-right: 5px" onchange="this.form.submit()">

                                            <option value="asc">Asc</option>

                                        <% if ("desc".equals(modo)){%>
                                            <option value="desc" selected>Desc</option>
                                        <%}else{%>
                                            <option value="desc">Desc</option>
                                        <%}%>

                                    </select>
                                </label>
                            </form>
                        </div>
                    </div>
                </div>


                <div style="float: none;width: auto;overflow: hidden;min-height: 82px;position: relative;">

                    <div style="position: absolute; left: 39%; top : 39%;">
                        <form action="${pageContext.request.contextPath}/tienda/fabricantes/crear">
                            <input type="submit" value="Crear" <%=deshabilitar%>>
                        </form>
                    </div>
                </div>
            </div>
            <div class="clearfix">
                <br>
                <hr/>
            </div>
            <div class="clearfix">
                <div style="float: left;width: 10%">Código</div>
                <div style="float: left;width: 25%">Nombre</div>
                <div style="float: left;width: 25%">Números de Productos</div>
                <div style="float: none;width: auto;overflow: hidden;">Acción</div>
            </div>
            <div class="clearfix">
                <hr/>
            </div>
                <%
	List<FabricanteDTO> listaFabricante = (List<FabricanteDTO>)request.getAttribute("listaFabricantes");
        if (listaFabricante != null &&!listaFabricante.isEmpty()) {

            for (FabricanteDTO fabricante : listaFabricante) {
    %>
            <div style="margin-top: 6px;" class="clearfix">
                <div style="float: left;width: 10%"><%= fabricante.getIdFabricante()%>
                </div>
                <div style="float: left;width: 25%"><%= fabricante.getNombre()%>
                </div>
                <div style="float: left;width: 25%"><%= fabricante.getNumProductos()%>
                </div>
                <div style="float: none;width: auto;overflow: hidden;">
                    <form action="${pageContext.request.contextPath}/tienda/fabricantes/<%= fabricante.getIdFabricante()%>"
                          style="display: inline;">
                        <input type="submit" value="Ver Detalle"/>
                    </form>
                    <form action="${pageContext.request.contextPath}/tienda/fabricantes/editar/<%= fabricante.getIdFabricante()%>"
                          style="display: inline;">
                        <input type="submit" value="Editar" <%=deshabilitar%>/>
                    </form>
                    <form action="${pageContext.request.contextPath}/tienda/fabricantes/borrar/" method="post"
                          style="display: inline;">
                        <input type="hidden" name="__method__" value="delete"/>
                        <input type="hidden" name="codigo" value="<%= fabricante.getIdFabricante()%>"/>
                        <input type="submit" value="Eliminar" <%=deshabilitar%>/>
                    </form>
                </div>
            </div>
                <%
            }
        } else {
    %>
            <h2>No hay registros de Fabricantes</h2>
                <%
		}
    %>
    </section>
</main>

<%@ include file="/WEB-INF/jsp/fragmentos/footer.jspf" %>

<%@include file="/WEB-INF/jsp/fragmentos/boostrap.jspf" %>

</body>
</html>