---
layout: article
title: "[Ruby on Rails] Migration trong Rails: Tạo mới Models với Active Record"
description: Rào cản lớn nhất khi đến với stack công nghệ Ruby - Rails - PostgreSQL (hay bất kỳ SQL Database nào) là Migration. Hiểu và dùng thành thạo Migration sẽ khiến cho mọi thứ dễ dàng hơn rất nhiều.
date: 2016-07-04 10:15:00 +0700
categories: ['ruby-on-rails']
tags: [ruby, rails, postgre, sql, migration, 'active record']
comments: true
instant_title: Tạo mới Models với Active Record
instant_kicker: Ruby on Rails
preview_image: /assets/media/featured-images/2016-07-04-preview.png
featured_image: /assets/media/featured-images/2016-07-04-header.png
---

## 1. Active Record ##

Để đảm bảo chúng ta có cùng 1 cách hiểu về **Migration** trong **Ruby on Rails**, mời các bạn xem qua 1 vài tài liệu về **[Active Record][active-record]** từ trang hướng dẫn chính thức của **Ruby on Rails**.

Để hiểu 1 cách đơn giản, **Active Record** là 1 khái niệm được dùng trong các công nghệ làm web back-end hiện đại theo mô hình **Model - View - Controller** (viết tắt là **MVC**), trong đó **Model** là các luồng làm việc với dữ liệu, **View** là các xử lý liên quan đến giao diện, tương tác đối với người dùng cuối (end-user) hoặc front-end (web app, mobile app), còn **Controller** là tất cả những logic cầu nối giữa **Model** và **View**.

Khi mới ra đời, việc sử dụng các **raw query** (các câu lệnh query trực tiếp dữ liệu từ database) ngay trong các Controller là khá phổ biến, nhưng bộc lộ rất nhiều nhược điểm như:

* Không tường minh: các câu lệnh dài dằng dặc, nối vài bảng với nhau gây rối rắm và không rõ ràng về chức năng
* Khó bảo trì: vì lý do ở trên nên thường việc debug một đoạn code viết bằng **raw query** rất đau đầu và mất nhiều thời gian, đôi khi còn không hiệu quả bằng đoạn code viết ban đầu (?!)
* Không an toàn: **SQL injection** là 1 thủ thuật (thủ đoạn ?!) được các hacker đời đầu ưa chuộng, vì nó đơn giản, đánh vào các câu query được viết ẩu & các server không được đầu tư kỹ về bảo mật

Do vậy, cần có 1 tầng logic nằm giữa các nhu cầu xử lý dữ liệu của lập trình viên và các lệnh cấp thấp tương tác trực tiếp với **database engine** (như **MySQL** hoặc **PostgreSQL**). **Active Record** là 1 kỹ thuật nhằm giải quyết vấn đề này.

Trong **Ruby on Rails**, **Active Record** được thiết kế rất gần với cấu trúc và đặc tính của các SQL database, vậy nên đối với các bạn đã thành thạo 1 SQL database từ trước là 1 lợi thế. Ngược lại, những ai đã từng làm việc với **NoSQL** như **MongoDB** trong **Ruby on Rails** (thông qua 1 **Object-Relational Mapping** - **ORM** tên là **Mongoid**), cũng không khó khăn lắm để làm quen với các khái niệm trong **Active Record** (vì **Mongoid** được làm ra dựa trên Active Record nhưng chỉ dành cho NoSQL).

Tuy nhiên có 1 thứ mà bất kỳ ai cũng phải vượt qua, đó là **Migration**. Về cơ bản, các SQL database đều quy định khá chặt chẽ về cấu trúc các bảng dữ liệu, được gọi là **schema**. Mỗi khi chúng ta định nghĩa 1 bảng dữ liệu, 1 **schema** được sinh ra để lưu lại cấu trúc của bảng đó. Tuy nhiên trong quá trình phát triển dự án, **schema** cần luôn luôn thay đổi 1 cách linh hoạt. Nếu chỉ tiến hành thay đổi tại **Active Record**, các **database engine** sẽ báo lỗi do sự sai khác về định nghĩa. Lúc này có 2 cách để tiếp tục làm việc:

* Drop database: tức là xóa toàn bộ dữ liệu của bảng đó đi, khi đó **database engine** sẽ ghi dữ liệu theo schema mới
* Viết các **Migration**: toàn bộ dữ liệu vẫn được dữ nguyên, nhưng **database engine** biết được cột (column) nào sẽ được thay đổi và cần thay đổi như thế nào.

Cách thứ nhất rất nhanh và dễ, nhưng là 1 thói quen xấu, đặc biệt khi dự án đã ra mắt người dùng cuối, chạy và ghi nhận dữ liệu thật, thì không có cách nào xóa trắng dữ liệu được cả. Vậy nên chúng ta cần đến cách thứ 2, đó là viết **Migration**.

## 2. Bài toán cụ thể ##

**Migration** là cách để chúng ta định nghĩa 1 **schema** cần thay đổi ở đâu và như thế nào.

Ví dụ, ta có 1 ứng dụng tên là **SecretMessenger**. Ứng dụng này cần có 3 models:

