-- check_solution: solution 테이블에 INSERT하면 정답 여부 메시지로 바꿔 주는 트리거
-- sql-murder-mystery.db 안에 들어 있는 정의를 그대로 꺼낸 것 (diff를 텍스트로 보기 위함)
DROP TRIGGER IF EXISTS check_solution;
CREATE TRIGGER check_solution AFTER INSERT ON solution
    WHEN new.user==1
    BEGIN
        DELETE FROM solution;
        INSERT INTO solution VALUES (0,
        CASE WHEN hex(new.value)=='4A6572656D7920426F77657273' THEN '범인을 찾았습니다! 하지만 끝이 아닙니다... 범인의 인터뷰 기록(interview)을 조회해서 이 사건을 꾸민 진짜 배후를 찾아보세요. 자신 있다면 쿼리 2개 이내로 도전해 보세요. 새 용의자도 같은 INSERT 문으로 확인할 수 있습니다.'
             WHEN hex(new.value)=='4D6972616E6461205072696573746C79' THEN '축하합니다, 사건의 배후까지 찾아냈습니다! SQL City의 모든 사람이 당신을 최고의 SQL 탐정으로 칭송합니다. 샴페인을 터뜨릴 시간입니다!'
             ELSE '범인이 아닙니다. 다시 시도해 보세요!'
        END
        );
    END;
