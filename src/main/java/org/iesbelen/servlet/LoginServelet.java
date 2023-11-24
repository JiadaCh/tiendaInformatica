package org.iesbelen.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.iesbelen.dao.UsuarioDAO;
import org.iesbelen.dao.UsuarioDAOImpl;
import org.iesbelen.model.Usuario;

import java.io.IOException;
import java.io.Serial;
import java.security.NoSuchAlgorithmException;
import java.util.Optional;

@WebServlet(name = "LoginServlet", value = "/tienda/login/*")
public class LoginServelet extends HttpServlet {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * HTTP Method: GET
     * Paths:
     * /tienda/login/
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/index.jsp");
        String pathInfo = request.getPathInfo();



        if (pathInfo == null || "/".equals(pathInfo)) {
            // GET
            // /tienda/login/
            dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuarios/login.jsp");

        }

        dispatcher.forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String __method__ = request.getParameter("__method__");

        if (__method__ == null) {

            response.sendRedirect(request.getContextPath() + "/tienda/login");

        }  else if ("login".equalsIgnoreCase(__method__)) {

            doLogin(request, response);
        } else if ("Logout".equalsIgnoreCase(__method__)) {

            request.getSession().invalidate();
            response.sendRedirect(request.getContextPath() + "/tienda/login");
        } else {
            System.out.println("Opción POST no soportada.");
            response.sendRedirect(request.getContextPath() + "/tienda/login");
        }
    }


    protected void doLogin(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        UsuarioDAO userDAO = new UsuarioDAOImpl();
        String usuario = request.getParameter("nombre");
        String contra = request.getParameter("password");

        try {
            contra = Usuario.hashPassword(contra);
            Optional<Usuario> user = userDAO.findUser(usuario, contra);
            if (user != null && user.isPresent()) {
                HttpSession session = request.getSession(true);

                session.setAttribute("usuario-logueado", user.get());

                response.sendRedirect(request.getContextPath() + "/");

            } else {
                response.sendRedirect(request.getContextPath() + "/tienda/login");

            }


        } catch (NumberFormatException nfe) {
            nfe.printStackTrace();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }


}


