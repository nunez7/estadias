<%-- 
    Document   : vizualizarMemoria
    Created on : Dec 8, 2021, 8:33:08 AM
    Author     : rhekh
--%>

<%@ page contentType="text/html; charset=utf-8" language="java" import="mx.edu.utdelacosta.*, java.sql.*, java.util.*, java.text.*" errorPage="" %>
<%
    
    RequestParamParser parser = new RequestParamParser(request);
    int cveArchivo = parser.getIntParameter("cveArchivo", 0);
    
HttpSession sesion = request.getSession();
Usuario usuario = (Usuario) sesion.getAttribute("usuario");
if(usuario == null)
{
        response.sendRedirect("../login.jsp");
}else{
    String ruta="auxiliar.pdf";
    if (cveArchivo!=0) {
    Datos siest = new Datos(); 
    ArrayList<CustomHashMap> documento = siest.ejecutarConsulta("SELECT COALESCE(a.url, 'auxiliar.pdf')as url "
            + "FROM archivo a "
            + "WHERE a.cve_archivo="+cveArchivo);
     ruta=documento.get(0).getString("url");
    }


%>
<object id="object" data="/dexter/document/estadias/<%=ruta%>#toolbar=0" align="center" type="application/pdf" width="100%" height="700" loop="1" autostart="false" name="Memoria Estadia" />
<%
}
%>
<script>
        document.oncopy = ev =>{
          ev.preventDefault();
          event.clipboardData.setData('Has flipao, eh?');
        };
</script>