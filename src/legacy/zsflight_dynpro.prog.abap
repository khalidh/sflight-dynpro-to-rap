REPORT zsflight_dynpro.

TABLES:
  scarr,
  spfli,
  sflight.

TYPES:
  BEGIN OF ty_flight,
    carrid   TYPE sflight-carrid,
    connid   TYPE sflight-connid,
    fldate   TYPE sflight-fldate,
    price    TYPE sflight-price,
    currency TYPE sflight-currency,
    seatsmax TYPE sflight-seatsmax,
    seatsocc TYPE sflight-seatsocc,
  END OF ty_flight.

DATA:
  gt_flights TYPE STANDARD TABLE OF ty_flight WITH EMPTY KEY,
  gs_flight  TYPE ty_flight,
  gv_ok_code TYPE sy-ucomm.

PARAMETERS:
  p_carrid TYPE sflight-carrid.

START-OF-SELECTION.

  PERFORM load_flights.

  IF gt_flights IS INITIAL.
    MESSAGE 'Aucun vol trouvé' TYPE 'I'.
    RETURN.
  ENDIF.

  CALL SCREEN 0100.

FORM load_flights.

  SELECT
    carrid,
    connid,
    fldate,
    price,
    currency,
    seatsmax,
    seatsocc
    FROM sflight
    WHERE carrid = @p_carrid
    INTO TABLE @gt_flights.

ENDFORM.

MODULE status_0100 OUTPUT.

  SET PF-STATUS 'MAIN100'.
  SET TITLEBAR 'TITLE100'.

ENDMODULE.

MODULE user_command_0100 INPUT.

  gv_ok_code = sy-ucomm.
  CLEAR sy-ucomm.

  CASE gv_ok_code.

    WHEN 'BACK'
      OR 'EXIT'
      OR 'CANCEL'.

      LEAVE TO SCREEN 0.

    WHEN 'REFRESH'.

      PERFORM load_flights.

    WHEN 'DETAIL'.

      READ TABLE gt_flights
        INTO gs_flight
        INDEX 1.

      IF sy-subrc = 0.
        CALL SCREEN 0200.
      ENDIF.

  ENDCASE.

ENDMODULE.

MODULE status_0200 OUTPUT.

  SET PF-STATUS 'MAIN100'.
  SET TITLEBAR 'TITLE200'.

ENDMODULE.

MODULE user_command_0200 INPUT.

  gv_ok_code = sy-ucomm.
  CLEAR sy-ucomm.

  CASE gv_ok_code.

    WHEN 'BACK'
      OR 'EXIT'
      OR 'CANCEL'.

      LEAVE TO SCREEN 0.

  ENDCASE.

ENDMODULE.
