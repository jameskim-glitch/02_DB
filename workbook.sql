--1

SELECT DEPARTMENT_NAME AS "학과명", CATEGORY AS "계열"

FROM TB_DEPARTMENT

ORDER BY DEPARTMENT_NAME;



--2

SELECT DEPARTMENT_NAME || '의 정원은 ' || CAPACITY || '명 입니다.' AS "학과별 정원"

FROM TB_DEPARTMENT;



--3

SELECT STUDENT_NAME

FROM TB_STUDENT

WHERE DEPARTMENT_NO = '001' AND ABSENCE_YN = 'Y' AND SUBSTR(STUDENT_SSN, 8, '2') = '2';



--4

SELECT STUDENT_NAME

FROM TB_STUDENT

WHERE STUDENT_NO = 'A513079'

OR STUDENT_NO = 'A513090'

OR STUDENT_NO = 'A513091'

OR STUDENT_NO = 'A513110'

OR STUDENT_NO = 'A513119'

ORDER BY STUDENT_NAME DESC;



--5

SELECT DEPARTMENT_NAME,CATEGORY

FROM TB_DEPARTMENT

WHERE CAPACITY >= 20 AND CAPACITY <= 30;



--6

SELECT PROFESSOR_NAME

FROM TB_PROFESSOR

WHERE DEPARTMENT_NO IS NULL;



--7

SELECT STUDENT_NAME

FROM TB_STUDENT

WHERE DEPARTMENT_NO IS NULL;



--8

SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;



--9

SELECT DISTINCT(CATEGORY)
FROM TB_DEPARTMENT;



--10

SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE TO_CHAR(ENTRANCE_DATE, 'YYYY') = '2002'
AND SUBSTR(STUDENT_ADDRESS, 1, 2) = '전주'
AND ABSENCE_YN = 'N';

--춘 대학교 워크북 과제
--SQL02_SELECT(Function)

-- 1번
-- 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른 순으로 표시하는 SQL문장을 작성하시오.
-- (단, 헤더는 "학번", "이름", "입학년도" 가 표시되도록 한다.)
SELECT STUDENT_NO AS 학번, STUDENT_NAME AS 이름, TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') AS 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY ENTRANCE_DATE;

-- 2번
-- 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 두 명 있다고 한다. 그 교수의 이름과 주민번호를 화면에 출력하는 SQL문장을 작성해보자.
-- (*이때 올바르게 작성한 SQL 문장의 결과 값이 예상과 다르게 나올 수 있다. 원인이 무엇인지 생각해볼 것) ?? 무슨 말인지 잘 모르겠음
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';

-- 3번
-- 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오.
-- 단 이 때 나이가 적은 사람에서 많은 사람 순서로 화면에 출력되도록 만드시오.
-- (단, 교수 중 2000년 이후 출생자는 없으며 출력 헤더는 "교수이름"으로 한다. 나이는 '만'으로 계산한다.)
SELECT PROFESSOR_NAME 교수이름,
   FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE('19'||SUBSTR(PROFESSOR_SSN, 1, 6),'YYYYMMDD')) /12) 나이
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = '1'
ORDER BY 나이;

-- 4번
-- 교수들의 이름 중 성을 제외한 이름만 출력하는 SQL 문장을 작성하시오. 출력 헤더는 "이름"이 찍히도록 한다.
-- (성이 2자인 경우의 교수는 없다고 가정하시오)
SELECT SUBSTR(PROFESSOR_NAME, 2) AS 이름
FROM TB_PROFESSOR;

-- 5번
-- 춘 기술대학교의 재수생 입학자를 구하려고 한다 어떻게 찾아낼 거인가?
-- 이때, 19살에 입학하면 재수를 하지 않은 것으로 간주한다.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE)
 - EXTRACT(YEAR FROM TO_DATE('19'||SUBSTR(STUDENT_SSN, 1, 6),'YYYYMMDD')) > 19;

SELECT EXTRACT(YEAR FROM ENTRANCE_DATE) -- 입학년도
FROM TB_STUDENT;

SELECT EXTRACT(YEAR FROM ENTRANCE_DATE) - EXTRACT(YEAR FROM TO_DATE('19'||SUBSTR(STUDENT_SSN, 1, 6),'YYYYMMDD')) -- 학생이 태어난 년도
FROM TB_STUDENT;

-- 6번
-- 2020년 크리스마스는 무슨 요일인가?
--'DAY': 금요일 'DY': 금 'D': 6
SELECT TO_CHAR(TO_DATE('2020/12/25'), 'DAY') 
FROM DUAL;


