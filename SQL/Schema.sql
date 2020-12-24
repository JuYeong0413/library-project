/* 프로젝트 테이블 */
/*
도서카테고리(category) : 카테고리번호, 카테고리명
도서(books) : 도서번호, ISBN, 제목, 저자, 출판사, 출판일, 카테고리번호
사용자(user) : 아이디, 패스워드, 이름, 연락처, 주소, 이메일
희망도서(wish) : 희망도서번호, 제목, 저자, 출판사, 코멘트, 아이디
예약(reservation) : 아이디, 도서번호, 순번, 예약일
대출(lend) : 대출번호, 아이디, 도서번호, 대출일, 반납예정일, 반납완료일, 연체일수
*/

DROP TABLE category CASCADE CONSTRAINTS;
DROP TABLE books CASCADE CONSTRAINTS;
DROP TABLE users CASCADE CONSTRAINTS;
DROP TABLE wish CASCADE CONSTRAINTS;
DROP TABLE reservation CASCADE CONSTRAINTS;
DROP TABLE lend CASCADE CONSTRAINTS;

CREATE TABLE category
(
    category_number  NUMBER(3)   not null,
    category_name    VARCHAR2(20)   not null,
    CONSTRAINT ca_pk PRIMARY KEY (category_number)
);

INSERT INTO category VALUES (000, '총류');
INSERT INTO category VALUES (100, '철학');
INSERT INTO category VALUES (200, '종교');
INSERT INTO category VALUES (300, '사회과학');
INSERT INTO category VALUES (400, '자연과학');
INSERT INTO category VALUES (500, '기술과학');
INSERT INTO category VALUES (600, '예술');
INSERT INTO category VALUES (700, '언어');
INSERT INTO category VALUES (800, '문학');
INSERT INTO category VALUES (900, '역사');


CREATE TABLE books
(
    book_id	    VARCHAR2(10),
    isbn    VARCHAR2(30)   not null,
    title    VARCHAR2(50)   not null,
    author     VARCHAR2(50)   not null,
    publisher    VARCHAR2(50)   not null,
    published_date   DATE,
    category_number   NUMBER(3)   not null,
    CONSTRAINT bo_pk PRIMARY KEY (book_id),
    CONSTRAINT bo_category_number_fk FOREIGN KEY (category_number) REFERENCES category (category_number)
);

INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-001', '9788952238054', '도시재생 이야기', '윤주', '살림', '17/10/23', 000);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-002', '9788965592495', '진짜 공부머리 독서법', '서예나', '푸른날개', '19/12/05', 000);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-003', '9791189938338', '메모 독서법', '신정철', '위즈덤하우스', '19/03/15', 000);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-004', '9791190538206', '홀로서기 심리학', '라라 E. 필딩', '메이븐', '20/11/19', 100);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-005', '9788967358020', '매우 예민한 사람들을 위한 책', '전홍진', '글항아리', '20/07/23', 100);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-006', '9791196067694', '12가지 인생의 법칙', '조던 B. 피터슨', '메이븐', '18/10/30', 100);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-007', '9788960975712', '153 감사 노트', '이찬수', '규장', '19/03/25', 200);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-008', '9788953138742', '기도의 자리로', 'C. S. 루이스', '두란노서원', '20/10/21', 200);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-009', '9788954637169', '법륜 스님의 행복', '법륜', '나무의마음', '16/08/17', 200);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-010', '9791164136452', '공정하다는 착각', '마이클 샌델', '와이즈베리', '20/12/01', 300);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-011', '9791130630762', '아비투스', '도리스 메르틴', '다산초당', '20/08/03', 300);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-012', '9788960517776', '두 번째 산', '데이비드 브룩스', '부키', '20/09/24', 300);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-013', '9788950993016', '이런 수학은 처음이야', '최영기', '21세기북스', '20/11/11', 400);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-014', '9788983711892', '코스모스', '칼 세이건', '사이언스북스', '10/01/20', 400);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-015', '9788932473901', '이기적 유전자', '리처드 도킨스', '을유문화사', '18/10/20', 400);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-016', '9788962630619', '침묵의 봄', '레이첼 카슨', '에코리브르', '11/12/30', 500);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-017', '9791196548704', '살수록 고마운 집', '원대연', '플러스북스', '19/05/20', 500);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-018', '9788955266344', '퍼펙트 물리', '정완상', '북스힐', '10/01/10', 500);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-019', '9788968331862', '방구석 미술관', '조원재', '블랙피쉬', '20/05/05', 600);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-020', '9788970840659', '서양미술사', 'E. H. 곰브리치', '예경', '03/07/10', 600);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-021', '9788961963695', '반 고흐, 별이 빛나는 밤', '마틴 베일리', '아트북스', '20/04/10', 600);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-022', '9788960498310', '영어 회화의 결정적 단어들', '서영조', '사람in', '20/03/06', 700);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-023', '9788936320485', '영어 전치사 연구', '이기동', '교문사', '20/05/18', 700);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-024', '9791188674039', '써먹는 영문법', '브랜던 로열', '카시오페아', '17/12/22', 700);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-025', '9791165341909', '달러구트 꿈 백화점', '이미예', '팩토리나인', '20/07/08', 800);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-026', '9788954675987', '일인칭 단수', '무라카미 하루키', '문학동네', '20/11/26', 800);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-027', '9788936434267', '아몬드', '손원평', '창비', '17/03/31', 800);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-028', '9788934972464', '사피엔스', '유발 하라리', '김영사', '15/11/24', 900);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-029', '9788970127248', '총 균 쇠', '재레드 다이아몬드', '문학사상', '05/12/19', 900);
INSERT INTO books (book_id, isbn, title, author, publisher, published_date, category_number) VALUES
('B-030', '9788933870693', '설민석의 조선왕조실록', '설민석', '세계사', '16/07/20', 900);


CREATE TABLE users
(
    user_id   	VARCHAR2(10),
    name  VARCHAR2(50)   not null,
    phone  VARCHAR2(20)   not null,
    address     VARCHAR2(200),
    email  VARCHAR2(100),
    password  VARCHAR2(10)   not null,
    CONSTRAINT us_pk PRIMARY KEY (user_id)
);

INSERT INTO users (user_id, name, phone, address, email, password) VALUES
('U-100', '이주영', '01072553753', '서울 강남구 삼성로4길 17', '2jy22@naver.com', '1234');
INSERT INTO users (user_id, name, phone, address, email, password) VALUES
('U-200', '신경화', '01012345678', '경기도 화성군 송산면 고정1리 540-2', null, '1235');
INSERT INTO users (user_id, name, phone, address, email, password) VALUES
('U-300', '서용만', '01098765432', '경기도 용인시 기흥읍 농서리 산24', null, '1236');
INSERT INTO users (user_id, name, phone, address, email, password) VALUES
('U-400', '고정환', '01011112222', '경기도 수원시 팔달구 매탄3동 416번지', null, '1237');
INSERT INTO users (user_id, name, phone, address, email, password) VALUES
('U-500', '홍길동', '01012341234', '서울 동대문구 회기동 101-6', null, '1238');


CREATE TABLE wish
(
    wish_id	       VARCHAR2(10),
    title      VARCHAR2(100),
    author    VARCHAR2(100),
    publisher      VARCHAR2(100),
    wish_comment         VARCHAR2(200),
    registration_date   DATE not null,
    user_id	       VARCHAR2(10),
    CONSTRAINT wi_pk PRIMARY KEY (wish_id),
    CONSTRAINT wi_user_id_fk FOREIGN KEY (user_id) REFERENCES users (user_id)
);

