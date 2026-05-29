<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>JCELL - ${empty cliente ? 'Nuevo Cliente' : 'Editar Cliente'}</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; background: #f4f4f4; }
        h2 { color: #333; }
        .formulario { background: white; padding: 25px; border-radius: 8px; max-width: 500px; }
        .campo { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #555; }
        input[type=text], input[type=email], input[type=tel] {
            width: 100%; padding: 8px; border: 1px solid #ddd;
            border-radius: 4px; box-sizing: border-box;
        }
        .btn { padding: 8px 16px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; }
        .btn-guardar { background: #4CAF50; color: white; }
        .btn-cancelar { background: #9E9E9E; color: white; margin-left: 10px; }
        .cabecera { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
    </style>
</head>
<body>

<div class="cabecera">
    <h2>${empty cliente ? '➕ Nuevo Cliente' : '✏️ Editar Cliente'}</h2>
    <a href="${pageContext.request.contextPath}/clientes?accion=listar" 
       class="btn btn-cancelar">← Volver</a>
</div>

<div class="formulario">
    <%-- 
        USO DE POST: este formulario envía datos con método POST al servlet
        La acción cambia entre guardar (nuevo) o actualizar (editar)
    --%>
    <form action="${pageContext.request.contextPath}/clientes" method="post">

        <input type="hidden" name="accion" 
               value="${empty cliente ? 'guardar' : 'actualizar'}">
        <c:if test="${not empty cliente}">
            <input type="hidden" name="id" value="${cliente.id}">
        </c:if>

        <div class="campo">
            <label for="nombre">Nombre *</label>
            <input type="text" id="nombre" name="nombre" 
                   value="${cliente.nombre}" required placeholder="Ej: Juan">
        </div>

        <div class="campo">
            <label for="apellido">Apellido *</label>
            <input type="text" id="apellido" name="apellido" 
                   value="${cliente.apellido}" required placeholder="Ej: Pérez">
        </div>

        <div class="campo">
            <label for="telefono">Teléfono *</label>
            <input type="tel" id="telefono" name="telefono" 
                   value="${cliente.telefono}" required placeholder="Ej: 3001234567">
        </div>

        <div class="campo">
            <label for="correo">Correo electrónico</label>
            <input type="email" id="correo" name="correo" 
                   value="${cliente.correo}" placeholder="Ej: cliente@email.com">
        </div>

        <div class="campo">
            <label for="direccion">Dirección</label>
            <input type="text" id="direccion" name="direccion" 
                   value="${cliente.direccion}" placeholder="Ej: Cra 5 #10-20">
        </div>

        <div>
            <button type="submit" class="btn btn-guardar">
                ${empty cliente ? '💾 Guardar' : '🔄 Actualizar'}
            </button>
            <a href="${pageContext.request.contextPath}/clientes?accion=listar" 
               class="btn btn-cancelar">Cancelar</a>
        </div>

    </form>
</div>

</body>
</html>