* `User`: các dữ liệu liên quan đến người dùng đăng nhập vào hệ thống
* `Conversation`: các *cuộc hội thoại* tạo ra giữa 2 người dùng với nhau
* `Message`: các *tin nhắn* mà 2 người dùng trao đổi trong 1 cuộc hội thoại

Đây là 1 thiết kế khá giống với hầu hết các ứng dụng nhắn tin hiện nay như **Messenger** của Facebook, **Viber** hay **Telegram**. Giả sử thiết kế ban đầu của chúng ta có dạng như thế này:

{% include figure.html
   filename="/assets/media/posts/ruby-on-rails/2016-07-04-secret-messenger-db-schema-1.0.png"
   alt="SecretMessenger - Database schema - v1.0"
   caption="Database schema v1.0" %}

Đây là thiết kế cơ bản nhất, cho phép ứng dụng **SecretMessenger** của chúng ta có thể:

* Lưu trữ thông tin người dùng trong bảng `User`
* Lưu trữ các *cuộc hội thoại* trong bảng `Conversation`, trong đó biết được ai là người gửi (thông qua trường `from_user_id`), ai là người nhận (`to_user_id`)
* Lưu trữ các *tin nhắn* trong bảng `Message`, trong đó cũng biết được ai là người gửi (thông qua trường `from_user_id`), ai là người nhận (`to_user_id`), tin nhắn nào nằm trong cuộc hội thoại nào (`conversation_id`)
* Tất cả các Model đều có các trường `created_at` và `updated_at` gọi là các **timestamps** lưu trữ các thông tin ngày giờ được khởi tạo và ghi vào bảng (**created**) và ngày giờ cập nhật giá trị mới (**updated**)

Chúng ta sẽ đi vào chi tiết từng bước các cách **Migration** trong **Ruby on Rails**.

## 3. Các thao tác với Migration trong Ruby on Rails ##

### 3.1. Thêm mới 1 Model ###

Ban đầu, khi chưa có gì cả, ta cần thêm mới Model. **Rails** cung cấp cho chúng ta 1 bộ công cụ dòng lệnh (*command line tools*) tên là `rails generate` với các lệnh con (gọi là `generators`) như sau:

```shell
$ rails generate
Usage: rails generate GENERATOR [args] [options]

General options:
  -h, [--help]     # Print generator's options and usage
  -p, [--pretend]  # Run but do not make any changes
  -f, [--force]    # Overwrite files that already exist
  -s, [--skip]     # Skip files that already exist
  -q, [--quiet]    # Suppress status output

Please choose a generator below.

Rails:
  channel
  controller
  generator
  integration_test
  job
  mailer
  migration
  model
  resource
  responders_controller
  scaffold
  scaffold_controller
  serializer
  task

ActiveRecord:
  active_record:devise
  active_record:migration
  active_record:model

Devise:
  devise
  devise:controllers
  devise:install
  devise:views

Mongoid:
  mongoid:devise

Responders:
  responders:install

TestUnit:
  test_unit:controller
  test_unit:generator
  test_unit:helper
  test_unit:integration
  test_unit:job
  test_unit:mailer
  test_unit:model
  test_unit:plugin
  test_unit:scaffold
```
{% include figure.html
   filename="/assets/media/snippets/images/2016-07-04/shell-1.png"
   alt="Shell snippet 1"
   caption="Rails generators"
   instant_articles="true" %}

Đây là bộ công cụ cực kỳ hữu dụng vì nó làm giúp chúng ta hầu hết các phần đơn giản như: tạo các file với tên theo chuẩn, có sẵn các đoạn mã cơ bản để khởi tạo. Lệnh này cũng có cách viết tắt là `rails g` thay cho viết đầy đủ là `rails generate`

Đúng ra để tạo mới 1 Model, ta sẽ dùng lệnh `rails generate model`:

```shell
$ rails generate model conversation title:string from_user:references to_user:references
      invoke  active_record
      create    db/migrate/20160704073539_create_conversations.rb
      create    app/models/conversation.rb
```
{% include figure.html
   filename="/assets/media/snippets/images/2016-07-04/shell-2.png"
   alt="Shell snippet 2"
   caption="Generate model"
   instant_articles="true" %}

Tuy nhiên lệnh này chỉ tạo ra Model, chúng ta sẽ cần đến nhiều thành phần hơn:

* `Controller` để xử lý các request liên quan đến các `Conversation`
* `Serializer` để tự động hóa việc trả kết quả bằng `JSON`
* `Routes` để cấu hình các URI (gọi là **Routing**) liên quan đến các `Conversation`
* `Test` để viết các kiểm thử
* ...

Do đó ta sẽ dùng `scaffold` để tạo tất cả bằng 1 lệnh duy nhất:

```shell
$ rails generate scaffold conversation title:string from_user:references to_user:references
      invoke  active_record
      create    db/migrate/20160704073626_create_conversations.rb
      create    app/models/conversation.rb
      invoke  resource_route
       route    resources :conversations
      invoke  serializer
      create    app/serializers/conversation_serializer.rb
      invoke  scaffold_controller
      create    app/controllers/conversations_controller.rb
```
{% include figure.html
   filename="/assets/media/snippets/images/2016-07-04/shell-3.png"
   alt="Shell snippet 3"
   caption="Generate model với scaffold"
   instant_articles="true" %}

