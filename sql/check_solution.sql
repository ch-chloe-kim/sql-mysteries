-- check_solution: solution 테이블에 INSERT하면 정답 여부 메시지로 바꿔 주는 트리거
-- sql-murder-mystery.db 안에 들어 있는 정의를 그대로 꺼낸 것 (diff를 텍스트로 보기 위함)
DROP TRIGGER IF EXISTS check_solution;
CREATE TRIGGER check_solution AFTER INSERT ON solution
    WHEN new.user==1
    BEGIN
        DELETE FROM solution;
        INSERT INTO solution VALUES (0,
        CASE WHEN hex(new.value)=='4A6572656D7920426F77657273' THEN "Congrats, you found the murderer! But wait, there's more... If you think you're up for a challenge, try querying the interview transcript of the murderer to find the real villain behind this crime. If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries. Use this same INSERT statement with your new suspect to check your answer."
             WHEN hex(new.value)=='4D6972616E6461205072696573746C79' THEN "Congrats, you found the brains behind the murder! Everyone in SQL City hails you as the greatest SQL detective of all time. Time to break out the champagne!"
             ELSE "That's not the right person. Try again!"
        END
        );
    END;
