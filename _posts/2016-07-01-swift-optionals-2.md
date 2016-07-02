---
layout: post
title: "[Swift] Kiểu giá trị Optional - Các trường hợp nâng cao"
description: "Sử dụng tính năng Optional trong các trường hợp nâng cao: Optional chaining & Ép kiểu (as, as? & as!)"
date: 2016-07-01 10:00:00 +0700
categories: [swift]
tags: [swift, optional, type, 'ký pháp ?', 'question mark', 'ký pháp !', 'exclamation mark', 'optional chaining', 'ép kiểu', 'value casting', 'as']
comments: true
---

*... tiếp theo bài viết [[Swift] Kiểu giá trị Optional - Các cách khai báo & sử dụng]({% post_url 2016-06-30-swift-optionals-1 %})*

# 5. Method chaining #

Trong **Swift** cũng như các ngôn ngữ hiện đại như **Ruby**, **Python**,... các lập trình viên rất thích sử dụng 1 cú pháp gọi là **method chaining**. Ví dụ:

```swift
extension Int {
  func add(otherNum: Int) -> Int {
    return self + otherNum
  }
  
  func multiply(otherNum: Int) -> Int {
    return self * otherNum
  }
}

var number: Int = 10
number.add(2).multiply(5)                   // (10 + 2) * 5 = 60
```

Ở đây, ta viết thêm 2 phương thức `add()` và `multiply()` cho kiểu `Int` để cộng và nhân 1 số nguyên với 1 số nguyên khác, kết quả trả ra 1 số nguyên (cách làm này gọi là viết **Extension**, tôi sẽ đề cập ở 1 bài khác). Sau khi khai báo 2 hàm, với mỗi số nguyên kiểu `Int`, ta có thể gọi `add()` và `mutiply()` theo cú pháp `number.add()` hoặc `number.multiply()`.

Điểm đặc biệt là do kết quả trả về vẫn là `Int`, nên với các công thức gồm nhiều phép tính, ta có thể gọi liên tiếp `add()` và `multiply()` mà không cần phải sử dụng đến 1 biến để lưu trữ các kết quả trung gian.

# 6. Optional chaining #

Giờ ta thêm 1 hàm nữa tên là `divide()`, có chức năng thực hiện phép chia:

```swift
extension Int {
  func divide(otherNum: Int) -> Int? {
    if otherNum == 0 {
      return nil
    }

    return self / otherNum
  }
}

number.divide(0)?.add(10)
```

Phép chia cần 1 điều kiện là số chia (*divisor*) cần phải khác `0`. Các trường hợp số chia bằng `0` đều dẫn đến lỗi *chia cho `0`* hoặc *vô cùng*. Nếu muốn trả về 1 kết quả `nil`, ta khai báo kiểu trả về của phương thức `divide()` là `Int?`, tức là `Int` nhưng có thể nhận giá trị `nil`.

Lúc này, nếu muốn dùng **method chaining**, ta có 2 cách:

**Cách thứ 1:** Kiểm tra xem kết quả có bằng `nil` hay không và sử dụng **unwrap**:

```swift
var result = number.divide(0)

if result != nil {
  result = result!.add(10)
}
```

**Cách thứ 2:** Sử dụng **optional chaining**

```swift
number = 10
number.divide(0)?.add(10).multiply(5)         // nil
number.divide(3)?.add(10).multiply(5)         // 65
```

Lúc này, **Swift** sẽ kiểm tra xem `divide()` có trả về giá trị `nil` hay không:

* Nếu có, lập tức trả lại kết quả là `nil`, không quan tâm các hàm gọi sau có điều kiện là gì.
* Nếu không, **unwrap** để lấy 1 giá trị `Int` và gọi tiếp các hàm ở sau.

# 7. Value casting #

Như đã nói trong các bài trước, **Swift** là 1 ngôn ngữ **hướng đối tượng**, vậy nên nó có tính **kế thừa**, tức là 1 `class` có thể kế thừa từ 1 `class` khác. Ta cũng biết `NSArray` và `NSDictionary` đều là các `class` kế thừa từ `NSObject`:

```swift
public class NSArray : NSObject, NSCopying, NSMutableCopying, NSSecureCoding, NSFastEnumeration {
  ...
}

public class NSDictionary : NSObject, NSCopying, NSMutableCopying, NSSecureCoding, NSFastEnumeration {
  ...
}
```

Như vậy, ta hoàn toàn có thể khai báo 1 `Dictionary` như sau mà không gặp lỗi:

```swift
var json: [String: NSObject?] = [
  "array": NSArray(),
  "dict": NSDictionary(),
  "nil": nil
]
```

Khi đó, nếu gọi `json["array"]`, ta sẽ nhận được 1 giá trị kiểu `NSObject`. Ta cần đổi nó về `NSArray` để gọi được các phương thức dành riêng cho `NSArray`, ví dụ như `count()`. Lúc này, ta phải làm 1 động tác gọi là **ép kiểu** (tiếng Anh: **value casting**):

```swift
let optionalArray = json["array"] as? NSArray
let unwrappedArray = json["array"] as! NSArray
```

Lúc này, `optionalArray` có kiểu `NSArray?`, còn `unwrappedArray` có kiểu `NSArray`. Tất nhiên, trong trường hợp cố gắng **unwrap** `json["nil"]`:

```swift
json["nil"] as! NSArray
```

ta sẽ gặp lỗi

![Lỗi ép kiểu với giá trị nil][casting-nil-value-error]

Các bạn có thể tải về file [Optionals.playground][attachment] để cùng xem các ví dụ về **Optional** trong **Swift**

[casting-nil-value-error]:  /assets/media/posts/swift/2016-07-01-casting-nil-value-error.png
{:class="img-responsive"}

[attachment]:               /assets/downloads/swift/2016-07-01-Optionals.zip