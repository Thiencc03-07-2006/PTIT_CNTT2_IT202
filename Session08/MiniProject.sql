use btvn;
# create database ecommerce_db;
# use ecommerce_db;

-- 1. Bảng customers (Khách hàng)
create table customers (
    customer_id int primary key auto_increment,
    customer_name varchar(100) not null,
    email varchar(100) not null unique,
    phone varchar(10) not null unique
);

-- 2. Bảng categories (Danh mục sản phẩm)
create table categories (
    category_id int primary key auto_increment,
    category_name varchar(255) not null unique
);

-- 3. Bảng products (Sản phẩm)
create table products (
    product_id int primary key auto_increment,
    product_name varchar(255) not null unique,
    price decimal(10,2) not null check (price > 0),
    category_id int not null,
    constraint fk_product_category foreign key (category_id) references categories(category_id)
);

-- 4. Bảng orders (Đơn hàng)
create table orders (
    order_id int primary key auto_increment,
    customer_id int not null,
    order_date datetime default current_timestamp,
    status enum('Pending', 'Completed', 'Cancel') default 'Pending',
    constraint fk_order_customer foreign key (customer_id) references customers(customer_id)
);

-- 5. Bảng order_items (Chi tiết đơn hàng)
create table order_items (
    order_item_id int primary key auto_increment,
    order_id int not null,
    product_id int not null,
    quantity int not null check (quantity > 0),
    constraint fk_item_order foreign key (order_id) references orders(order_id),
    constraint fk_item_product foreign key (product_id) references products(product_id)
);


insert into categories (category_name)
values
    ('Điện thoại'),
    ('Laptop'),
    ('Tai nghe'),
    ('Chuột & Bàn phím'),
    ('Màn hình'),
    ('Phụ kiện khác');

insert into products (product_name, price, category_id)
values
    ('iPhone', 35000000.00, 1),
    ('Samsung Galaxy', 32000000.00, 1),
    ('MacBook', 55000000.00, 2),
    ('Dell XPS', 38000000.00, 2),
    ('Sony WH', 8500000.00, 3),
    ('AirPods', 6500000.00, 3),
    ('Logitech MX', 2800000.00, 4),
    ('Keychron K8', 2500000.00, 4);

insert into customers (customer_name, email, phone)
values
    ('Phq', 'phq@gmail.com', '0901234561'),
    ('Tttt', 'tttt@yahoo.com', '0912345678'),
    ('Ntc', 'ntc@gmail.com', '0923456789'),
    ('Cct', 'cct@hotmail.com', '0934567890'),
    ('Tat', 'tat@gmail.com', '0945678901'),
    ('Đtb', 'dtb@gmail.com', '0956789012');

insert into orders (customer_id, order_date, status)
values
    (1, '2025-01-10 08:30:00', 'Completed'),
    (2, '2025-01-11 14:20:00', 'Completed'),
    (3, '2025-01-12 09:15:00', 'Pending'),
    (1, '2025-01-13 16:45:00', 'Completed'),
    (4, '2025-01-14 11:00:00', 'Completed'),
    (5, '2025-01-15 13:30:00', 'Cancel'),
    (2, '2025-01-16 10:10:00', 'Completed'),
    (6, '2025-01-17 15:55:00', 'Pending'),
    (1, '2025-01-18 12:40:00', 'Completed'),
    (3, '2025-01-19 09:25:00', 'Completed');

insert into order_items (order_id, product_id, quantity)
values
    (1, 1, 1), (1, 5, 2),
    (2, 2, 1), (2, 3, 1),
    (3, 4, 1),
    (4, 3, 1), (4, 7, 1),
    (5, 6, 3),
    (7, 1, 1), (7, 8, 1),
    (9, 5, 1),
    (10, 2, 1), (10, 4, 2);

