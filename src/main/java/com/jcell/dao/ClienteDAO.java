package com.jcell.dao;

import com.jcell.modelo.Cliente;
import com.jcell.util.ConexionDB;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {

    public boolean insertar(Cliente c) {
        String sql = "INSERT INTO cliente (nombre, apellido, telefono, correo, direccion) VALUES (?,?,?,?,?)";
        Connection conn = null;
        try {
            conn = ConexionDB.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, c.getNombre());
            ps.setString(2, c.getApellido());
            ps.setString(3, c.getTelefono());
            ps.setString(4, c.getCorreo());
            ps.setString(5, c.getDireccion());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            ConexionDB.cerrar(conn);
        }
    }

    public List<Cliente> listarTodos() {
        List<Cliente> lista = new ArrayList<>();
        String sql = "SELECT * FROM cliente";
        Connection conn = null;
        try {
            conn = ConexionDB.getConnection();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                lista.add(mapear(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConexionDB.cerrar(conn);
        }
        return lista;
    }

    public Cliente buscarPorId(int id) {
        String sql = "SELECT * FROM cliente WHERE id = ?";
        Connection conn = null;
        try {
            conn = ConexionDB.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapear(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConexionDB.cerrar(conn);
        }
        return null;
    }

    public boolean actualizar(Cliente c) {
        String sql = "UPDATE cliente SET nombre=?, apellido=?, telefono=?, correo=?, direccion=? WHERE id=?";
        Connection conn = null;
        try {
            conn = ConexionDB.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, c.getNombre());
            ps.setString(2, c.getApellido());
            ps.setString(3, c.getTelefono());
            ps.setString(4, c.getCorreo());
            ps.setString(5, c.getDireccion());
            ps.setInt(6, c.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            ConexionDB.cerrar(conn);
        }
    }

    public boolean eliminar(int id) {
        String sql = "DELETE FROM cliente WHERE id = ?";
        Connection conn = null;
        try {
            conn = ConexionDB.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            ConexionDB.cerrar(conn);
        }
    }

    private Cliente mapear(ResultSet rs) throws SQLException {
        return new Cliente(
            rs.getInt("id"),
            rs.getString("nombre"),
            rs.getString("apellido"),
            rs.getString("telefono"),
            rs.getString("correo"),
            rs.getString("direccion")
        );
    }
}