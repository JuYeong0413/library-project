CREATE OR REPLACE PROCEDURE RETURNBOOK
(v_lend_id IN lend.lend_id%TYPE, result OUT VARCHAR2)
IS
    sReturnDate lend.return_schedule%TYPE;
    nCnt NUMBER;
    nOverdue NUMBER;
BEGIN
    result := '';
    nCnt := 0;
    nOverdue := 0;

    SELECT TRUNC(SYSDATE - return_schedule, 0)
    INTO nCnt
    FROM lend
    WHERE lend_id = v_lend_id;

    /* 반납 처리 */
    UPDATE lend
    SET return_date = SYSDATE
    WHERE lend_id = v_lend_id;

    /* 연체된 경우 */
    IF (nCnt > 0) THEN
        UPDATE lend
        SET overdue = nCnt
        WHERE lend_id = v_lend_id;
        COMMIT;
        result := TO_CHAR(nCnt) || '일 연체되었습니다. 연체료는 ' || TO_CHAR(nCnt * 100) || '원 입니다.';
    ELSE
        UPDATE lend
        SET overdue = 0
        WHERE lend_id = v_lend_id;
        COMMIT;
        result := '도서 반납이 완료되었습니다.';
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        result := SQLERRM;
END;
/