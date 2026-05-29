<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>JCELL - Clientes</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; background: #f4f4f4; }
        h2 { color: #333; }
        table { width: 100%; border-collapse: collapse; background: white; }
        th { background: #4CAF50; color: white; padding: 10px; }
        td { padding: 8px; border-bottom: 1px solid #ddd; text-align: center; }
        tr:hover { background: #f1f1f1; }
        .btn { padding: 6px 12px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; }
        .btn-nuevo { background: #4CAF50; color: white; }
        .btn-editar { background: #2196F3; color: white; }
        .btn-eliminar { background: #f44336; color: white; }
        .alerta { padding: 10px; margin-bottom: 15px; border-radius: 4px; }
        .exito { background: #dff0d8; color: #3c763d; }
        .cabecera { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
    </style>
</head>
<body>

<div class="cabecera">
    <h2>👤 Gestión de Clientes - JCELL</h2>
    <a href="${pageContext.request.contextPath}/clientes?accion=nuevo" 
       class="btn btn-nuevo">+ Nuevo Cliente</a>
</div>

<c:if test="${not empty param.msg}">
    <div class="alerta exito">
        <c:choose>
            <c:when test="${param.msg eq 'guardado'}">✅ Cliente registrado exitosamente.</c:when>
            <c:when test="${param.msg eq 'actualizado'}">✅ Cliente actualizado exitosamente.</c:when>
            <c:when test="${param.msg eq 'eliminado'}">🗑️ Cliente eliminado.</c:when>
        </c:choose>
    </div>
</c:if>

<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>Teléfono</th>
            <th>Correo</th>
            <th>Dirección</th>
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody>
        <c:choose>
            <c:when test="${empty clientes}">
                <tr><td colspan="7">No hay clientes registrados.</td></tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="c" items="${clientes}">
                    <tr>
                        <td>${c.id}</td>
                        <td>${c.nombre}</td>
                        <td>${c.apellido}</td>
                        <td>${c.telefono}</td>
                        <td>${c.correo}</td>
                        <td>${c.direccion}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/clientes?accion=editar&id=${c.id}"
                               class="btn btn-editar">✏️ Editar</a>
                            <a href="${pageContext.request.contextPath}/clientes?accion=eliminar&id=${c.id}"
                               class="btn btn-eliminar"
                               onclick="return confirm('¿Eliminar este cliente?')">🗑️</a>
                        </td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </tbody>
</table>

</body>
</html>