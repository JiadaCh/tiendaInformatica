package org.iesbelen.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.iesbelen.dao.UsuarioDAO;
import org.iesbelen.dao.UsuarioDAOImpl;
import org.iesbelen.model.Usuario;

import java.io.IOException;
import java.io.Serial;
import java.security.NoSuchAlgorithmException;
import java.util.Optional;

@WebServlet(name = "UsuariosServlet", value = "/usuarios/*")
public class UsuariosServlet extends HttpServlet {

	@Serial
	private static final long serialVersionUID = 1L;

	/**
	 * HTTP Method: GET
	 * Paths:
	 * 		/usuarios/
	 * 		/usuarios/{id}
	 * 		/usuarios/editar{id}
	 * 		/usuarios/crear
	 *
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		RequestDispatcher dispatcher;

		String pathInfo = request.getPathInfo(); //

		if (pathInfo == null || "/".equals(pathInfo)) {
			UsuarioDAO userDAO = new UsuarioDAOImpl();

			//GET
			//	/usuarios/
			//	/usuarios

			request.setAttribute("listaUsuarios", userDAO.getAll());
			dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuarios/usuarios.jsp");

		} else {
			// GET
			// 		/usuarios/{id}
			// 		/usuarios/{id}/
			// 		/usuarios/edit/{id}
			// 		/usuarios/edit/{id}/
			// 		/usuarios/crear
			// 		/usuarios/crear/

			pathInfo = pathInfo.replaceAll("/$", "");
			String[] pathParts = pathInfo.split("/");

			if (pathParts.length == 2 && "crear".equals(pathParts[1])) {

				// GET
				// /usuarios/crear
				dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuarios/crear-usuario.jsp");

			} else if (pathParts.length == 2) {
				UsuarioDAO userDAO = new UsuarioDAOImpl();

				// GET
				// /usuarios/{id}
				try {

					request.setAttribute("usuario",userDAO.find(Integer.parseInt(pathParts[1])));

					dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuarios/detalle-usuario.jsp");

				} catch (NumberFormatException nfe) {
					nfe.printStackTrace();
					dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuarios/usuarios.jsp");
				}

			} else if (pathParts.length == 3 && "editar".equals(pathParts[1]) ) {
				UsuarioDAO userDAO = new UsuarioDAOImpl();

				// GET
				// /usuarios/editar/{id}
				try {
					request.setAttribute("usuario",userDAO.find(Integer.parseInt(pathParts[2])));
					dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuarios/editar-usuario.jsp");

				} catch (NumberFormatException nfe) {
					nfe.printStackTrace();
					dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/usuarios/usuarios.jsp");
				}

			} else {
				System.out.println("Opción POST no soportada.");
				dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/index.jsp");

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
				UsuarioDAO userDAO = new UsuarioDAOImpl();
				String nombre = request.getParameter("nombre");
				String password = request.getParameter("password");
				String rol = request.getParameter("rol");
				Usuario nuevoUser = new Usuario();
				nuevoUser.setUsuario(nombre);
				nuevoUser.setPassword(password);
				nuevoUser.setRol(rol);
				userDAO.create(nuevoUser);

		} else if ("put".equalsIgnoreCase(__method__)) {
			// Actualizar uno existente
			//Dado que los forms de html sólo soportan method GET y POST utilizo parámetro oculto para indicar la operación de actulización PUT.
			doPut(request, response);
			//response.sendRedirect(request.getContextPath()+"/usuarios");
		} else if ("delete".equalsIgnoreCase(__method__)) {
			// Borrar uno existente
			//Dado que los forms de html sólo soportan method GET y POST utilizo parámetro oculto para indicar la operación de actulización DELETE.
			doDelete(request, response);

		}else {
			System.out.println("Opción POST no soportada.");

		}

		//response.sendRedirect("../../../tienda/usuarios");
		response.sendRedirect(request.getContextPath()+"/usuarios");
	}

	@Override
	protected void doPut(HttpServletRequest request, HttpServletResponse response) {

		UsuarioDAO userDAO = new UsuarioDAOImpl();
		String codigo = request.getParameter("codigo");
		String nombre = request.getParameter("nombre");
		String password = request.getParameter("password");
		String rol = request.getParameter("rol");
		Usuario user = new Usuario();

		try {
			int id = Integer.parseInt(codigo);
			user.setIdUsuario(id);
			user.setUsuario(nombre);
			Optional<Usuario> s = userDAO.findUser(nombre, password);
			if (s != null && s.isPresent()) {
				user.setPassword(password);
			} else {
				user.setPassword(Usuario.hashPassword(password));
			}

			user.setRol(rol);
			userDAO.update(user);
		} catch (NumberFormatException nfe) {
			nfe.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
	@Override
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) {
		UsuarioDAO userDAO = new UsuarioDAOImpl();
		String codigo = request.getParameter("codigo");

		try {

			int id = Integer.parseInt(codigo);

			userDAO.delete(id);

		} catch (NumberFormatException nfe) {
			nfe.printStackTrace();
		}
	}

}
