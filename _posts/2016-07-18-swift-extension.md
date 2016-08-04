---
layout: article
title: "[Swift] Mở rộng chức năng của các kiểu dữ liệu với Extension"
description: "Hiểu & sử dụng Extension trong Swift để làm việc hiệu quả hơn với các kiểu dữ liệu"
date: 2016-07-18 10:17:00 +0700
categories: [swift]
tags: [extension, 'mở rộng']
comments: true
---

**Swift** cũng giống như **Objective-C**, cung cấp 1 tính năng rất hay đó là **Extension**, tức là mở rộng các phương thức của 1 kiểu dữ liệu có sẵn nào đó, ví dụ để đổi 1 giá trị kiểu `String` thành 1 số kiểu `Int`, ta không có sẵn 1 hàm nào, ví dụ là `toInt()` để gọi 1 cách nhanh chóng. Những lúc như thế này, Extension chính là giải pháp cực kỳ hiệu quả.

## 1. Định nghĩa mới 1 hàm với Extension ##

Để định nghĩa mới 1 hàm bằng Extension, ta làm như sau:

```swift
extension String {
  func toInt() -> Int {
    let numberFormatter = NSNumberFormatter()
    
    if let number = numberFormatter.numberFromString(self) {
      return Int(round(number.doubleValue))
    } else {
      return 0
    }
  }
}

"12".toInt()                // 12
"12.1".toInt()              // 12
"12.9".toInt()              // 13
```

Tất cả những hàm chúng ta muốn định nghĩa mới sẽ nằm trong từ khóa `extension String`. Trong trường hợp này, chúng ta sử dụng 'NSNumberFormatter' để chuyển đổi bản thân String đang gọi, truy cập qua từ khóa `self` sang dạng `Double` thông qua thuộc tính `number.doubleValue`, làm tròn và đổi thành số dạng `Int`.

Cái hay của **Swift** nói chung và **Extension** nói riêng đó là ta có thể định nghĩa nhiều hàm có cùng tên, khác nhau về tham số, ví dụ: ta vẫn có hàm `toInt()`, nhưng có thêm tham số `rounded: Bool` để tùy chọn có làm tròn hay không:

```swift
extension String {
  func toInt() -> Int {
    let numberFormatter = NSNumberFormatter()
    
    if let number = numberFormatter.numberFromString(self) {
      return Int(round(number.doubleValue))
    } else {
      return 0
    }
  }
  
  func toInt(rounded: Bool) -> Int {
    let numberFormatter = NSNumberFormatter()
    
    if let number = numberFormatter.numberFromString(self) {
      if rounded {
        return Int(round(number.doubleValue))
      } else {
        return number.integerValue
      }
    } else {
      return 0
    }
  }
}

"12".toInt(false)           // 12
"12.1".toInt(false)         // 12
"12.9".toInt(false)         // 12
```

Lúc này, cả 3 giá trị `12`, `12.1` & `12.9` khi gọi `toInt(false)` đều trả về giá trị `Int` là `12`.

Để tối giản số dòng code, ta cũng có thể khai báo **default parameter** như sau:

```swift
extension String {
  func toInt(rounded: Bool = true) -> Int {
    let numberFormatter = NSNumberFormatter()
    
    if let number = numberFormatter.numberFromString(self) {
      if rounded {
        return Int(round(number.doubleValue))
      } else {
        return number.integerValue
      }
    } else {
      return 0
    }
  }
}
```

## 2. Định nghĩa subscript ##

Có 1 tính năng rất hay của **Swift** mà **Objective-C** không có, đó là ta có thể định nghĩa các **subscript**, hay cặp dấu `[]` để sử dụng theo cú pháp của **Array** hay **Dictionary**, ví dụ:

```swift
extension String {
  subscript(range: Range<Int>) -> String {
    if range.startIndex >= self.characters.count {
      return ""
    }
    
    let startIndex = self.startIndex.advancedBy(range.startIndex)
    let endIndex = self.startIndex.advancedBy(range.endIndex, limit: self.endIndex)
    return self.substringWithRange(startIndex..<endIndex)
  }
}

"Swift Extension"[0...4]            // "Swift"
"Swift Extension"[11...14]          // "sion"
"Swift Extension"[11...17]          // "sion"
"Swift Extension"[16...17]          // ""
```

Để định nghĩa 1 **subscript**, ta dùng cú pháp `subscript(range: Range<Int>) -> String`, có nghĩa là ta sẽ dùng cú pháp `string[1...3]` để trả về String con của String gốc. Có 1 điểm hay là trong hàm này chúng ta sẽ xử lý các trường hợp ngoại lệ: `startIndex` vượt quá độ dài của String, `endIndex` vượt quá độ dài của String,... và trả về các String con tương ứng.

Các bạn có thể tải về file [Extension.playground][attachment] để cùng xem các ví dụ về **Extension** đã trình bày trong bài.

[attachment]:               /assets/downloads/swift/2016-07-18-Extension.zip
