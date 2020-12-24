CREATE OR REPLACE FUNCTION CALCULATEORDER
    (v_book_id IN books.book_id%TYPE)
    RETURN reservation.r_order%TYPE
IS
    nCnt NUMBER;
BEGIN
    nCnt := 0;

    SELECT count(*)
    INTO nCnt
    FROM reservation
    WHERE book_id = v_book_id;

RETURN nCnt;
END;
/