-- 7번
-- TO_DATE('99/10/11', 'YY/MM/DD'), TO_DATE('49/10/11', 'YY/MM/DD')은 각각 몇 년 몇 월 몇 일을 의미할까?
-- 또 TO_DATE('99/10/11', 'RR/MM/DD'), TO_DATE('49/10/11', 'RR/MM/DD')은 각각 몇 년 몇 월 몇 일을 의미할까?
-- YY는 모두 2000년대
-- RR은 49이하는 2000년대 50이상은 1900년대
SELECT TO_CHAR(TO_DATE('99/10/11', 'YY/MM/DD'),'YYYY/MM/DD') "첫 번째", 
		TO_CHAR(TO_DATE('49/10/11', 'YY/MM/DD'),'YYYY/MM/DD') "두 번째",
       TO_CHAR(TO_DATE('99/10/11', 'RR/MM/DD'), 'RRRR/MM/DD') "세 번째", 
       TO_CHAR(TO_DATE('49/10/11', 'RR/MM/DD'), 'RRRR/MM/DD') "네 번째"
FROM DUAL;


-- 8번
-- 춘 기술대학교의 2000년도 이후 입학자들은 학번이 A로 시작하게 되어있다. 
-- 2000년도 이전 학번을 받은 학생들의 학번과 이름을 보여주는 SQL 문장을 작성하시오.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

-- 9번
-- 학번이 A517178인 한아름 학생의 학점 총 평점을 구하는 SQL문을 작성하시오.
-- 단, 이때 출력 화면의 헤더는 "평점"이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
SELECT ROUND(AVG(POINT),1) AS 평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

-- 10번
-- 학과별 학생 수를 구하여 "학과번호", "학생수(명)"의 형태로 헤더를 만들어 결과값이 출력되도록 하시오.
SELECT DEPARTMENT_NO 학과번호, COUNT(*) "학생수(명)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-- 11번
-- 지도 교수를 배정받지 못한 학생의 수는 몇 명 정도 되는지 알아내는 SQL문을 작성하시오
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 12번
-- 학번이 A112113인 김고운 학생의 년도 별 평점을 구하는 SQL문을 작성하시오.
-- 단, 이때 출력화면의 헤더는 "년도", "년도 별 평점"이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
SELECT SUBSTR(TERM_NO,1,4) AS 년도, ROUND(AVG(POINT),1) AS "년도 별 평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY 1;

-- 13번
-- 학과 별 휴학생 수를 파악하고자 한다. 학과 번호와 휴학생 수를 표시하는 SQL문장을 작성하시오.
SELECT DEPARTMENT_NO 학과코드명, 
SUM(DECODE(ABSENCE_YN, 'Y', 1, 0)) "휴학생 수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

SELECT DEPARTMENT_NO "학과코드명", 
COUNT(DECODE(ABSENCE_YN,'Y','Y','N',NULL))"휴학생 수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

SELECT * FROM TB_STUDENT;

-- 14번
-- 춘 대학교에 다니는 동명이인 학생들의 이름을 찾고자 한다.
-- 어떤 SQL 문장을 사용하면 가능하겠는가?
SELECT STUDENT_NAME AS 동일이름, COUNT(*) AS "동명인 수"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1
ORDER BY 1;

-- 15번
-- 학번이 A112113인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점, 총 평점을 구하는 SQL문을 작성하시오.
-- (단, 평점은 소수점 1자리까지만 반올림하여 표시한다.)
SELECT NVL(SUBSTR(TERM_NO,1,4), ' ') AS 년도, NVL(SUBSTR(TERM_NO,5,2),' ') AS 학기, ROUND(AVG(POINT),1) AS 평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO,1,4),SUBSTR(TERM_NO,5,2))
ORDER BY SUBSTR(TERM_NO,1,4);

--춘 대학교 워크북 과제
--SQL03_SELECT(Option)

-- 1번
-- 학생이름과 주소지를 표시하시오. 
-- 단, 출력 헤더는 "학생 이름", "주소지"로 하고, 정렬은 이름으로 오름차순 표시하도록 한다.
SELECT STUDENT_NAME AS "학생 이름", STUDENT_ADDRESS AS 주소지
FROM TB_STUDENT
ORDER BY 1;


-- 2번
-- 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;


