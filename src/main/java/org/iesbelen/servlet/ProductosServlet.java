package org.iesbelen.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.iesbelen.dao.FabricanteDAO;
import org.iesbelen.dao.FabricanteDAOImpl;
import org.iesbelen.dao.ProductoDAO;
import org.iesbelen.dao.ProductoDAOImpl;
import org.iesbelen.model.Producto;

import java.io.IOException;
import java.io.Serial;
import java.util.List;

@WebServlet(name = "productosServlet", value = "/tienda/productos/*")
public class ProductosServlet extends HttpServlet {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * HTTP Method: GET
     * Paths:
     * /productos/
     * /productos/{id}
     * /productos/editar{id}
     * /productos/crear
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher dispatcher;

        String pathInfo = request.getPathInfo(); //

        if (pathInfo == null || "/".equals(pathInfo)) {
            ProductoDAOImpl prodDAO = new ProductoDAOImpl();
            String name = request.getParameter("filtrar-por-nombre");
            //GET
            //	/productos/
            //	/productos

            if (name == null || name.isBlank()){
                request.setAttribute("listaProductos", prodDAO.getAll());
            }else {
                List<Producto> prod;
                name = "%"+name+"%";
                prod = prodDAO.getByName(name);
                /*prod = prodDAO.getAll()
                        .stream()
                        .filter(producto -> producto.getNombre()
                                .toLowerCase()
                                .contains(name.toLowerCase()))
                        .toList();*/
                request.setAttribute("listaProductos", prod);
            }

            dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/productos/productos.jsp");

        } else {
            // GET
            // 		/productos/{id}
            // 		/productos/{id}/
            // 		/productos/edit/{id}
            // 		/productos/edit/{id}/
            // 		/productos/crear
            // 		/productos/crear/

            pathInfo = pathInfo.replaceAll("/$", "");
            String[] pathParts = pathInfo.split("/");

            if (pathParts.length == 2 && "crear".equals(pathParts[1])) {
                FabricanteDAO fabDAO = new FabricanteDAOImpl();
                // GET
                // /productos/crear

                try {
                    request.setAttribute("listaFabricantes", fabDAO.getAll());

                    dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/productos/crear-producto.jsp");
                } catch (NumberFormatException nfe) {
                    nfe.printStackTrace();
                    dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/productos/productos.jsp");
                }

            } else if (pathParts.length == 2) {
                ProductoDAO prodDAO = new ProductoDAOImpl();
                // GET
                // /productos/{id}
                try {

                    request.setAttribute("producto", prodDAO.find(Integer.parseInt(pathParts[1])));
                    dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/productos/detalle-producto.jsp");

                } catch (NumberFormatException nfe) {
                    nfe.printStackTrace();
                    dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/productos/productos.jsp");
                }

            } else if (pathParts.length == 3 && "editar".equals(pathParts[1])) {
                ProductoDAO prodDAO = new ProductoDAOImpl();

                // GET
                // /productos/editar/{id}
                try {
                    request.setAttribute("producto", prodDAO.find(Integer.parseInt(pathParts[2])));
                    dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/productos/editar-producto.jsp");

                } catch (NumberFormatException nfe) {
                    nfe.printStackTrace();
                    dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/productos/productos.jsp");
                }


            } else {
                dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/productos/productos.jsp");

            }

        }

        dispatcher.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String __method__ = request.getParameter("__method__");

        if (__method__ == null) {
            // Crear uno nuevo
            ProductoDAO fabDAO = new ProductoDAOImpl();

            String nombre = request.getParameter("nombre");
            String precio = request.getParameter("precio");
            String fab = request.getParameter("idFabricante");
            Producto nuevoProd = new Producto();
            nuevoProd.setNombre(nombre);
            nuevoProd.setPrecio(Double.parseDouble(precio));
            nuevoProd.setCodigo_fabricante(Integer.parseInt(fab));
            fabDAO.create(nuevoProd);

        } else if ("put".equalsIgnoreCase(__method__)) {
            // Actualizar uno existente
            //Dado que los forms de html sólo soportan method GET y POST utilizo parámetro oculto para indicar la operación de actulización PUT.
            doPut(request, response);

        } else if ("delete".equalsIgnoreCase(__method__)) {
            // Actualizar uno existente
            //Dado que los forms de html sólo soportan method GET y POST utilizo parámetro oculto para indicar la operación de actulización DELETE.
            doDelete(request, response);

        } else {

            System.out.println("Opción POST no soportada.");
        }

        //response.sendRedirect("../../../tienda/productos");
        response.sendRedirect(request.getContextPath() + "/tienda/productos");
    }


    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) {

        ProductoDAO prodDAO = new ProductoDAOImpl();
        String codigoProd = request.getParameter("codigoProd");
        String nombre = request.getParameter("nombre");
        String precio = request.getParameter("precio");
        String codigoFab = request.getParameter("codigoFab");
        Producto prod = new Producto();

        try {

            int id = Integer.parseInt(codigoProd);
            prod.setIdProducto(id);
            prod.setNombre(nombre);
            prod.setPrecio(Double.parseDouble(precio));
            prod.setCodigo_fabricante(Integer.parseInt(codigoFab));
            prodDAO.update(prod);

        } catch (NumberFormatException nfe) {
            nfe.printStackTrace();
        }

    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) {
        ProductoDAO proDAO = new ProductoDAOImpl();
        String codigo = request.getParameter("codigo");

        try {

            int id = Integer.parseInt(codigo);

            proDAO.delete(id);

        } catch (NumberFormatException nfe) {
            nfe.printStackTrace();
        }
    }
}
