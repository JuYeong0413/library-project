CREATE OR REPLACE PROCEDURE INSERTWISH
(v_title IN wish.title%TYPE, v_author IN wish.author%TYPE, v_publisher IN wish.publisher%TYPE, v_comment IN wish.wish_comment%TYPE, v_user_id IN wish.user_id%TYPE, result OUT VARCHAR2)
IS
    too_many_wishes EXCEPTION;
    nIndex NUMBER;
    nCnt NUMBER;
    sWish wish.wish_id%TYPE;
    nYear NUMBER;
    nMonth NUMBER;
    sStart DATE;
    sEnd DATE;
    value_not_entered EXCEPTION;
    sTitle wish.title%TYPE;
    sAuthor wish.author%TYPE;
    sPublisher wish.publisher%TYPE;
BEGIN
    result := '';
    nIndex := 0;
    nCnt := 0;

    SELECT wish_id
    INTO sWish
    FROM wish
    WHERE rowid = (SELECT MAX(rowid) FROM wish);

    SELECT TO_NUMBER(SUBSTR(sWish, INSTR(sWish, '-') + 1))
    INTO nIndex
    FROM DUAL;
    sWish := 'W-' || TO_CHAR(nIndex + 1);

    /* 희망도서는 한 달에 3권까지만 신청이 가능함 */
    SELECT TO_NUMBER(TO_CHAR(SYSDATE, 'YY')), TO_NUMBER(TO_CHAR(SYSDATE, 'MM'))
    INTO nYear, nMonth
    FROM DUAL;
    sStart := TO_CHAR(nYear) || '/' || TO_CHAR(nMonth) || '/01';
    sEnd := ADD_MONTHS (sStart, 1);
    sStart := sStart - 1;

    SELECT count(*)
    INTO nCnt
    FROM wish
    WHERE user_id = v_user_id and registration_date BETWEEN sStart AND sEnd;
    IF (nCnt >= 3) THEN
        RAISE too_many_wishes;
    END IF;

    /* 도서제목에 NULL 값을 입력할 수 없음 */
    SELECT v_title
    INTO sTitle
    FROM DUAL;
    IF (sTitle IS NULL) THEN
        RAISE value_not_entered;
    END IF;

    /* 저자에 NULL 값을 입력할 수 없음 */
    SELECT v_author
    INTO sAuthor
    FROM DUAL;
    IF (sAuthor IS NULL) THEN
        RAISE value_not_entered;
    END IF;

    /* 출판사에 NULL 값을 입력할 수 없음 */
    SELECT v_publisher
    INTO sPublisher
    FROM DUAL;
    IF (sPublisher IS NULL) THEN
        RAISE value_not_entered;
    END IF;

    INSERT INTO wish VALUES (sWish, v_title, v_author, v_publisher, v_comment, SYSDATE, v_user_id);
    COMMIT;
    result := '희망도서신청이 완료되었습니다.';
EXCEPTION
    WHEN too_many_wishes THEN
        result := '희망도서신청은 매달 3권까지만 가능합니다.';
    WHEN value_not_entered THEN
        RAISE_APPLICATION_ERROR(-20015, '도서제목, 저자, 출판사 정보를 모두 입력해주세요.');
    WHEN OTHERS THEN
        ROLLBACK;
        result := SQLERRM;
END;
/
