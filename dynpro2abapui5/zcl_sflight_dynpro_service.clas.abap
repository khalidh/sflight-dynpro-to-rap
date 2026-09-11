CLASS zcl_sflight_dynpro_service DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ty_flight,
        carrid   TYPE sflight-carrid,
        connid   TYPE sflight-connid,
        fldate   TYPE sflight-fldate,
        price    TYPE sflight-price,
        currency TYPE sflight-currency,
        seatsmax TYPE sflight-seatsmax,
        seatsocc TYPE sflight-seatsocc,
      END OF ty_flight,

      tt_flights TYPE STANDARD TABLE OF ty_flight
        WITH EMPTY KEY.

    METHODS get_flights
      IMPORTING
        iv_carrid         TYPE sflight-carrid
      RETURNING
        VALUE(rt_flights) TYPE tt_flights.

ENDCLASS.

CLASS zcl_sflight_dynpro_service IMPLEMENTATION.

  METHOD get_flights.

    SELECT
      carrid,
      connid,
      fldate,
      price,
      currency,
      seatsmax,
      seatsocc
      FROM sflight
      WHERE carrid = @iv_carrid
      INTO TABLE @rt_flights.

  ENDMETHOD.

ENDCLASS.
