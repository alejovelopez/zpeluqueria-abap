@AbapCatalog.sqlViewName: 'ZCPELCITA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Vista de consumo de citas'
@VDM.viewType: #CONSUMPTION
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view ZC_PEL_CITA as select from ZI_PEL_CITA
{
  key cita_id,
      peluquero_id,
      PELUQUERO_NOMBRE,
      PELUQUERO_GENERO,
      servicio_id,
      SERVICIO_DESCRIPCION,
      duracion_min,
      cliente_nombre,
      cliente_genero,
      fecha_hora_inicio,
      fecha_hora_fin,
      estado
}
