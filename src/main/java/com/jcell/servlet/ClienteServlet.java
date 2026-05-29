package com.jcell.servlet;

import com.jcell.dao.ClienteDAO;
import com.jcell.modelo.Cliente;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/clientes")
public class ClienteServlet extends HttpServlet {

    private final ClienteDAO dao = new ClienteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        switch (accion) {
            case "listar":
                List<Cliente> clientes = dao.listarTodos();
                request.setAttribute("clientes", clientes);
                request.getRequestDispatcher("/vistas/clientes/lista.jsp")
                       .forward(request, response);
                break;
            case "nuevo":
                request.getRequestDispatcher("/vistas/clientes/formulario.jsp")
                       .forward(request, response);
                break;
            case "editar":
                int idEditar = Integer.parseInt(request.getParameter("id"));
                Cliente cliente = dao.buscarPorId(idEditar);
                request.setAttribute("cliente", cliente);
                request.getRequestDispatcher("/vistas/clientes/formulario.jsp")
                       .forward(request, response);
                break;
            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(idEliminar);
                response.sendRedirect(request.getContextPath() + "/clientes?accion=listar&msg=eliminado");
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/clientes?accion=listar");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        switch (accion) {
            case "guardar":
                Cliente nuevo = construirCliente(request);
                dao.insertar(nuevo);
                response.sendRedirect(request.getContextPath() + "/clientes?accion=listar&msg=guardado");
                break;
            case "actualizar":
                Cliente existente = construirCliente(request);
                existente.setId(Integer.parseInt(request.getParameter("id")));
                dao.actualizar(existente);
                response.sendRedirect(request.getContextPath() + "/clientes?accion=listar&msg=actualizado");
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/clientes?accion=listar");
        }
    }

    private Cliente construirCliente(HttpServletRequest req) {
        Cliente c = new Cliente();
        c.setNombre(req.getParameter("nombre"));
        c.setApellido(req.getParameter("apellido"));
        c.setTelefono(req.getParameter("telefono"));
        c.setCorreo(req.getParameter("correo"));
        c.setDireccion(req.getParameter("direccion"));
        return c;
    }
}