INSERT INTO wish VALUES ('W-1', '우리가 기억하고 싶은 순간', '이규영', '넥서스BOOKS', '곧 출간될 책인데 관심있어서 보고싶습니다.', '2020/12/15', 'U-100');
INSERT INTO wish VALUES ('W-2', '모두의 안드로이드', '최원효', '길벗', null, '2020/12/13', 'U-100');
INSERT INTO wish VALUES ('W-3', '인생은 소설이다', '기욤 뮈소', '밝은세상', null, '2020/11/29', 'U-100');
INSERT INTO wish VALUES ('W-4', '위기의 시대, 돈의 미래', '짐 로저스', '리더스북', null, '2020/11/27', 'U-200');
INSERT INTO wish VALUES ('W-5', '2인조', '이석원', '달', null, '2020/12/04', 'U-300');
INSERT INTO wish VALUES ('W-6', '엑시트(Exit)', '송희창', '지혜로', null, '2020/12/10', 'U-300');
INSERT INTO wish VALUES ('W-7', 'HEAT(히트)', '스윙스', '필름(Feelm)', null, '2020/11/11', 'U-400');
INSERT INTO wish VALUES ('W-8', '추리소설가의 살인사건', '히가시노 게이고', '소미미디어', '제가 좋아하는 작가의 책입니다.', '2020/11/28', 'U-500');
INSERT INTO wish VALUES ('W-9', '부의 골든타임', '박종훈', '인플루엔셜', null, '2020/12/13', 'U-500');


CREATE TABLE reservation
(
    user_id	     VARCHAR2(10),
    book_id	     VARCHAR2(10),
    r_order    NUMBER(1)   not null,
    reservation_date      DATE   not null,
    CONSTRAINT re_pk PRIMARY KEY (user_id, book_id),
    CONSTRAINT re_user_id_fk FOREIGN KEY (user_id) REFERENCES  users (user_id),
    CONSTRAINT re_book_id_fk FOREIGN KEY (book_id) REFERENCES  books (book_id)
);

INSERT INTO reservation VALUES ('U-300', 'B-029', 1, '20/12/14');
INSERT INTO reservation VALUES ('U-400', 'B-029', 2, '20/12/15');
INSERT INTO reservation VALUES ('U-200', 'B-004', 1, '20/12/13');
INSERT INTO reservation VALUES ('U-500', 'B-022', 1, '20/12/13');


CREATE TABLE lend
(
    lend_id	   VARCHAR2(10),
    user_id	   VARCHAR2(10),
    book_id  VARCHAR2(10),
    lend_date    DATE   not null,
    return_date    DATE,
    return_schedule    DATE   not null,
    overdue   NUMBER(3),
    CONSTRAINT le_pk PRIMARY KEY (lend_id),
    CONSTRAINT le_user_id_fk FOREIGN KEY (user_id) REFERENCES  users (user_id),
    CONSTRAINT le_book_id_fk FOREIGN KEY (book_id) REFERENCES  books (book_id)
);

INSERT INTO lend VALUES ('L-1', 'U-100', 'B-029', '20/11/27', '20/12/02', '20/12/04', 0);
INSERT INTO lend VALUES ('L-2', 'U-100', 'B-011', '20/11/27', '20/12/02', '20/12/11', 0);
INSERT INTO lend VALUES ('L-3', 'U-100', 'B-014', '20/12/01', null, '20/12/08', null);
INSERT INTO lend VALUES ('L-4', 'U-100', 'B-022', '20/12/11', null, '20/12/18', null);
INSERT INTO lend VALUES ('L-5', 'U-300', 'B-004', '20/12/11', null, '20/12/18', null);
INSERT INTO lend VALUES ('L-6', 'U-200', 'B-029', '20/12/13', null, '20/12/20', null);
INSERT INTO lend VALUES ('L-7', 'U-400', 'B-015', '20/12/14', null, '20/12/21', null);
INSERT INTO lend VALUES ('L-8', 'U-500', 'B-003', '20/12/15', null, '20/12/22', null);

COMMIT;
