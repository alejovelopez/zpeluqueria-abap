@AbapCatalog.sqlViewName: 'ZIPELCITA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vista básica de citas con datos maestros'
@Metadata.ignorePropagatedAnnotations: true
define view ZI_PEL_CITA
  as select from zdt_pel_cita     as cita
    inner join   zdt_pel_peluquer as pel  on cita.peluquero_id = pel.peluquero_id
    inner join   zdt_pel_servicio as serv on cita.servicio_id = serv.servicio_id
{
  key cita.cita_id,
      cita.peluquero_id,
      pel.nombre       as PELUQUERO_NOMBRE,
      pel.genero       as PELUQUERO_GENERO,
      cita.servicio_id,
      serv.descripcion as SERVICIO_DESCRIPCION,
      serv.duracion_min,
      cita.cliente_nombre,
      cita.cliente_genero,
      cita.fecha_hora_inicio,
      cita.fecha_hora_fin,
      cita.estado
}
