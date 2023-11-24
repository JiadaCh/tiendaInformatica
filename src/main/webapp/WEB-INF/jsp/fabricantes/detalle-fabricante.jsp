<%@ page language="java"
         pageEncoding="UTF-8" %>
<%@page import="org.iesbelen.model.Fabricante" %>
<%@page import="java.util.Optional" %>
<%@ page import="org.iesbelen.dto.FabricanteDTO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Detalle Fabricante</title>
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
            background-position:center;
            background-size: contain;
            background-color: wheat;
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
                    <h1>Detalle Fabricante</h1>
                </div>
                <div style="float: none;width: auto;overflow: hidden;min-height: 80px;position: relative;">

                    <div style="position: absolute; left: 39%; top : 39%;">

                        <form action="${pageContext.request.contextPath}/tienda/fabricantes">
                            <input type="submit" value="Volver"/>
                        </form>
                    </div>

                </div>
            </div>

            <div class="clearfix">
                <hr/>
            </div>

            <% Optional<FabricanteDTO> optFab = (Optional<FabricanteDTO>) request.getAttribute("fabricante");
                if (optFab.isPresent()) {
            %>

            <div style="margin-top: 6px;" class="clearfix">
                <div style="float: left;width: 50%">
                    <label>Código</label>
                </div>
                <div style="float: none;width: auto;overflow: hidden;">
                    <input value="<%= optFab.get().getIdFabricante() %>" readonly="readonly"/>
                </div>
            </div>
            <div style="margin-top: 6px;" class="clearfix">
                <div style="float: left;width: 50%">
                    <label>Nombre</label>
                </div>
                <div style="float: none;width: auto;overflow: hidden;">
                    <input value="<%= optFab.get().getNombre() %>" readonly="readonly"/>
                </div>
            </div>
            <div style="margin-top: 6px;" class="clearfix">
                <div style="float: left;width: 50%">
                    <label>Numero de productos</label>
                </div>
                <div style="float: none;width: auto;overflow: hidden;">
                    <input value="<%= optFab.get().getNumProductos() %>" readonly="readonly"/>
                </div>
            </div>

            <% } else {

            response.sendRedirect("fabricantes/");

             } %>

        </div>
    </section>
</main>

<%@ include file="/WEB-INF/jsp/fragmentos/footer.jspf" %>

<%@include file="/WEB-INF/jsp/fragmentos/boostrap.jspf" %>
</body>
</html>