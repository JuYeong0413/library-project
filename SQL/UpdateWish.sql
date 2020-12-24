CREATE OR REPLACE PROCEDURE UPDATEWISH
(v_title IN wish.title%TYPE, v_author IN wish.author%TYPE, v_publisher IN wish.publisher%TYPE, v_comment IN wish.wish_comment%TYPE, v_wish_id IN wish.wish_id%TYPE, v_user_id IN wish.user_id%TYPE, result OUT VARCHAR2)
IS
    value_not_entered EXCEPTION;
    sTitle wish.title%TYPE;
    sAuthor wish.author%TYPE;
    sPublisher wish.publisher%TYPE;
BEGIN
    result := '';

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

    UPDATE wish SET title = v_title, author = v_author, publisher = v_publisher, wish_comment = v_comment
    WHERE wish_id = v_wish_id and user_id = v_user_id;
    COMMIT;
    result := '희망도서 신청정보가 수정되었습니다.';
EXCEPTION
    WHEN value_not_entered THEN
        RAISE_APPLICATION_ERROR(-20015, '도서제목, 저자, 출판사 정보를 모두 입력해주세요.');
    WHEN OTHERS THEN
        ROLLBACK;
        result := SQLERRM;
END;
/
