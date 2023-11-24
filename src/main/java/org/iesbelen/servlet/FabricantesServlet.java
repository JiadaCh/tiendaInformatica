package org.iesbelen.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.iesbelen.dao.FabricanteDAO;
import org.iesbelen.dao.FabricanteDAOImpl;
import org.iesbelen.dto.FabricanteDTO;
import org.iesbelen.model.Fabricante;

import java.io.IOException;
import java.io.Serial;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

@WebServlet(name = "fabricantesServlet", value = "/tienda/fabricantes/*")
public class FabricantesServlet extends HttpServlet {

	@Serial
	private static final long serialVersionUID = 1L;

	/**
	 * HTTP Method: GET
	 * Paths:
	 * 		/fabricantes/
	 * 		/fabricantes/{id}
	 * 		/fabricantes/editar{id}
	 * 		/fabricantes/crear
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		RequestDispatcher dispatcher;

		String pathInfo = request.getPathInfo(); //

		if (pathInfo == null || "/".equals(pathInfo)) {
			FabricanteDAO fabDAO = new FabricanteDAOImpl();
			List<Fabricante> fabs = fabDAO.getAll();
            List<FabricanteDTO> fabDTO;
			fabDTO =fabs.stream()
					.map(f-> new FabricanteDTO(f.getIdFabricante(),f.getNombre()))
					.toList();

			fabDTO.forEach(f -> f.setNumProductos(fabDAO.getCountProductos(f.getIdFabricante()).orElse(0)));
			//GET
			//	/fabricantes/
			//	/fabricantes
			if (request.getParameter("ordenarPor") == null){

				request.setAttribute("listaFabricantes", fabDTO);

			}else{

				request = orderBy1(request,response,fabDTO);
			}
			dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/fabricantes/fabricantes.jsp");

		} else {
			// GET
			// 		/fabricantes/{id}
			// 		/fabricantes/{id}/
			// 		/fabricantes/edit/{id}
			// 		/fabricantes/edit/{id}/
			// 		/fabricantes/crear
			// 		/fabricantes/crear/

			pathInfo = pathInfo.replaceAll("/$", "");
			String[] pathParts = pathInfo.split("/");

			if (pathParts.length == 2 && "crear".equals(pathParts[1])) {

				// GET
				// /fabricantes/crear
				dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/fabricantes/crear-fabricante.jsp");

			} else if (pathParts.length == 2) {
				FabricanteDAO fabDAO = new FabricanteDAOImpl();
				Optional<Fabricante> fab = fabDAO.find(Integer.parseInt(pathParts[1]));
				FabricanteDTO fabDTO = null;


				// GET
				// /fabricantes/{id}
				try {
					if (fab.isPresent()){
						Fabricante fabricante = fab.get();
						fabDTO = new FabricanteDTO(fabricante.getIdFabricante(),fabricante.getNombre());
						fabDTO.setNumProductos(fabDAO.getCountProductos(fabricante.getIdFabricante()).orElse(0));
					}
					request.setAttribute("fabricante",Optional.of(fabDTO));

					dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/fabricantes/detalle-fabricante.jsp");

				} catch (NumberFormatException nfe) {
					nfe.printStackTrace();
					dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/fabricantes/fabricantes.jsp");
				}
			} else if (pathParts.length == 3 && "editar".equals(pathParts[1]) ) {
				FabricanteDAO fabDAO = new FabricanteDAOImpl();

				// GET
				// /fabricantes/editar/{id}
				try {
					request.setAttribute("fabricante",fabDAO.find(Integer.parseInt(pathParts[2])));
					dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/fabricantes/editar-fabricante.jsp");

				} catch (NumberFormatException nfe) {
					nfe.printStackTrace();
					dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/fabricantes/fabricantes.jsp");
				}
			} else {
				System.out.println("Opción POST no soportada.");
				dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/fabricantes/fabricantes.jsp");

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
			FabricanteDAO fabDAO = new FabricanteDAOImpl();
			String nombre = request.getParameter("nombre");
			Fabricante nuevoFab = new Fabricante();
			nuevoFab.setNombre(nombre);

			fabDAO.create(nuevoFab);

		} else if ("put".equalsIgnoreCase(__method__)) {
			// Actualizar uno existente
			//Dado que los forms de html sólo soportan method GET y POST utilizo parámetro oculto para indicar la operación de actulización PUT.
			doPut(request, response);

		} else if ("delete".equalsIgnoreCase(__method__)) {
			// Borrar uno existente
			//Dado que los forms de html sólo soportan method GET y POST utilizo parámetro oculto para indicar la operación de actulización DELETE.
			doDelete(request, response);
		} else {
			System.out.println("Opción POST no soportada.");
		}

		//response.sendRedirect("../../../tienda/fabricantes");
		response.sendRedirect(request.getContextPath() + "/tienda/fabricantes");
	}


	@Override
	protected void doPut(HttpServletRequest request, HttpServletResponse response) {

		FabricanteDAO fabDAO = new FabricanteDAOImpl();
		String codigo = request.getParameter("codigo");
		String nombre = request.getParameter("nombre");
		Fabricante fab = new Fabricante();

		try {
			int id = Integer.parseInt(codigo);
			fab.setIdFabricante(id);
			fab.setNombre(nombre);
			fabDAO.update(fab);

		} catch (NumberFormatException nfe) {
			nfe.printStackTrace();
		}
	}
	@Override
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) {
		FabricanteDAO fabDAO = new FabricanteDAOImpl();
		String codigo = request.getParameter("codigo");

		try {

			int id = Integer.parseInt(codigo);

			fabDAO.delete(id);

		} catch (NumberFormatException nfe) {
			nfe.printStackTrace();
		}
	}

	protected HttpServletRequest orderBy1(HttpServletRequest request, HttpServletResponse response,List<FabricanteDTO> fabDTO) {
		String ordenarPor = request.getParameter("ordenarPor");
		String modo =request.getParameter("modo");
		try {
			if (ordenarPor.equals("nombre") && modo.equals("asc")){
				fabDTO =fabDTO.stream()
						.sorted(Comparator.comparing(Fabricante::getNombre))
						.toList();

			}else if (ordenarPor.equals("nombre") && modo.equals("desc")){
				fabDTO =fabDTO.stream()
						.sorted(Comparator.comparing(Fabricante::getNombre)
								.reversed())
						.toList();
			}else if (ordenarPor.equals("codigo") && modo.equals("desc")){
				fabDTO =fabDTO.stream()
						.sorted(Comparator.comparing(Fabricante::getIdFabricante)
								.reversed())
						.toList();
			}
			request.setAttribute("listaFabricantes", fabDTO);
			request.setAttribute("ordenarPor",ordenarPor);
			request.setAttribute("modo",modo);
		} catch (NumberFormatException nfe) {
			nfe.printStackTrace();
		}
		return request;
	}

}