-- 3번
-- 주소지가 강원도나 경기도인 학생들 중 1900년대 학번을 가진 학생들의 
-- 이름과 학번, 주소를 이름의 오름차순으로 화면에 출력하시오.
-- 단, 출력헤더에는 "학생이름", "학번", "거주지 주소"가 출력되도록 한다.
SELECT STUDENT_NAME "학생이름", STUDENT_NO 학번, STUDENT_ADDRESS "거주지 주소"
FROM TB_STUDENT
WHERE STUDENT_NO LIKE '9%'
AND (STUDENT_ADDRESS LIKE '경기도%'
OR STUDENT_ADDRESS LIKE '강원도%')
ORDER BY 1;

-- 4번
-- 현재 법학과 교수 중 가장 나이가 많은 사람부터 이름을 확인할 수 있는 SQL 문장을 작성하시오.
-- (법학과의 '학과 코드'는 학과 테이블을 조회해서 찾아 내도록 하자)

-- ANSI
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '법학과'
ORDER BY 2;

-- ORACLE
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR P, TB_DEPARTMENT D
WHERE P.DEPARTMENT_NO = D.DEPARTMENT_NO
AND DEPARTMENT_NAME = '법학과'
ORDER BY 2;


-- 5번
-- 2004년 2학기에 'C3118100' 과목을 수강한 학생들의 학점을 조회하려고 한다. 학점이 높은 학생부터 표시하고,
-- 학점이 같으면 학번이 낮은 학생부터 표시하는 구문을 작성해 보시오.
-- 워크북 결과와 동일하게 소수점 아래 2자리까지 0으로 표현하기 위해서 TO_CHAR(NUMBER, 'FM9.00') 포맷 사용
SELECT STUDENT_NO, TO_CHAR(POINT,'FM9.00') POINT
FROM TB_GRADE
WHERE TERM_NO = '200402'
AND CLASS_NO = 'C3118100'
ORDER BY POINT DESC, STUDENT_NO;


-- 6번
-- 학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬하여 출력하는 SQL문을 작성하시오.
-- ANSI
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
ORDER BY STUDENT_NAME;

-- ORACLE
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT S, TB_DEPARTMENT D
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO;


-- 7번
-- 춘 기술대학교의 과목 이름과 과목의 학과 이름을 출력하는 SQL문장을 작성하시오.

-- ANSI
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO);

-- ORACLE
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C, TB_DEPARTMENT D
WHERE C.DEPARTMENT_NO = D.DEPARTMENT_NO;


-- 8번
-- 과목별 교수 이름을 찾으려고 한다. 과목 이름과 교수 이름을 출력하는 SQL문을 작성하시오.
-- (결과 행의 수만 동일하게 조회)

-- TB_CLASS_PROFESSOR : 과목별 교수의 정보를 저장한 테이블(과목 코드, 학과 코드)
-- ANSI
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS 
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR USING(PROFESSOR_NO);

-- TB_CLASS와  TB_PROFESSOR 테이블이 공통으로
-- DEPARTMENT_NO 컬럼을 가지고 있다 해서 이를 이용해서 JOIN을 하면 안됨!
/* 
TB_CLASS와  TB_PROFESSOR 테이블을 조회 해보면
같은 컬럼 값을 가지는 DEPARTMENT_NO가 많이 존재함
--> 이럴 경우 
  TB_CLASS의  DEPARTMENT_NO 와
  TB_PROFESSOR의  DEPARTMENT_NO 컬럼 값들이
 서로 연결되기 위한 모든 경우의 수를 만들어냄 (곱집합이 되어버림)
*/
-- ORACLE
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C, TB_CLASS_PROFESSOR CP, TB_PROFESSOR P
WHERE C.CLASS_NO = CP.CLASS_NO
AND CP.PROFESSOR_NO = P.PROFESSOR_NO;


-- 9번

-- 8번의 결과 중 '인문 사회' 계열에 속한 과목의 교수 이름을 찾으려고 한다.
-- 이에 해당하는 과목 이름과 교수 이름을 출력하는 SQL문을 작성하시오.

