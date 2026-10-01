CLASS zcl_pel_insertar_datos DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zcl_pel_insertar_datos IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " -----------------------------------------------------------------
    " 1. Limpiar las tablas antes de insertar
    " -----------------------------------------------------------------
    DELETE FROM zdt_pel_cita.
    DELETE FROM zdt_pel_pelu_ser.
    DELETE FROM zdt_pel_peluquer.
    DELETE FROM zdt_pel_servicio.
    COMMIT WORK.

    " -----------------------------------------------------------------
    " 2. Insertar SERVICIOS (UUIDs generados individualmente)
    " -----------------------------------------------------------------
    DATA: lv_id1 TYPE sysuuid_x16,
          lv_id2 TYPE sysuuid_x16,
          lv_id3 TYPE sysuuid_x16,
          lv_id4 TYPE sysuuid_x16,
          lv_id5 TYPE sysuuid_x16,
          lv_id6 TYPE sysuuid_x16.

    lv_id1 = cl_system_uuid=>create_uuid_x16_static( ).
    lv_id2 = cl_system_uuid=>create_uuid_x16_static( ).
    lv_id3 = cl_system_uuid=>create_uuid_x16_static( ).
    lv_id4 = cl_system_uuid=>create_uuid_x16_static( ).
    lv_id5 = cl_system_uuid=>create_uuid_x16_static( ).
    lv_id6 = cl_system_uuid=>create_uuid_x16_static( ).

    DATA lt_servicios TYPE TABLE OF zdt_pel_servicio.

    lt_servicios = VALUE #(
      ( mandt        = sy-mandt
        servicio_id   = lv_id1
        descripcion  = 'Corte Hombre'
        genero       = 'H'
        duracion_min = 30 )

      ( mandt        = sy-mandt
        servicio_id   = lv_id2
        descripcion  = 'Corte Mujer'
        genero       = 'M'
        duracion_min = 45 )

      ( mandt        = sy-mandt
        servicio_id   = lv_id3
        descripcion  = 'Barba'
        genero       = 'H'
        duracion_min = 20 )

      ( mandt        = sy-mandt
        servicio_id   = lv_id4
        descripcion  = 'Uñas Manos Hombre'
        genero       = 'H'
        duracion_min = 40 )

      ( mandt        = sy-mandt
        servicio_id   = lv_id5
        descripcion  = 'Uñas Manos Mujer'
        genero       = 'M'
        duracion_min = 50 )

      ( mandt        = sy-mandt
        servicio_id   = lv_id6
        descripcion  = 'Uñas Pies'
        genero       = 'U'
        duracion_min = 60 )
    ).

    MODIFY zdt_pel_servicio FROM TABLE @lt_servicios.
    COMMIT WORK.

    " -----------------------------------------------------------------
    " 3. Insertar PELUQUEROS (UUIDs individuales)
    " -----------------------------------------------------------------
    DATA: lv_pel1 TYPE sysuuid_x16,
          lv_pel2 TYPE sysuuid_x16,
          lv_pel3 TYPE sysuuid_x16,
          lv_pel4 TYPE sysuuid_x16.

    lv_pel1 = cl_system_uuid=>create_uuid_x16_static( ).
    lv_pel2 = cl_system_uuid=>create_uuid_x16_static( ).
    lv_pel3 = cl_system_uuid=>create_uuid_x16_static( ).
    lv_pel4 = cl_system_uuid=>create_uuid_x16_static( ).

    DATA lt_peluqueros TYPE TABLE OF zdt_pel_peluquer.

    lt_peluqueros = VALUE #(
      ( mandt        = sy-mandt
        peluquero_id = lv_pel1
        nombre       = 'Carlos Pérez'
        genero       = 'H'
        dia_libre    = 1 )

      ( mandt        = sy-mandt
        peluquero_id = lv_pel2
        nombre       = 'María García'
        genero       = 'M'
        dia_libre    = 2 )

      ( mandt        = sy-mandt
        peluquero_id = lv_pel3
        nombre       = 'Juan López'
        genero       = 'H'
        dia_libre    = 3 )

      ( mandt        = sy-mandt
        peluquero_id = lv_pel4
        nombre       = 'Ana Martínez'
        genero       = 'M'
        dia_libre    = 5 )
    ).

    MODIFY zdt_pel_peluquer FROM TABLE @lt_peluqueros.
    COMMIT WORK.

    " -----------------------------------------------------------------
    " 4. Asignaciones (usando los IDs ya generados)
    " -----------------------------------------------------------------
    DATA lt_asignaciones TYPE TABLE OF zdt_pel_pelu_ser.

    lt_asignaciones = VALUE #(
      ( mandt        = sy-mandt
        peluquero_id = lv_pel1
        servicio_id  = lv_id1 )  " Carlos - Corte Hombre
      ( mandt        = sy-mandt
        peluquero_id = lv_pel1
        servicio_id  = lv_id3 )  " Carlos - Barba
      ( mandt        = sy-mandt
        peluquero_id = lv_pel1
        servicio_id  = lv_id4 )  " Carlos - Uñas Manos H

      ( mandt        = sy-mandt
        peluquero_id = lv_pel2
        servicio_id  = lv_id2 )  " María - Corte Mujer
      ( mandt        = sy-mandt
        peluquero_id = lv_pel2
        servicio_id  = lv_id5 )  " María - Uñas Manos M
      ( mandt        = sy-mandt
        peluquero_id = lv_pel2
        servicio_id  = lv_id6 )  " María - Uñas Pies

      ( mandt        = sy-mandt
        peluquero_id = lv_pel3
        servicio_id  = lv_id1 )  " Juan - Corte Hombre
      ( mandt        = sy-mandt
        peluquero_id = lv_pel3
        servicio_id  = lv_id3 )  " Juan - Barba

      ( mandt        = sy-mandt
        peluquero_id = lv_pel4
        servicio_id  = lv_id2 )  " Ana - Corte Mujer
      ( mandt        = sy-mandt
        peluquero_id = lv_pel4
        servicio_id  = lv_id5 )  " Ana - Uñas Manos M
      ( mandt        = sy-mandt
        peluquero_id = lv_pel4
        servicio_id  = lv_id6 )  " Ana - Uñas Pies
    ).

    MODIFY zdt_pel_pelu_ser FROM TABLE @lt_asignaciones.
    COMMIT WORK.

    " -----------------------------------------------------------------
    " 5. Confirmación
    " -----------------------------------------------------------------
    out->write( |✅ Datos insertados/actualizados correctamente| ).
    out->write( |   Servicios: { lines( lt_servicios ) }| ).
    out->write( |   Peluqueros: { lines( lt_peluqueros ) }| ).
    out->write( |   Asignaciones: { lines( lt_asignaciones ) }| ).
    out->write( |   UUIDs generados (primeros servicios): { lv_id1 } / { lv_id2 }| ).

  ENDMETHOD.
ENDCLASS.
