---
layout: post
title: "[Ruby on Rails] Sử dụng Migration với PostgreSQL trong Rails"
description: Rào cản lớn nhất khi đến với stack công nghệ Ruby - Rails - PostgreSQL (hay bất kỳ SQL Database nào) là Migration. Hiểu và dùng thành thạo Migration sẽ khiến cho mọi thứ dễ dàng hơn rất nhiều.
date: 2016-07-02 10:15:00 +0700
categories: ['ruby-on-rails']
tags: [ruby, rails, postgre, sql, migration, 'active record']
comments: true
---

# 1. Active Record #

Để đảm bảo chúng ta có cùng 1 cách hiểu về **Migration** trong **Ruby on Rails**, mời các bạn xem qua 1 vài tài liệu về **[Active Record][active-record]** từ trang hướng dẫn chính thức của **Ruby on Rails**.

Để hiểu 1 cách đơn giản, **Active Record** là 1 khái niệm được dùng trong các công nghệ làm web back-end hiện đại theo mô hình **[Model - View - Controller][mvc]**, trong đó **Model** là các luồng làm việc với dữ liệu, **View** là các xử lý liên quan đến giao diện, tương tác đối với người dùng cuối (end-user) hoặc front-end (web app, mobile app), còn **Controller** là tất cả những logic cầu nối giữa **Model** và **View**.

Khi mới ra đời, việc sử dụng các **raw query** (các câu lệnh query trực tiếp dữ liệu từ database) ngay trong các Controller là khá phổ biến, nhưng bộc lộ rất nhiều nhược điểm như:

* Không tường minh: các câu lệnh dài dằng dặc, nối vài bảng với nhau gây rối rắm và không rõ ràng về chức năng
* Khó bảo trì: vì lý do ở trên nên thường việc debug một đoạn code viết bằng **raw query** rất đau đầu và mất nhiều thời gian, đôi khi còn không hiệu quả bằng đoạn code viết ban đầu (?!)
* Không an toàn: [SQL injection][sql-injection] là 1 thủ thuật (thủ đoạn ?!) được các hacker đời đầu ưa chuộng, vì nó đơn giản, đánh vào các câu query được viết ẩu & các server không được đầu tư kỹ về bảo mật

Do vậy, cần có 1 tầng logic nằm giữa các nhu cầu xử lý dữ liệu của lập trình viên và các lệnh cấp thấp tương tác trực tiếp với **database engine** (như **MySQL** hoặc **PostgreSQL**). **Active Record** là 1 kỹ thuật nhằm giải quyết vấn đề này.

Trong **Ruby on Rails**, **Active Record** được thiết kế rất gần với cấu trúc và đặc tính của các SQL database, vậy nên đối với các bạn đã thành thạo 1 SQL database từ trước là 1 lợi thế. Ngược lại, những ai đã từng làm việc với **NoSQL** như **MongoDB** trong **Ruby on Rails** (thông qua 1 [ORM][orm] tên là [Mongoid][mongoid]), cũng không khó khăn lắm để làm quen với các khái niệm trong **Active Record** (vì **Mongoid** được làm ra dựa trên Active Record nhưng chỉ dành cho NoSQL).

Tuy nhiên có 1 thứ mà bất kỳ ai cũng phải vượt qua, đó là **Migration**. Về cơ bản, các SQL database đều quy định khá chặt chẽ về cấu trúc các bảng dữ liệu, được gọi là **schema**. Mỗi khi chúng ta định nghĩa 1 bảng dữ liệu, 1 **schema** được sinh ra để lưu lại cấu trúc của bảng đó. Tuy nhiên trong quá trình phát triển dự án, **schema** cần luôn luôn thay đổi 1 cách linh hoạt. Nếu chỉ tiến hành thay đổi tại **Active Record**, các **database engine** sẽ báo lỗi do sự sai khác về định nghĩa. Lúc này có 2 cách để tiếp tục làm việc:

