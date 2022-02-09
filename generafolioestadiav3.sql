-- FUNCION DE FOLIO VERSION 2 
CREATE OR REPLACE FUNCTION generafolioestadia(cveAlumnoGrupo INT)
RETURNS VARCHAR(10)
as $$
	DECLARE 
		anio INTEGER;
		consecutivo INTEGER;
		num_cuatrimestre INTEGER;
	BEGIN	
		 num_cuatrimestre:= (SELECT c.numero_cuatrimestre 
		 FROM alumno_grupo ag 
		 INNER JOIN grupo g ON g.cve_grupo=ag.cve_grupo 
		 INNER JOIN cuatrimestre c ON c.cve_cuatrimestre=g.cve_cuatrimestre 
		 WHERE ag.cve_alumno_grupo=cveAlumnoGrupo);
		 
		 anio:= (SELECT CAST(EXTRACT(YEAR FROM CURRENT_TIMESTAMP) AS VARCHAR));
		 
		 consecutivo:= (SELECT CAST((COUNT(ec.cve_carta_estadia)+1) AS INTEGER)AS consecutivo 
		 FROM estadia_carta ec 
		 INNER JOIN estadia_alumno ea ON ec.cve_estadia_alumno=ea.cve_estadia_alumno
		 INNER JOIN alumno_grupo ag ON ea.cve_alumno_grupo=ag.cve_alumno_grupo
		 INNER JOIN grupo g ON g.cve_grupo=ag.cve_grupo 
         INNER JOIN cuatrimestre cu ON cu.cve_cuatrimestre=g.cve_cuatrimestre 
		 WHERE cu.numero_cuatrimestre=num_cuatrimestre);		 
		
		RETURN CONCAT('E','-',CAST(anio as VARCHAR),'-',CAST(consecutivo as VARCHAR));
	
end; $$ language 'plpgsql';