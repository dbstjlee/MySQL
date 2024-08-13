-- 1단계

select * from history_tb;
select * from account_tb;

-- 1번 계좌에서 출금 내역
select * from history_tb where w_account_id = 1;

-- 1번 계좌에서 입금 내역
select * from history_tb where d_account_id = 1;


-- 2단계
-- 계좌 번호와 함께 출력하기 --
-- 한 계좌에 대한 모든 출금 내역을 확인 한다면

-- 1번 계좌에 대한 출금 내역 + 계좌번호 출력하기 
select h.id, h.amount, h.w_balance, a.number, h.created_at
from history_tb as h
left join account_tb as a on h.w_account_id = a.id
where h.w_account_id = 1;

-- 1번 계좌에 대한 입금 내역 + 계좌번호 출력하기 
select h.id, h.amount, h.d_balance, a.number, h.created_at
from history_tb as h
left join account_tb as a on h.d_account_id = a.id
where h.d_account_id = 1;



-- coalesce 사용법 및 CAST 사용법
SELECT COALESCE(2, 1, 'third_value', 'fourth_value'); -- 2
SELECT COALESCE(NULL, 1, 'third_value', 'fourth_value'); -- 1
SELECT COALESCE(NULL, NULL, 'third_value', 'fourth_value'); -- third_value
SELECT COALESCE(NULL, NULL, NULL, 'fourth_value'); -- fourth_value
SELECT COALESCE(NULL, NULL, NULL, NULL);  -- NULL

-- select CAST('123' as INT); -- 실행 안 되지만 h2-console에서는 실행됨.
select CAST('123' as signed); -- 양수, 음수 다 포함
select CAST(-123 as signed); -- 양수, 음수 다 포함 --> -123 출력됨
select CAST('123' as unsigned); -- 양수만을 표현할 때 사용



-- 3단계
-- 출금이 만약 이체라면 키 값에 receiver(금액의 대상)을 출력
-- 1번 계좌에 대한 출금 내역
select h.id, h.amount, h.w_balance as balance, a.number, h.created_at,
	   coalesce(CAST(h.d_account_id as char(10)), 'ATM') as receiver 
from history_tb as h
left join account_tb as a on h.w_account_id = a.id
where h.w_account_id = 1;

-- 1번 계좌에 대한 입금 내역
select h.id, h.amount, h.d_balance as balance, a.number, h.created_at,
	coalesce(CAST(h.w_account_id as char(10)), 'ATM') as sender
from history_tb as h
left join account_tb as a on h.d_account_id = a.id
where h.d_account_id = 1;


-- desc history_tb; -> w_account_id와 d_account_id는 int지만 char로 형변환(CAST) 함.
desc history_tb;

-- 4단계
-- 1번 계좌에 대한 입출금, 이체 전체 내역 확인
select h.id, h.amount,
	case
		when h.w_account_id = 1 then(h.w_balance)
		when h.d_account_id = 1 then(h.d_balance)
	end as balance,
    coalesce(CAST(wa.number as char(10)), 'ATM') as sender,
    coalesce(CAST(da.number as char(10)), 'ATM') as receiver,
    h.created_at
from history_tb as h
left join account_tb as wa on h.w_account_id = wa.id
left join account_tb as da on h.d_account_id = da.id
where h.w_account_id =  1 or h.d_account_id = 1
order by h.created_at DESC;


-- when h.w_account_id = 1 then(h.w_balance)
-- > 출금 id가 1번일 때 출력 후 잔액을 출력해야 한다. (출금)

-- when h.d_account_id = 1 then(h.d_balance)
-- > 입금 id가 1번일 때 입금 후 잔액을 출력해야 한다. (입금)






-- 코드 상에서 사용할 쿼리 생성

-- 출금에 대한 쿼리 출력
-- receiver : 금액을 받는 대상,
-- 기능적으로 하나의 JSP 페이지에서 전체 쿼리에 대한 결과 집합의 컬럼명을 
-- 동일하게 사용할 수 있도록 쿼리를 수정한다. (같은 Model Class에 담을 예정)

-- 출금 
-- 1111 --> ATM 출금, 1111 ---> 2222 이체

select h.id, h.amount, h.w_balance AS balance, h.created_at,
		coalesce(CAST(da.number as char(10)), 'ATM') as receiver,
        wa.number as sender
from history_tb as h
left join account_tb as wa on wa.id = h.w_account_id
left join account_tb as da on da.id = h.d_account_id
where h.w_account_id = 1;

-- da.number, d_account_id == null(ATM이 되어야 함)(받은 이)


-- 입금에 대한 쿼리 출력
-- ATM --> 1111 계좌로 입금, 다른 계좌 --> 1111 계좌로 입금
select h.id, h.amount, h.d_balance AS balance, h.created_at,
		coalesce(CAST(wa.number as char(10)), 'ATM') as sender,
        da.number as receiver
from history_tb as h
left join account_tb as wa on wa.id = h.w_account_id
left join account_tb as da on da.id = h.d_account_id
where h.d_account_id = 1;

-- wa.number, w_account_id == null(ATM이 되어야 함)(보낸이)

select * from account_tb where id = 1;


select count(*)
from history_tb as h
where h.w_account_id = 1 or h.d_account_id = 1;


select count(*)
			from history_tb as h 
			where h.d_account_id = 1;

select count(*)
			from history_tb as h 
			where h.w_account_id = 1;
            
            
            
            select h.id, h.amount,
				case
					when h.w_account_id = #{accountId} then (h.w_balance) 
			        when h.d_account_id = #{accountId} then (h.d_balance)
			    end  as balance,
			    coalesce(cast(wa.number as char(10)), 'ATM') as sender, 
			    coalesce(cast(da.number as char(10)), 'ATM') as receiver,
			    h.created_at
			from history_tb as h 
			left join account_tb as wa on h.w_account_id = wa.id
			left join account_tb as da on h.d_account_id = da.id  
			where h.w_account_id = #{accountId} OR h.d_account_id = #{accountId}
			order by h.created_at DESC
			limit #{limit} offset #{offset}
