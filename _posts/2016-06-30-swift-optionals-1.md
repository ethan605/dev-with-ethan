---
layout: article
title: "[Swift] Kiểu giá trị Optional: Các cách khai báo & sử dụng"
description: Tìm hiểu tính năng Optional với ký pháp '?' (question mark) và '!' (exclamation mark) trong Swift
date: 2016-06-30 10:00:00 +0700
categories: [swift]
tags: [swift, optional, type, 'ký pháp ?', 'question mark', 'ký pháp !', 'exclamation mark']
comments: true
---

## 1. Kiểu Optional trong Swift ##

Giống với các ngôn ngữ khác (**C**/**C++**, **Java**, **Objective-C**,...), **Swift** cũng có 1 giá trị đặc biệt là `nil` (tương đương với `null`, `NULL`, `NIL`), mang ý nghĩa là **không có giá trị gì cả**. `nil` khác với `0`, `0.0`, `""`, `[]`, `[:]` ở 2 điểm:

* `nil` có nghĩa là không có giá trị, còn lại là các giá trị xác định
* `nil` không chiếm dụng bộ nhớ, các giá trị còn lại sử dụng bộ nhớ như 1 giá trị bình thường

Tuy nhiên, khác với các ngôn ngữ khác, **Swift** rất *nhạy cảm* đối với các giá trị `nil`, vì nó có thể gây ra các lỗi về xử lý, ví dụ như thực hiện các phép toán giữa các biến có giá trị `nil` với nhau có thể gây lỗi. Do đó, kiểu **Optional** ra đời.

Về bản chất, **Optional** vẫn là 1 kiểu dữ liệu bình thường, nhưng nó gắn liền với các kiểu dữ liệu có sẵn và kèm theo ký pháp `?` (tiếng Anh: *question mark*), ví dụ:

```swift
var originalInt: Int = nil          // Nil cannot initialize specified type 'Int'
var optionalInt: Int? = nil

originalInt = 14
optionalInt = 15
```

Lúc này, biến `originalInt` có kiểu thuần `Int`, và việc gán nó bằng `nil` gây lỗi `Nil cannot initialize specified type 'Int'`, trong khi biến `optionalInt` có kiểu *optional* `Int?`, không có lỗi gì xảy ra nếu được gán bằng `nil`. Ngoài điểm này ra, 2 biến này hoàn toàn bình đẳng trong các phép gán giá trị `Int` bình thường.

## 2. Wrap và Unwrap 1 giá trị kiểu Optional ##

Tuy nhiên, do **Optional** là 1 kiểu đặc biệt, vậy nên nó cũng được xử lý 1 cách đặc biệt. Đầu tiên là trong việc in ra hoặc chèn 1 biến **Optional** vào 1 `String`:

```swift
var optionalInt: Int? = nil
print(optionalInt)                      // nil
"optionalInt = \(optionalInt)"          // "optionalInt = nil"

optionalInt = 10
print(optionalInt)                      // Optional(10)
"optionalInt = \(optionalInt)"          // "optionalInt = Optional(10)"
```

Như vậy, đối với kiểu **Optional**, mọi giá trị khác `nil` đều được đặt trong 1 đối tượng `Optional(...)`. Việc này **Swift** gọi là **wrap** (*gói*), tức là do không biết 1 giá trị **Optional** có giá trị hay không, ta cứ *gói* vào cho chắc chắn.

Lúc này, nếu muốn lấy giá trị thực (trong trường hợp khác `nil`), ta phải **unwrap**, bằng cách sử dụng dấu `!` đằng sau tên biến, ví dụ:

```swift
var optionalInt: Int? = nil
print(optionalInt!)                     // fatal error: unexpectedly found nil while unwrapping an Optional value

optionalInt = 10
print(optionalInt!)                     // 10
"optionalInt = \(optionalInt)"          // "optionalInt = 10"
```

***Lưu ý:*** nếu cố tình **unwrap** một biến `nil`, ta sẽ gặp lỗi `fatal error: unexpectedly found nil while unwrapping an Optional value`

## 3. Unwrap tự động ##

Trong các trường hợp vẫn muốn dùng **Optional** nhưng không muốn lúc nào cũng phải **unwrap**, ta có thể dùng dấu `!` trong khai báo kiểu dữ liệu, thay cho `?`, việc này gọi là **unwrap tự động**, ví dụ:

```swift
var autoUnwrap: Int! = nil
print(autoUnwrap)                       // fatal error: unexpectedly found nil while unwrapping an Optional value

autoUnwrap = 10
print(autoUnwrap)                       // 10
"optionalInt = \(autoUnwrap)"           // "optionalInt = 10"
```

Tất nhiên, khi ta **unwrap tự động** 1 biến `nil` thì vẫn nhận được thông báo lỗi `fatal error: unexpectedly found nil while unwrapping an Optional value` như thường, vì bản chất việc này là ẩn dấu `!` mỗi lần sử dụng biến mà thôi

## 4. Optional binding ##

Trong **Swift** cũng như 1 số ngôn ngữ hiện đại khác như **Ruby**, **Javascript**, **HTML**,... ta có một thuật ngữ gọi là **binding**. Hiểu 1 cách đơn giản, **binding** là việc gán/đọc giá trị của 1 biến tại 1 thời điểm nhất định, trong 1 hoàn cảnh cụ thể. Cú pháp đơn giản nhất của **binding** trong Swift là khi dùng `if` như sau:

```swift
optionalInt = nil

if let checkedInt = optionalInt {
  print(checkedInt)
  "checkedInt = \(checkedInt)"
} else {
  print("nil")
  "no value for checkedInt"
}
```

Tại dòng số **3**, ta tiến hành **binding** biến `optionalInt` vào 1 biến tạm tên là `checkedInt`:

* Trong trường hợp `optionalInt` có giá trị `nil`, lệnh **binding** này sẽ trả ra kết quả `false`, block `else` được thực thi
* Ngược lại, nếu `optionalInt` có giá trị khác `nil`, block `if` được thực thi

Lúc này chúng ta không cần phải **unwrap** nữa, cũng không cần khai báo `checkedInt` theo kiểu **unwrap tự động** gì cả

Trong bài viết [sau]({% post_url 2016-07-01-swift-optionals-2 %}), ta sẽ cùng xem cách dùng của kiểu **Optional** trong các vấn đề nâng cao hơn của **Swift**, đó là **Method chaining** và **Ép kiểu** (**Value casting**)