# PHẦN A – TRUY VẤN DỮ LIỆU CƠ BẢN
#
# Lấy danh sách tất cả danh mục sản phẩm trong hệ thống.
select * from categories;
# Lấy danh sách đơn hàng có trạng thái là COMPLETED
select * from orders where status='Completed';
# Lấy danh sách sản phẩm và sắp xếp theo giá giảm dần
select * from products order by price desc;
# Lấy 5 sản phẩm có giá cao nhất, bỏ qua 2 sản phẩm đầu tiên
select * from products order by price desc limit 5 offset 2;

# PHẦN B – TRUY VẤN NÂNG CAO
#
# Lấy danh sách sản phẩm kèm tên danh mục
select p.product_id, p.product_name, p.product_id, p.product_name, p.price, c.category_id
from products p
join categories c on p.category_id = c.category_id;
# Lấy danh sách đơn hàng gồm:
# order_id
# order_date
# customer_name
# status
select o.order_id, o.order_date, cu.customer_name, o.status
from orders o
         join customers cu on o.customer_id = cu.customer_id;
# Tính tổng số lượng sản phẩm trong từng đơn hàng
    select o.order_id, sum(o.quantity) `Total_quantity` from order_items o group by o.order_id;

# Thống kê số đơn hàng của mỗi khách hàng
select c.customer_id, c.customer_name, count(o.order_id) `So_don_hang` from customers c
left join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;
# Lấy danh sách khách hàng có tổng số đơn hàng ≥ 2
select c.customer_id, c.customer_name, count(o.order_id) from customers c
left join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having count(o.order_id) >= 2;
# Thống kê giá trung bình, thấp nhất và cao nhất của sản phẩm theo danh mục
select c.category_id, c.category_name, avg(p.price) `Gia_Tb`, min(p.price) `Gia_thap_nhat`, max(p.price) `Gia_cao_nhat` from products p
join categories c on c.category_id = p.category_id
group by c.category_id, c.category_name;

# PHẦN C – TRUY VẤN LỒNG (SUBQUERY)
#
# Lấy danh sách sản phẩm có giá cao hơn giá trung bình của tất cả sản phẩm
select product_id, product_name, price
from products
where price > (
select avg(price) from products
                  );
# Lấy danh sách khách hàng đã từng đặt ít nhất một đơn hàng
select customer_id, customer_name, email, phone
from customers
where customer_id in (select distinct customer_id from orders);
# Lấy đơn hàng có tổng số lượng sản phẩm lớn nhất.
select o.order_id, o.order_date, o.status
from orders o
         join order_items oi on o.order_id = oi.order_id
group by o.order_id
having sum(oi.quantity) = (
    select max(tong_sl)
    from (
             select sum(quantity) as tong_sl
             from order_items
             group by order_id
         ) as temp
);
# Lấy tên khách hàng đã mua sản phẩm thuộc danh mục có giá trung bình cao nhất
select distinct cu.customer_name
from customers cu
where cu.customer_id in (
    select o.customer_id
    from orders o
             join order_items oi on o.order_id = oi.order_id
    where oi.product_id in (
        select p.product_id
        from products p
        where p.category_id = (
            select category_id
            from (
                     select category_id, avg(price) as avg_price
                     from products
                     group by category_id
                     order by avg_price desc
                     limit 1
                 ) as top_cat
        )
    )
);
# Từ bảng tạm (subquery), thống kê tổng số lượng sản phẩm đã mua của từng khách hàng
select cu.customer_name, temp.tong_sl_mua
from customers cu
         join (
    select o.customer_id, sum(oi.quantity) as tong_sl_mua
    from orders o
             join order_items oi on o.order_id = oi.order_id
    group by o.customer_id
) as temp on cu.customer_id = temp.customer_id;
# Viết lại truy vấn lấy sản phẩm có giá cao nhất, đảm bảo:
# Subquery chỉ trả về một giá trị
# Không gây lỗi “Subquery returns more than 1 row”
select product_id, product_name, price
from products
where price = (select max(price) from products);