-- ANSI
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR P USING(PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON (P.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE CATEGORY = '인문사회';

-- ORACLE
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C, TB_CLASS_PROFESSOR CP, TB_PROFESSOR P, TB_DEPARTMENT D
WHERE C.CLASS_NO = CP.CLASS_NO
AND CP.PROFESSOR_NO = P.PROFESSOR_NO
AND P.DEPARTMENT_NO = D.DEPARTMENT_NO
AND CATEGORY = '인문사회';
                        
                        
-- 10번
-- '음악학과' 학생들의 평점을 구하려고 한다. 음악학과 학생들의 "학번", "학생 이름", "전체 평점"을 출력하는 SQL 문장을 작성하시오.
-- (단, 평점은 소수점 1자리까지만 반올림하여 표시한다.)

-- ANSI
SELECT S.STUDENT_NO 학번, STUDENT_NAME "학생 이름", ROUND(AVG(POINT),1) "전체 평점"
FROM TB_GRADE G
JOIN TB_STUDENT S ON(S.STUDENT_NO = G.STUDENT_NO)
JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '음악학과'
GROUP BY S.STUDENT_NO, STUDENT_NAME
ORDER BY 1;

-- ORACLE
SELECT S.STUDENT_NO 학번, STUDENT_NAME "학생 이름", ROUND(AVG(POINT),1) "전체 평점"
FROM TB_GRADE G, TB_STUDENT S, TB_DEPARTMENT D
WHERE G.STUDENT_NO = S.STUDENT_NO
AND S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND DEPARTMENT_NAME = '음악학과'
GROUP BY S.STUDENT_NO, STUDENT_NAME
ORDER BY 1;


-- 11번
-- 학번이 A313047인 학생이 학교에 나오고 있지 않다. 지도 교수에게 내용을 전달하기 위한 학과 이름, 학생 이름과 지도 교수 이름이 필요하다.
-- 이때 사용할 SQL문을 작성하시오

-- ANSI
SELECT DEPARTMENT_NAME 학과이름, STUDENT_NAME 학생이름, PROFESSOR_NAME 지도교수이름
FROM TB_STUDENT S
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_PROFESSOR P ON(S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
WHERE STUDENT_NO = 'A313047';

-- ORACLE
SELECT DEPARTMENT_NAME 학과이름, STUDENT_NAME 학생이름, PROFESSOR_NAME 지도교수이름
FROM TB_STUDENT S, TB_DEPARTMENT D, TB_PROFESSOR P
WHERE S.COACH_PROFESSOR_NO = P.PROFESSOR_NO
AND S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND STUDENT_NO = 'A313047';

-- 12번
-- 2007년도에 '인간관계론' 과목을 수강한 학생을 찾아 학생이름과 수강학기를 표시하는 SQL 문장을 작성하시오.

-- ANSI
SELECT STUDENT_NAME, TERM_NO TERM_NAME
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
JOIN TB_CLASS USING(CLASS_NO)
WHERE CLASS_NAME = '인간관계론'
AND TERM_NO LIKE '2007%';

-- ORACLE
SELECT STUDENT_NAME, TERM_NO TERM_NAME
FROM TB_STUDENT S, TB_GRADE G, TB_CLASS C
WHERE S.STUDENT_NO = G.STUDENT_NO
AND G.CLASS_NO = C.CLASS_NO
AND CLASS_NAME = '인간관계론'
AND TERM_NO LIKE '2007%';


-- 13번
-- 예체능 계열 과목 중 과목 담당교수를 한 명도 배정받지 못한 과목을 찾아 
-- 그 과목 이름과 학과 이름을 출력하는 SQL 문장을 작성하시오.
-- (결과 행의 수만 동일하게 조회)

-- ANSI
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C
LEFT JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE CATEGORY = '예체능'
AND PROFESSOR_NO IS NULL;

-- ORACLE
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C, TB_CLASS_PROFESSOR P, TB_DEPARTMENT D
WHERE C.CLASS_NO = P.CLASS_NO(+)
AND C.DEPARTMENT_NO = D.DEPARTMENT_NO
AND CATEGORY = '예체능'
AND PROFESSOR_NO IS NULL;


-- 14번
-- 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 한다. 
-- 학생이름과 지도교수 이름을 찾고 만일 지도 교수가 없는 학생일 경우
-- "지도교수 미지정"으로 표시하도록 하는 SQL 문을 작성하시오.
-- 단 출력헤더는 "학생이름", "지도교수"로 표시하며 고학번 학생이 먼저 표시되도록 한다.

-- ANSI
SELECT STUDENT_NAME 학생이름, NVL(PROFESSOR_NAME, '지도교수 미지정') 지도교수
FROM TB_STUDENT S
LEFT JOIN TB_PROFESSOR P ON(S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '서반아어학과'
ORDER BY STUDENT_NO;

-- ORACLE
SELECT STUDENT_NAME 학생이름, NVL(PROFESSOR_NAME, '지도교수 미지정') 지도교수
FROM TB_STUDENT S, TB_PROFESSOR P, TB_DEPARTMENT D 
WHERE S.COACH_PROFESSOR_NO = P.PROFESSOR_NO(+)
AND S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND DEPARTMENT_NAME = '서반아어학과'
ORDER BY STUDENT_NO;


-- 15번
-- 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아 그 학생의 학번, 이름, 학과, 이름, 평점을 출력하는 SQL문을 작성하시오.

-- ANSI
SELECT STUDENT_NO 학번, STUDENT_NAME 이름, DEPARTMENT_NAME "학과 이름", TRUNC(AVG(POINT),8) 평점
FROM TB_STUDENT 
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_GRADE USING(STUDENT_NO)
WHERE ABSENCE_YN = 'N'
GROUP BY STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
HAVING AVG(POINT) >= 4
ORDER BY 1;

-- ORACLE
SELECT S.STUDENT_NO 학번, STUDENT_NAME 이름, DEPARTMENT_NAME "학과 이름", TRUNC(AVG(POINT),8) 평점
FROM TB_STUDENT S, TB_DEPARTMENT D, TB_GRADE G
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND S.STUDENT_NO = G.STUDENT_NO
AND ABSENCE_YN = 'N'
GROUP BY S.STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
HAVING AVG(POINT) >= 4
ORDER BY 1;


-- 16번
-- 환경조경학과 전공과목들의 과목 별 평점을 파악할 수 있는 SQL 문을 작성하시오.
-- ANSI
SELECT CLASS_NO, CLASS_NAME, TRUNC(AVG(POINT),8)
FROM TB_CLASS 
JOIN TB_GRADE USING(CLASS_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '환경조경학과'
AND CLASS_TYPE LIKE '전공%'
GROUP BY CLASS_NO, CLASS_NAME
ORDER BY 1;

-- ORACLE
SELECT C.CLASS_NO, CLASS_NAME, TRUNC(AVG(POINT),8)
FROM TB_CLASS C, TB_GRADE G, TB_DEPARTMENT D
WHERE C.CLASS_NO = G.CLASS_NO
AND C.DEPARTMENT_NO = D.DEPARTMENT_NO
AND DEPARTMENT_NAME = '환경조경학과'
AND CLASS_TYPE LIKE '전공%'
GROUP BY C.CLASS_NO, CLASS_NAME
ORDER BY 1;



-- 17번
-- 춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 주소를 출력하는 SQL 문을 작성하시오.
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                       FROM TB_STUDENT
                       WHERE STUDENT_NAME = '최경희');
                       
-- 18번
-- 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 SQL문을 작성하시오
SELECT STUDENT_NO, STUDENT_NAME
FROM
    (SELECT STUDENT_NO, STUDENT_NAME, AVG(POINT) 평점
    FROM TB_GRADE
    JOIN TB_STUDENT USING(STUDENT_NO)
    WHERE DEPARTMENT_NO  = (SELECT DEPARTMENT_NO
                      FROM TB_DEPARTMENT
                      WHERE DEPARTMENT_NAME = '국어국문학과')
    GROUP BY STUDENT_NO, STUDENT_NAME
    ORDER BY 평점 DESC)
WHERE ROWNUM = 1;

-- 19번
-- 춘 기술대학교의 "환경조경학과"가 속한 같은 계열 학과들의 학과 별 전공과목 평점을 파악하기 위한 적절한 SQL문을 찾아내시오.
-- 단, 출력헤더는 "계열 학과명", "전공평점"으로 표시되도록 하고, 평점은 소수점 한자리까지만 반올림하여 표시되도록 한다.
-- ANSI
SELECT DEPARTMENT_NAME "계열 학과명", ROUND(AVG(POINT),1) 전공평점
FROM TB_DEPARTMENT 
JOIN TB_CLASS USING(DEPARTMENT_NO)
JOIN TB_GRADE USING(CLASS_NO)
WHERE CATEGORY = (SELECT CATEGORY
                  FROM TB_DEPARTMENT
                  WHERE DEPARTMENT_NAME = '환경조경학과')
AND CLASS_TYPE LIKE '전공%'
GROUP BY DEPARTMENT_NAME
ORDER BY 1;

-- ORACLE
SELECT DEPARTMENT_NAME "계열 학과명", ROUND(AVG(POINT),1) 전공평점
FROM TB_DEPARTMENT D, TB_CLASS C, TB_GRADE G
WHERE D.DEPARTMENT_NO = C.DEPARTMENT_NO
AND C.CLASS_NO = G.CLASS_NO
AND CATEGORY = (SELECT CATEGORY
                FROM TB_DEPARTMENT
                WHERE DEPARTMENT_NAME = '환경조경학과')
AND CLASS_TYPE LIKE '전공%'
GROUP BY DEPARTMENT_NAME
ORDER BY 1;

