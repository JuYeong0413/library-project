CREATE OR REPLACE PROCEDURE EXTENDLEND
(v_lend_id IN lend.lend_id%TYPE, result OUT VARCHAR2)
IS
    already_extended EXCEPTION;
    has_reservation EXCEPTION;
    overdue_exception EXCEPTION;
    sReturnDate lend.return_schedule%TYPE;
    nDaysCnt NUMBER;
    nUsersCnt NUMBER;
    nOverdue NUMBER;
BEGIN
    result := '';
    nDaysCnt := 0;
    nUsersCnt := 0;
    nOverdue := 0;

    SELECT return_schedule, return_schedule - lend_date
    INTO sReturnDate, nDaysCnt
    FROM lend
    WHERE lend_id = v_lend_id;

    /* 연체된 도서는 연장 불가능 */
    SELECT SYSDATE - return_schedule
    INTO nOverdue
    FROM lend
    WHERE lend_id = v_lend_id;
    IF (nOverdue > 0) THEN
        RAISE overdue_exception;
    END IF;

    /* 대출연장은 1회만 가능함 */
    IF (nDaysCnt > 7) THEN
        RAISE already_extended;
    END IF;

    /* 대출이 예약된 도서는 연장 불가능 */
    SELECT count(*)
    INTO nUsersCnt
    FROM reservation
    WHERE book_id = (SELECT book_id FROM lend WHERE lend_id = v_lend_id);
    IF (nUsersCnt > 0) THEN
        RAISE has_reservation;
    END IF;

    /* 도서 대출 연장 */
    UPDATE lend
    SET return_schedule = sReturnDate + 7
    WHERE lend_id = v_lend_id;
    COMMIT;
    result := '도서 대출 연장이 완료되었습니다.';
EXCEPTION
    WHEN already_extended THEN
        result := '이미 대출연장된 도서입니다. (대출연장은 1회만 가능합니다.)';
    WHEN has_reservation THEN
        result := '대출이 예약된 도서이므로 연장이 불가합니다.';
    WHEN overdue_exception THEN
        result := '연체된 도서는 연장이 불가합니다.';
    WHEN OTHERS THEN
        ROLLBACK;
        result := SQLERRM;
END;
/