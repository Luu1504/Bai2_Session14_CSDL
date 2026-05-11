create database cntt6_session14;

use cntt6_session14;

create table accounts (
	id int primary key auto_increment,
    customer_name varchar(100) not null,
    balance decimal(10, 2)
);

insert into accounts(customer_name, balance)
values 	('Nguyễn Văn A', 100000),
		('Nguyễn Văn B', 200000);

DELIMITER $$

create procedure send_balance(
	in sender_id int,
    in receiver_id int,
    in sen_balance decimal(10, 2)
)

begin
-- Tạo biến để lưu số dư của người gửi
	declare sender_balance decimal(10, 2) default 0;

-- Lấy ra tiền của người gửi
	select balance into sender_balance
    from accounts 
    where id = sender_id;

-- Mô phỏng tình huống chuyển tiền
-- Bắt đầu transaction
start transaction;

-- Trừ tiền từ người gửi
update accounts
set balance = balance - sen_balance
where id = sender_id;

-- Cộng tiền vào người nhận
update accounts
set balance = balance + sen_balance
where id = receiver_id;

-- Kiểm tra xem tài khoản của người dùng có đủ để chuyển không?
	if sender_balance < sen_balance then
		-- Quay lại trạng thái ban đầu
		rollback;
	else
		-- Xác nhận commit ( lưu dữ liệu và DB )
        commit;
	end if;

-- Xác nhận commit (lưu dữ liệu vào DB)
commit;

end $$

DELIMITER ;

-- Gọi procedure
call send_balance (1, 2, 50000);


-- Bảng quản lý Sản phẩm
CREATE TABLE products (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
stock INT NOT NULL CHECK (stock >= 0),
price DECIMAL(10,2) NOT NULL

) ENGINE=InnoDB;

-- Bảng quản lý Ví tiền user
CREATE TABLE wallets (
user_id INT PRIMARY KEY,
balance DECIMAL(10,2) NOT NULL CHECK (balance >= 0)
) ENGINE=InnoDB;

-- Bảng lưu Đơn hàng
CREATE TABLE orders (
id INT AUTO_INCREMENT PRIMARY KEY,
user_id INT,
product_id INT,
total_amount DECIMAL(10,2),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;














