CREATE OR REPLACE TRIGGER BEFOREUPDATEUSERS
BEFORE UPDATE ON users
FOR EACH ROW
DECLARE
    invalid_phone EXCEPTION;
    underflow_password EXCEPTION;
    invalid_password EXCEPTION;
    nLength NUMBER;
    nBlank NUMBER;
    v_phone users.phone%TYPE;
BEGIN
    /* 연락처 제약조건 : 숫자만 입력되어야 함 */
    SELECT :new.phone
    INTO v_phone
    FROM DUAL;
    IF (regexp_like(v_phone, '[^[:digit:]]')) THEN
        RAISE invalid_phone;
    END IF;

    /* 비밀번호 제약조건 : 4자리 이상, blank는 허용안함 */
    SELECT length(:new.password), instr(:new.password, ' ')
    INTO nLength, nBlank
    FROM DUAL;
    IF (nLength < 4) THEN
        RAISE underflow_password;
    ELSIF (nBlank > 0) THEN
        RAISE invalid_password;
    END IF;
EXCEPTION
    WHEN invalid_phone THEN
        RAISE_APPLICATION_ERROR(-20012, '연락처에는 숫자만 입력해야 합니다.');
    WHEN underflow_password THEN
        RAISE_APPLICATION_ERROR(-20013, '암호는 4자리 이상이어야 합니다.');
    WHEN invalid_password THEN
        RAISE_APPLICATION_ERROR(-20014, '암호에 공란은 입력되지 않습니다.');
END;
/