package org.iesbelen.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.annotation.WebInitParam;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.iesbelen.model.Usuario;

import java.io.IOException;

/**
 * Servlet Filter implementation class ProductosFilter
 */
@WebFilter(
        urlPatterns = {"/tienda/productos/*"},
        initParams = {
                @WebInitParam(name = "acceso-concedido-a-rol", value = "Administrador")
        })
public class ProductosFilter extends HttpFilter implements Filter {

    private String rolAcceso;

    /**
     * @see HttpFilter#HttpFilter()
     */
    public ProductosFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see Filter#destroy()
     */
    public void destroy() {
        // TODO Auto-generated method stub
    }

    /**
     * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
     */
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {


        //Cast de ServletRequest a HttpServletRequest, el único tipo implementado
        //en el contenedor de Servlet: HttpServletRequest & HttpServletReponse
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;


        //Accediendo al objeto de sesión
        HttpSession session = httpRequest.getSession();

        //Obteniendo la url
        String url = httpRequest.getRequestURL().toString();

        Usuario usuario;
        if (session != null  //Seteo inline de usuario
                && (usuario = (Usuario) session.getAttribute("usuario-logueado")) != null
                && "Administrador".equals(usuario.getRol())) {

            //Si eres administrador acceso a cualquier página del filtro
            chain.doFilter(request, response);

        } else if (url.endsWith("/productos/crear")
                || url.contains("/productos/editar")
                || url.contains("/productos/borrar")) {
            if (session != null  //Seteo inline de usuario
                    && (usuario = (Usuario) session.getAttribute("usuario-logueado")) != null
                    && !"Administrador".equals(usuario.getRol())) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/tienda/productos");
            }else{
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/tienda/login");
            }
            // Usuario sin registrarse trata de acceder a páginas de crear y editar, y el filtro lo redirige a login
        } else {

            // Otras rutas /productos y /productos/{id} se dan paso a cualquier rol

            chain.doFilter(request, response);
        }
    }

    /**
     * @see Filter#init(FilterConfig)
     */
    public void init(FilterConfig fConfig) {

        this.rolAcceso = fConfig.getInitParameter("acceso-concedido-a-rol");

    }
}

