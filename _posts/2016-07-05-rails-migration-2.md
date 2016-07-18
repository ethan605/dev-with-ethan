---
layout: post
title: "[Ruby on Rails] Migration trong Rails: Các thao tác với Migration"
description: "Các thao tác chính với Migration: thêm mới, đổi tên, đổi kiểu dữ liệu, đặt giá trị mặc định, xóa trường & đánh index cho các trường trong Model"
date: 2016-07-05 10:15:00 +0700
categories: ['ruby-on-rails']
tags: [ruby, rails, postgre, sql, migration, 'active record']
comments: true
---

*... tiếp theo bài viết [[Ruby on Rails] Migration trong Rails: Tạo mới Models với Active Record]({% post_url 2016-07-04-rails-migration-1 %})*

# 3. Các thao tác với Migration trong Ruby on Rails #

## 3.2. Thêm mới 1 trường trong Model  ##

Một tính năng quan trọng của 1 ứng dụng nhắn tin đó là theo dõi và thông báo trạng thái gửi đi của 1 tin nhắn. Các trường thông tin cơ bản của Model `Message` có thể bao gồm:

* `is_sent`: một tin nhắn sẽ được đánh dấu là **sent** khi nó được *gửi đi* (back-end nhận được tin nhắn từ front-end gửi lên & lưu trữ thành công)
* `is_delivered`: tin nhắn sau khi **sent** sẽ trở thành **delivered** khi nó đến được với người nhận, nhưng chưa được mở ra đọc (front-end của người nhận lấy được danh sách các tin nhắn mới nhận, nhưng chưa click vào để mở ra xem)
* `is_read`: tin nhắn sau khi **delivered** sẽ trở thành **read** khi người nhận mở nó ra (front-end gửi request khi người nhận mở tin nhắn)
* `is_archived`: tin nhắn được đánh dấu **archived** khi người gửi muốn xóa tin nhắn mình đã gửi đi (1 cách khác là xóa hẳn tin nhắn khỏi database, nhưng việc đánh dấu là **archived** an toàn hơn nhiều về mặt thông tin, đặc biệt là sua này khi ứng dụng của các bạn có chức năng **undo**)

Lúc này, **command line tools** của **Rails** cung cấp cho chúng ta 1 lệnh tự động có cú pháp như sau:

```shell
$ rails generate migration AddDeliveryFieldsToMessage is_sent:boolean is_delivered:boolean is_read:boolean is_archived:boolean
      invoke  active_record
      create    db/migrate/20160705090219_add_delivery_fields_to_message.rb
```

và nhận được kết quả là file `db/migrate/20160705090219_add_delivery_fields_to_message.rb` như sau:

```ruby
class AddDeliveryFieldsToMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :is_sent, :boolean
    add_column :messages, :is_delivered, :boolean
    add_column :messages, :is_read, :boolean
    add_column :messages, :is_archived, :boolean
  end
end
```

**Rails generator** tự động nhận diện lệnh **Migration** có cấu trúc `AddXXXToYYY` là chúng ta đang thêm các trường vào 1 Model có tên là `YYY`, vậy nên nó sẽ sinh ra các dòng `add_column :messages` như ở trên.

Tuy nhiên, chúng ta có 1 cách khác gọn gàng và tùy biến cao hơn:

```ruby
class AddDeliveryToMessage < ActiveRecord::Migration[5.0]
  def change
    change_table :messages do |t|
      t.boolean :is_sent, null: false, default: true
      t.boolean :is_delivered, null: false, default: false
      t.boolean :is_read, :boolean, null: false, default: false
      t.boolean :is_archived, :boolean, null: false, default: false
    end
  end
end
```

Ở đây, chúng ta dùng block `change_table` để tiến hành sửa nhiều trường trong cùng bảng `messages`, thay vì lệnh nào cũng phải khai báo bảng này. Ngoài ra, chúng ta còn có thể thêm các tùy chọn như `null: false` hay `default: true` để khai báo các trường này không được phép nhận giá trị `null`, và giá trị mặc định sẽ là `true` hoặc `false` tùy theo từng trường.

## 3.3. Sửa 1 trường trong Model ##

### 3.3.1. Đổi tên ###

Việc đổi tên trường giống như thêm mới trường, ta có thể thực hiện bằng 2 cách:

Sử dụng lệnh `rename_column`:

```ruby
class ChangeMessageIsReadField < ActiveRecord::Migration[5.0]
  def change
    rename_column :messages, :is_read, :is_seen
  end
end
```

hoặc sử dụng block `change_table`:

```ruby
class ChangeMessageIsReadField < ActiveRecord::Migration[5.0]
  def change
    change_table :messages do |t|
      t.rename :is_read, :is_seen
    end
  end
end
```

### 3.3.2. Đổi kiểu dữ liệu ###

Việc đổi kiểu dữ liệu của 1 trường được tiến hành qua hàm `change_column` hoặc `t.change` trong block `change_table`. Bản chất việc này là thay đổi toàn bộ định nghĩa của trường dữ liệu, vậy nên bạn cần định nghĩa rõ ràng toàn bộ các thông tin mà bạn muốn, kể cả khi bạn không có nhu cầu thay đổi. Ví dụ: chúng ta đã có trường `is_seen` có kiểu `boolean`, không nhận giá trị `null` và giá trị mặc định là `false`. Khi đó nếu ta muốn đổi nó thành kiểu `int`, ta phải khai báo lại toàn bộ các thuộc tính này:

Với lệnh `change_column`:

```ruby
class ChangeMessageIsSeenField < ActiveRecord::Migration[5.0]
  def change
    change_column :messages, :is_seen, :integer, null: false, default: 0
  end
end
```

