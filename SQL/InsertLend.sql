CREATE OR REPLACE PROCEDURE INSERTLEND
(v_book_id IN books.book_id%TYPE, v_user_id IN users.user_id%TYPE, result OUT VARCHAR2)
IS
    too_many_books EXCEPTION;
    has_overdue EXCEPTION;
    nIndex NUMBER;
    sLendId lend.lend_id%TYPE;
    nCnt NUMBER;
    sDate lend.return_schedule%TYPE;
    sTitle books.title%TYPE;
BEGIN
    result := '';
    nCnt := 0;

    SELECT count(*)
    INTO nIndex
    FROM lend;
    nIndex := nIndex + 1;
    sLendId := 'L-' || TO_CHAR(nIndex);

    /* 3권 이상 대출할 수 없음 */
    SELECT count(*)
    INTO nCnt
    FROM lend
    WHERE user_id = v_user_id and return_date IS NULL;
    IF (nCnt >= 3) THEN
        RAISE too_many_books;
    END IF;

    /* 연체된 도서가 있는 경우 대출할 수 없음 */
    SELECT MIN(return_schedule)
    INTO sDate
    FROM lend
    WHERE user_id = v_user_id and overdue IS NULL;
    IF (SYSDATE > sDate) THEN
        RAISE has_overdue;
    END IF;

    /* 도서 대출 */
    SELECT title
    INTO sTitle
    FROM books
    WHERE book_id = v_book_id;

    INSERT INTO lend VALUES (sLendId, v_user_id, v_book_id, SYSDATE, NULL, SYSDATE + 7, NULL);
    COMMIT;
    result := sTitle || ' 대출이 완료되었습니다.';
EXCEPTION
    WHEN too_many_books THEN
        result := '도서 대출은 최대 3권까지 가능합니다.';
    WHEN has_overdue THEN
        result := '현재 반납이 연체된 도서가 있어서 대출이 불가합니다.';
    WHEN OTHERS THEN
        ROLLBACK;
        result := SQLERRM;
END;
/