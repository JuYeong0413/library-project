CREATE OR REPLACE PROCEDURE RESERVEBOOK
(v_book_id IN books.book_id%TYPE, v_user_id IN users.user_id%TYPE, result OUT VARCHAR2)
IS
    already_reserved EXCEPTION;
    too_many_reservation EXCEPTION;
    too_many_people EXCEPTION;
    nCnt NUMBER;
    nReservation NUMBER;
    nPeople NUMBER;
BEGIN
    result := '';
    nCnt := 0;

    /* 이미 대출 예약된 도서 */
    SELECT count(*)
    INTO nCnt
    FROM reservation
    WHERE book_id = v_book_id and user_id = v_user_id;
    IF (nCnt > 0) THEN
        RAISE already_reserved;
    END IF;

    /* 도서 대출 예약은 3권이하만 가능함 */
    SELECT count(*)
    INTO nReservation
    FROM reservation
    WHERE user_id = v_user_id;
    IF (nReservation >= 3) THEN
        RAISE too_many_reservation;
    END IF;

    /* 도서 대출 예약 인원은 2명까지만 가능함 */
    nPeople := CalculateOrder(v_book_id);
    IF (nPeople >= 2) THEN
        RAISE too_many_people;
    END IF;

    /* 도서 대출 예약 */
    INSERT INTO reservation VALUES(v_user_id, v_book_id, nPeople + 1, SYSDATE);
    COMMIT;
    result := '도서 대출 예약이 완료되었습니다.';
EXCEPTION
    WHEN already_reserved THEN
        result := '이미 대출 예약한 도서입니다.';
    WHEN too_many_reservation THEN
        result := '도서 대출 예약은 최대 3권까지만 가능합니다.';
    WHEN too_many_people THEN
        result := '예약인원이 초과되어 도서 대출 예약이 불가합니다. (최대 예약 가능 인원은 2명입니다.)';
    WHEN OTHERS THEN
        result := SQLERRM;
END;
/