Với block `change_table`:

```ruby
class ChangeMessageIsSeenField < ActiveRecord::Migration[5.0]
  def change
    change_table :messages do |t|
      t.change :is_seen, :integer, null: false, default: 0
    end
  end
end
```

### 3.3.3. Đặt giá trị mặc định ###

**Active Record** quy định, tất cả các trường đều có giá trị mặc định là `null` nếu không được đặt 1 giá trị mặc định (default value), kể cả khi trường đó có kiểu `integer` hay `boolean`. Việc đặt giá trị mặc định khi khai báo tạo mới 1 trường ta đã làm ở mục **3.2**, tuy nhiên đối với các trường đã có sẵn, nếu muốn sử dụng block `change_table`, ta phải dùng `t.change` vì block này không hỗ trợ thay đổi giá trị mặc định của 1 trường. Cách đơn giản hơn là ta dùng lệnh `change_column_default`:

```ruby
class ChangeMessageIsSentDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :messages, :is_sent, false
  end
end
```

### 3.3.4. Đặt giá trị khác `null` ###

Để đảm bảo 1 trường không bao giờ được nhận giá trị `null`, ta phải khai báo trường đó là `NOT NULL`. Cũng giống như việc đặt giá trị mặc định, cách đơn giản là ta dùng lệnh `chagne_column_null`:

```ruby
class ChangeMessageIsSentNull < ActiveRecord::Migration[5.0]
  def change
    change_column_null :messages, :is_sent, true
  end
end
```

***Lưu ý:*** lệnh này nhận 1 tham số `true` hoặc `false` thể hiện rằng trường này có thể nhận giá trị `null` hay không, tương đương với query trong PostgreSQL là `SET NOT NULL` nếu `false` hoặc không gì cả nếu `true`.

## 3.4. Xóa 1 trường trong Model ##

Việc xóa 1 trường trong Model được thực hiện qua lệnh `remove_column`. Tuy nhiên, do cơ chế **Rollback** của **Migration**, chúng ta cần khai báo kiểu của trường đó để khi rollback, **Migration** biết phải tạo lại trường cũ có kiểu dữ liệu là gì. Tốt nhất là khai báo đầy đủ toàn bộ những thuộc tính mà ta muốn, ví dụ:

Với lệnh `remove_column`

```ruby
class RemoveIsSeenFromMessage < ActiveRecord::Migration[5.0]
  def change
    remove_column :messages, :is_seen, :integer, null: false, default: false
  end
end
```

Với block `change_table`

```ruby
class RemoveIsSeenFromMessage < ActiveRecord::Migration[5.0]
  def change
    change_table :messages do |t|
      t.remove :is_seen, :integer, null: false, default: false
    end
  end
end
```

Cũng giống như tạo mới trường dữ liệu, **command line tools** cũng nhận ra cấu trúc `RemoveXXXFromYYY` khi ta gọi lệnh `rails generate migration`:

```shell
$ rails generate migration RemoveIsSeenFromMessage is_seen:integer
```

## 3.5. Đánh index cho các trường trong Model ##

**Indexing** là 1 đặc tính rất hay của các database, nó cho phép chúng ta **lưu trữ** 1 phần dữ liệu trong các bảng dưới dạng đặc biệt gọi là các **indexes**, để từ đó giúp tăng tốc độ truy suất, đặc biệt là đối với các trường cần được query nhiều và liên tục.

Để tạo 1 index với Active Record với lệnh `add_index`:

```ruby
class IndexingMessageFields < ActiveRecord::Migration[5.0]
  def change
    add_index :messages, :is_sent, :is_delivered, :is_seen
  end
end
```

Với block `change_table`:

```ruby
class IndexingMessageFields < ActiveRecord::Migration[5.0]
  def change
    change_table :messages do |t|
      t.index :is_sent, :is_delivered, :is_seen
    end
  end
end
```

***Lưu ý:*** lệnh này chấp nhận nhiều tham số, thể hiện rằng ta muốn đánh index nhiều trường khác nhau cùng 1 lúc.

Cuối cùng, sử dụng **Migration** một cách nhuần nhuyễn, chúng ta có thể tạo ra được 1 database schema phức tạp hơn mà vẫn bảo toàn nguyên vẹn các dữ liệu được tạo ra trong quá trình làm việc:

![SecretMessenger - Database schema - v1.1][db-schema-1.1]

**Ruby on Rails** cung cấp rất nhiều tính năng **Migration** khác nhau, các bạn nên tham khảo kỹ 2 trang sau đây để biết tất cả những tính năng được hỗ trợ:

* [Trang hướng dẫn chính thức của Ruby on Rails][active-record-migrations]
* [Trang document API dock của hàm `change_table`][change_table-api-dock]

Nhìn chung, đối với những người mới bước chân vào thế giới của **Ruby on Rails**, đặc biệt là với những bạn không quen với lập trình web back-end, việc viết các **Migration** khá khó và không quen. Tuy nhiên, lời khuyên chân thành của tôi là hãy thực hành viết và sử dụng tính năng này càng nhiều càng tốt, vì nó sẽ giúp các bạn tạo được 1 thói quen cực hiệu quả trong lập trình nói chung, cũng như trong quá trình phát triển ứng dụng của mình nói riêng.

[active-record-migrations]:   http://edgeguides.rubyonrails.org/active_record_migrations.html
{:rel="nofollow"}

[change_table-api-dock]:      http://apidock.com/rails/ActiveRecord/ConnectionAdapters/SchemaStatements/change_table
{:rel="nofollow"}

[db-schema-1.1]:    /assets/media/posts/ruby-on-rails/2016-07-05-secret-messenger-db-schema-1.1.png
{:class="img-responsive"}