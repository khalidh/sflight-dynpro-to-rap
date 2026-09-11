CLASS ltcl_dynpro_hello_world DEFINITION FINAL
  FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PRIVATE SECTION.
    METHODS create FOR TESTING.
    METHODS implements_app FOR TESTING.
ENDCLASS.


CLASS ltcl_dynpro_hello_world IMPLEMENTATION.

  METHOD create.
    DATA(lo_app) = NEW zcl_dynpro_hello_world( ).
    ASSERT lo_app IS BOUND.
  ENDMETHOD.

  METHOD implements_app.
    DATA lo_app TYPE REF TO zcl_dynpro_hello_world.
    DATA li_app TYPE REF TO z2ui5_if_app.

    lo_app = NEW zcl_dynpro_hello_world( ).
    li_app ?= lo_app.

    ASSERT li_app IS BOUND.
  ENDMETHOD.

ENDCLASS.
