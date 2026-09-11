CLASS zcl_abap2ui5_sflight_dynpro DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

  PROTECTED SECTION.
    TYPES ty_flight TYPE zcl_sflight_dynpro_service=>ty_flight.
    TYPES tt_flights TYPE zcl_sflight_dynpro_service=>tt_flights.

    DATA mo_client TYPE REF TO z2ui5_if_client.
    DATA mo_service TYPE REF TO zcl_sflight_dynpro_service.

    DATA mv_title TYPE string VALUE `SFLIGHT Dynpro -> abap2UI5`.
    DATA mv_screen TYPE c LENGTH 4 VALUE '0100'.
    DATA mv_carrid TYPE sflight-carrid VALUE 'LH'.
    DATA mv_status TYPE string VALUE `Ready`.

    DATA mt_flights TYPE tt_flights.
    DATA ms_flight TYPE ty_flight.

    METHODS ensure_service.
    METHODS load_flights.
    METHODS navigate_to_detail
      IMPORTING
        iv_index TYPE i.

    METHODS build_rows_xml
      RETURNING
        VALUE(rv_rows_xml) TYPE string.

    METHODS render_screen_0100.
    METHODS render_screen_0200.
    METHODS render_current_screen.

    METHODS handle_event.

  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_abap2ui5_sflight_dynpro IMPLEMENTATION.

  METHOD ensure_service.
    IF mo_service IS NOT BOUND.
      CREATE OBJECT mo_service.
    ENDIF.
  ENDMETHOD.

  METHOD load_flights.
    ensure_service( ).

    IF mv_carrid IS INITIAL.
      CLEAR mt_flights.
      CLEAR ms_flight.
      mv_status = `Validation: CARRID est obligatoire.`.
      RETURN.
    ENDIF.

    mt_flights = mo_service->get_flights( mv_carrid ).

    IF mt_flights IS INITIAL.
      CLEAR ms_flight.
      mv_status = |Aucun vol trouve pour la compagnie { mv_carrid }.|.
    ELSE.
      READ TABLE mt_flights INTO ms_flight INDEX 1.
      mv_status = |{ lines( mt_flights ) } vol(s) charge(s).|.
    ENDIF.
  ENDMETHOD.

  METHOD navigate_to_detail.
    IF mt_flights IS INITIAL.
      mv_status = `Aucun vol charge.`.
      mo_client->message_box_display( mv_status ).
      RETURN.
    ENDIF.

    IF iv_index <= 0 OR iv_index > lines( mt_flights ).
      mv_status = |Index invalide: { iv_index }.|.
      mo_client->message_box_display( mv_status ).
      RETURN.
    ENDIF.

    READ TABLE mt_flights INTO ms_flight INDEX iv_index.
    IF sy-subrc <> 0.
      mv_status = `Selection detail impossible.`.
      mo_client->message_box_display( mv_status ).
      RETURN.
    ENDIF.

    mv_screen = '0200'.
    mv_status = |Detail du vol index { iv_index }.|.
  ENDMETHOD.

  METHOD build_rows_xml.
    DATA lv_row TYPE string.

    rv_rows_xml = ``.

    IF mt_flights IS INITIAL.
      rv_rows_xml =
          `<Text text="Aucune ligne a afficher."/>`.
      RETURN.
    ENDIF.

    rv_rows_xml = rv_rows_xml
      && `<Table inset="false" width="100%">`
      && `<columns>`
      && `<Column><Text text="Carr"/></Column>`
      && `<Column><Text text="Conn"/></Column>`
      && `<Column><Text text="Date"/></Column>`
      && `<Column hAlign="End"><Text text="Price"/></Column>`
      && `<Column><Text text="Cur"/></Column>`
      && `<Column hAlign="End"><Text text="Seats"/></Column>`
      && `</columns>`
      && `<items>`.

    LOOP AT mt_flights INTO DATA(ls_flight).
      lv_row =
          |<ColumnListItem type="Active" press="{ mo_client->_event( |DETAIL_{ sy-tabix }| ) }">|
       && `<cells>`
       && |<Text text="{ ls_flight-carrid }"/>|
       && |<Text text="{ ls_flight-connid }"/>|
       && |<Text text="{ ls_flight-fldate DATE = ISO }"/>|
       && |<ObjectNumber number="{ ls_flight-price }"/>|
       && |<Text text="{ ls_flight-currency }"/>|
       && |<Text text="{ ls_flight-seatsocc }/{ ls_flight-seatsmax }"/>|
       && `</cells>`
       && `</ColumnListItem>`.

      rv_rows_xml = rv_rows_xml && lv_row.
    ENDLOOP.

    rv_rows_xml = rv_rows_xml && `</items></Table>`.
  ENDMETHOD.

  METHOD render_screen_0100.
    DATA lv_xml TYPE string.
    DATA lv_rows_xml TYPE string.

    lv_rows_xml = build_rows_xml( ).

    lv_xml =
      `<mvc:View xmlns="sap.m" xmlns:mvc="sap.ui.core.mvc" displayBlock="true" height="100%">`
      && `<Shell>`
      && `<Page title="SFLIGHT Dynpro - Ecran 0100">`
      && `<content>`
      && `<VBox class="sapUiSmallMargin">`
      && `<Title text="Ecran 0100 - Liste des vols"/>`
      && `<Label text="Compagnie aerienne (CARRID)"/>`
      && |<Input value="{ mo_client->_bind( mv_carrid ) }" placeholder="Ex: LH"/>|
      && |<Button text="Refresh" press="{ mo_client->_event( `REFRESH` ) }"/>|
      && lv_rows_xml
      && |<Button text="Exit" press="{ mo_client->_event( `EXIT` ) }"/>|
      && |<Text text="{ mv_status }"/>|
      && `</VBox>`
      && `</content>`
      && `</Page>`
      && `</Shell>`
      && `</mvc:View>`.

    mo_client->view_display( lv_xml ).
  ENDMETHOD.

  METHOD render_screen_0200.
    mo_client->view_display(
      z2ui5_cl_ui5_view_builder=>factory(
        )->ele( n = `View` ns = `mvc`
          )->a( n = `xmlns` v = `sap.m`
          )->a( n = `xmlns:mvc` v = `sap.ui.core.mvc`
          )->a( n = `displayBlock` v = `true`
          )->a( n = `height` v = `100%`
          )->ele( `Shell`
            )->ele( `Page`
              )->a( n = `title` v = `SFLIGHT - Detail vol (Ecran 0200)`
              )->ele( `content`
                )->ele( `VBox`
                  )->a( n = `class` v = `sapUiSmallMargin`
                  )->tag( `Label`
                    )->a( n = `text` v = `Compagnie`
                  )->tag( `Input`
                    )->a( n = `value` v = mo_client->_bind( ms_flight-carrid )
                    )->a( n = `editable` v = `false`
                  )->tag( `Label`
                    )->a( n = `text` v = `Connexion`
                  )->tag( `Input`
                    )->a( n = `value` v = mo_client->_bind( ms_flight-connid )
                    )->a( n = `editable` v = `false`
                  )->tag( `Label`
                    )->a( n = `text` v = `Date`
                  )->tag( `Input`
                    )->a( n = `value` v = mo_client->_bind( ms_flight-fldate )
                    )->a( n = `editable` v = `false`
                  )->tag( `Label`
                    )->a( n = `text` v = `Prix`
                  )->tag( `Input`
                    )->a( n = `value` v = mo_client->_bind( ms_flight-price )
                    )->a( n = `editable` v = `false`
                  )->tag( `Label`
                    )->a( n = `text` v = `Devise`
                  )->tag( `Input`
                    )->a( n = `value` v = mo_client->_bind( ms_flight-currency )
                    )->a( n = `editable` v = `false`
                  )->tag( `Label`
                    )->a( n = `text` v = `Sieges maximum`
                  )->tag( `Input`
                    )->a( n = `value` v = mo_client->_bind( ms_flight-seatsmax )
                    )->a( n = `editable` v = `false`
                  )->tag( `Label`
                    )->a( n = `text` v = `Sieges occupes`
                  )->tag( `Input`
                    )->a( n = `value` v = mo_client->_bind( ms_flight-seatsocc )
                    )->a( n = `editable` v = `false`
                  )->tag( `Button`
                    )->a( n = `text` v = `Back`
                    )->a( n = `press` v = mo_client->_event( `BACK` )
                  )->tag( `Button`
                    )->a( n = `text` v = `Exit`
                    )->a( n = `press` v = mo_client->_event( `EXIT` )
                  )->tag( `Text`
                    )->a( n = `text` v = mv_status ) )->stringify( ) ).
  ENDMETHOD.

  METHOD render_current_screen.
    CASE mv_screen.
      WHEN '0200'.
        render_screen_0200( ).
      WHEN OTHERS.
        render_screen_0100( ).
    ENDCASE.
  ENDMETHOD.

  METHOD handle_event.
    DATA lv_event TYPE string.
    DATA lv_index_text TYPE string.
    DATA lv_index TYPE i.

    lv_event = mo_client->get_event( ).

    CASE lv_event.
      WHEN `REFRESH`.
        load_flights( ).

      WHEN `BACK` OR `CANCEL`.
        mv_screen = '0100'.
        mv_status = `Retour a la liste.`.

      WHEN `EXIT`.
        mv_status = `Fin de session demandee.`.
        mo_client->message_box_display( `Utilisez Back pour quitter la page courante.` ).

      WHEN OTHERS.
        IF lv_event CP `DETAIL_*`.
          lv_index_text = lv_event+7.
          lv_index = lv_index_text.
          navigate_to_detail( lv_index ).
        ENDIF.
    ENDCASE.

    render_current_screen( ).
  ENDMETHOD.

  METHOD z2ui5_if_app~main.
    mo_client = client.

    IF mo_client->check_on_init( ) = abap_true.
      load_flights( ).
      render_current_screen( ).
      RETURN.
    ENDIF.

    IF mo_client->check_on_navigated( ) = abap_true.
      render_current_screen( ).
      RETURN.
    ENDIF.

    handle_event( ).
  ENDMETHOD.

ENDCLASS.