Mặc định, `rails generate` sẽ tạo ra rất nhiều các file phục vụ các tính năng khác nhau, ta có thể cấu hình bật/tắt các tính năng này bằng cách thêm lệnh `config.generators` trong file `configs/application.rb`:

```ruby
module SecretMessengerApi
  class Application < Rails::Application
    # ...

    config.generators do |g|
      g.orm             :active_record
      g.template_engine nil
      g.test_framework  nil
      g.stylesheets     false
      g.javascripts     false
    end

    # ...
  end
end
```
{% include figure.html
   filename="/assets/media/snippets/images/2016-07-04/ruby-1.png"
   alt="Ruby code snippet 1"
   caption="Cấu hình generators"
   instant_articles="true" %}

(trong trường hợp này, chúng ta sẽ không sinh ra bất kỳ file nào phục vụ cho web front-end như `template_engine`, `stylesheets`, `javascripts`,...)

Sau khi tạo `scaffold`, chúng ta có 1 file mới tên là `db/migrate/20160704073626_create_conversations.rb` có nội dung:

```ruby
class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.string :title
      t.references :from_user, foreign_key: true
      t.references :to_user, foreign_key: true

      t.timestamps
    end
  end
end
```
{% include figure.html
   filename="/assets/media/snippets/images/2016-07-04/ruby-2.png"
   alt="Ruby code snippet 2"
   caption="File migration tự động sinh"
   instant_articles="true" %}

Ở đây chúng ta có 1 class tên là `CreateConversations`, kế thừa từ `ActiveRecord::Migration[5.0]`. Class này có 1 hàm tên `change`, với nội dung là tạo mới (`create_table`) một bảng tên là `conversations`, trong bảng `conversations`:

* Tạo 1 trường kiểu `string` tên là `title`
* Tạo 1 trường liên kết ngoài bảng (`foreign_key`) tên là `from_user`
* Tạo 1 trường liên kết ngoài bảng (`foreign_key`) tên là `to_user`
* Tạo các trường thời gian `created_at` và `updated_at` (thông qua `timestamps`)

Tuy nhiên, việc dùng `references` như ở trên không đúng ý đồ của chúng ta lắm, vì nó không thể hiện được rõ ràng mối quan hệ `n-1` giữa `Conversation` và `User`. Ta sẽ sửa lại file **Migration** này 1 chút như sau:

```ruby
class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.string :title
      t.belongs_to :from_user
      t.belongs_to :to_user

      t.timestamps
    end
  end
end
```
{% include figure.html
   filename="/assets/media/snippets/images/2016-07-04/ruby-3.png"
   alt="Ruby code snippet 3"
   caption="Thêm quan hệ belongs_to"
   instant_articles="true" %}

Ngoài ra, trong file `app/models/conversation.rb`, chúng ta cũng có nội dung như sau:

```ruby
class Conversation < ApplicationRecord
  belongs_to :from_user
  belongs_to :to_user
end
```
{% include figure.html
   filename="/assets/media/snippets/images/2016-07-04/ruby-6.png"
   alt="Ruby code snippet 6"
   caption="Quan hệ mặc định trong model"
   instant_articles="true" %}

Lúc này, **Active Record** sẽ hiểu rằng, `Conversation` có quan hệ `n-1` với 2 Model `FromUser` và `ToUser`. Trong khi chúng ta chỉ có 1 Model là `User` mà thôi. Để **Active Record** hiểu đúng, ta cần sửa lại như sau:

```ruby
class Conversation < ApplicationRecord
  belongs_to :from_user, class_name: "User"
  belongs_to :to_user, class_name: "User"
end
```
{% include figure.html
   filename="/assets/media/snippets/images/2016-07-04/ruby-4.png"
   alt="Ruby code snippet 4"
   caption="Thêm quan hệ trong model"
   instant_articles="true" %}

Cuối cùng, ta chạy lệnh `migrate` để thực hiện các thay đổi:

```shell
$ rails db:migrate
```
{% include figure.html
   filename="/assets/media/snippets/images/2016-07-04/shell-4.png"
   alt="Shell snippet 4"
   caption="Chạy lệnh migrate"
   instant_articles="true" %}

Trong bài viết [sau][part-2], ta sẽ làm việc sâu hơn với **Migration** trong **Rails** với các thao tác thêm mới, đổi tên, đổi kiểu dữ liệu, đặt giá trị mặc định, xóa trường & đánh index cho các trường trong Model.

[part-2]:           {{ site.url }}{% post_url 2016-07-05-rails-migration-2 %}
[active-record]:    http://guides.rubyonrails.org/active_record_basics.html
{:rel="nofollow"}

[orm]:              https://en.wikipedia.org/wiki/Object-relational_mapping
{:rel="nofollow"}

[command-line-tools]: http://guides.rubyonrails.org/command_line.html
{:rel="nofollow"}