* Drop database: tức là xóa toàn bộ dữ liệu của bảng đó đi, khi đó **database engine** sẽ ghi dữ liệu theo schema mới
* Viết các **Migration**: toàn bộ dữ liệu vẫn được dữ nguyên, nhưng **database engine** biết được cột (column) nào sẽ được thay đổi và cần thay đổi như thế nào.

Cách thứ nhất rất nhanh và dễ, nhưng là 1 thói quen xấu, đặc biệt khi dự án đã ra mắt người dùng cuối, chạy và ghi nhận dữ liệu thật, thì không có cách nào xóa trắng dữ liệu được cả. Vậy nên chúng ta cần đến cách thứ 2, đó là viết **Migration**.

# 2. Bài toán cụ thể #

**Migration** là cách để chúng ta định nghĩa 1 **schema** cần thay đổi ở đâu và như thế nào.

Ví dụ, ta có 1 ứng dụng tên là **SecretMessenger**. Ứng dụng này cần có 3 models:

* `User`: các dữ liệu liên quan đến người dùng đăng nhập vào hệ thống
* `Conversation`: các *cuộc hội thoại* tạo ra giữa 2 người dùng với nhau
* `Message`: các *tin nhắn* mà 2 người dùng trao đổi trong 1 cuộc hội thoại

Đây là 1 thiết kế khá giống với hầu hết các ứng dụng nhắn tin hiện nay như [Messenger của Facebook][facebook-messenger], [Viber][viber] hay [Telegram][telegram]. Giả sử thiết kế ban đầu của chúng ta có dạng như thế này:

![SecretMessenger - Database schema - v1.0][db-schema-1.0]

Đây là thiết kế cơ bản nhất, cho phép ứng dụng **SecretMessenger** của chúng ta có thể:

* Lưu trữ thông tin người dùng trong bảng `User`
* Lưu trữ các *cuộc hội thoại* trong bảng `Conversation`, trong đó biết được ai là người gửi (thông qua trường `from_user_id`), ai là người nhận (`to_user_id`)
* Lưu trữ các *tin nhắn* trong bảng `Message`, trong đó cũng biết được ai là người gửi (thông qua trường `from_user_id`), ai là người nhận (`to_user_id`), tin nhắn nào nằm trong cuộc hội thoại nào (`conversation_id`)
* Tất cả các Model đều có các trường `created_at` và `updated_at` gọi là các **timestamps** lưu trữ các thông tin ngày giờ được khởi tạo và ghi vào bảng (**created**) và ngày giờ cập nhật giá trị mới (**updated**)

# 3. Các thao tác với Migration trong Ruby on Rails #

## 3.1. Thêm mới 1 Model ##

## 3.2. Thêm mới 1 trường trong Model  ##

## 3.3. Sửa 1 trường trong Model ##

### 3.3.1. Đổi tên ###

### 3.3.2. Đổi kiểu dữ liệu ###

### 3.3.3. Đặt giá trị mặc định ###

### 3.3.4. Đặt giá trị khác `null` ###

## 3.4. Đánh index cho các trường trong Model ##

[active-record]:    http://guides.rubyonrails.org/active_record_basics.html
{:rel="nofollow"}

[mvc]:              https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller
{:rel="nofollow"}

[sql-injection]:    https://en.wikipedia.org/wiki/SQL_injection
{:rel="nofollow"}

[orm]:              https://en.wikipedia.org/wiki/Object-relational_mapping
{:rel="nofollow"}

[mongoid]:          https://docs.mongodb.com/ecosystem/tutorial/ruby-mongoid-tutorial/#ruby-mongoid-tutorial
{:rel="nofollow"}

[facebook-messenger]: https://www.messenger.com/
{:rel="nofollow"}

[viber]:            https://www.viber.com/
{:rel="nofollow"}

[telegram]:         https://telegram.org/
{:rel="nofollow"}

[db-schema-1.0]:    /assets/media/posts/ruby-on-rails/2016-07-02-secret-messenger-db-schema-1.0.png
{:class="img-responsive"}