CLASS zcl_dynpro_hello_world DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    DATA title TYPE string VALUE `Dynpro-like Hello World`.
    DATA name TYPE string VALUE `World`.
    DATA status TYPE string VALUE `Ready`.
    DATA counter TYPE i VALUE 0.

  PROTECTED SECTION.
    DATA client TYPE REF TO z2ui5_if_client.

    METHODS render_view.
    METHODS handle_event.

  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_dynpro_hello_world IMPLEMENTATION.

  METHOD render_view.
    client->view_display(
      z2ui5_cl_ui5_view_builder=>factory(
        )->ele( n = `View` ns = `mvc`
          )->a( n = `xmlns` v = `sap.m`
          )->a( n = `xmlns:mvc` v = `sap.ui.core.mvc`
          )->a( n = `displayBlock` v = `true`
          )->a( n = `height` v = `100%`
          )->ele( `Shell`
            )->ele( `Page`
              )->a( n = `title` v = title
              )->ele( `content`
                )->ele( `VBox`
                  )->a( n = `class` v = `sapUiSmallMargin`
                  )->tag( `Text`
                    )->a( n = `text` v = `Ecran de saisie - style Dynpro`
                  )->tag( `Title`
                    )->a( n = `text` v = `Hello World`
                  )->tag( `Label`
                    )->a( n = `text` v = `Nom`
                  )->tag( `Input`
                    )->a( n = `value` v = client->_bind( name )
                    )->a( n = `placeholder` v = `Saisir un nom`
                  )->tag( `Text`
                    )->a( n = `text` v = status
                  )->tag( `Button`
                    )->a( n = `text` v = `Afficher`
                    )->a( n = `press` v = client->_event( `DISPLAY` )
                  )->tag( `Button`
                    )->a( n = `text` v = `Effacer`
                    )->a( n = `press` v = client->_event( `CLEAR` )
                  )->tag( `Button`
                    )->a( n = `text` v = `Quitter`
                    )->a( n = `press` v = client->_event( `EXIT` ) ) )->stringify( ) ).
  ENDMETHOD.

  METHOD handle_event.
    CASE client->get_event( ).
      WHEN `DISPLAY`.
        counter = counter + 1.
        IF name IS INITIAL.
          status = |Hello World|.
        ELSE.
          status = |Hello World, { name }|.
        ENDIF.
        client->message_box_display( status ).

      WHEN `CLEAR`.
        CLEAR name.
        status = `Ready`.

      WHEN `EXIT`.
        client->message_box_display( `Goodbye` ).
    ENDCASE.
  ENDMETHOD.

  METHOD z2ui5_if_app~main.
    me->client = client.

    IF client->check_on_navigated( ).
      render_view( ).
      RETURN.
    ENDIF.

    IF client->check_on_init( ).
      render_view( ).
      RETURN.
    ENDIF.

    handle_event( ).
  ENDMETHOD.

ENDCLASS.
