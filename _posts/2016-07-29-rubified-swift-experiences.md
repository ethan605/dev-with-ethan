---
layout: article
title: "[Swift] Những bài học từ RubifiedSwift (P1)"
description: "Trải nghiệm trong quá trình viết & duy trì bộ thư viện RubifiedSwift"
date: 2016-07-29 11:50:00 +0700
categories: [swift]
tags: [swift, ruby, cocoapods, 'thư viện', 'trải nghiệm']
comments: true
---

*Như đã thông báo về* **[Bộ thư viện RubifiedSwift]({% post_url 2016-07-22-rubified-swift-created %})** *, mục đích chính của series* **Những bài học từ RubifiedSwift** *chủ yếu là để lưu lại những trải nghiệm, nhận định và bài học của bản thân mình về tất tần tật có liên quan đến project. Việc ghi lại mang tính chất nhật ký hơn là các bài viết hướng dẫn hay phân tích học thuật khác.*

## 1. Optional quả là khó nhằn, nhưng vỡ ra được rồi thì cứ thấy sướng mãi ##

**RubifiedSwift** bắt đầu với 1 hàm rất hay của **Ruby** là `compact()`. Mục tiêu của hàm này là lược hết tất cả các giá trị `nil` và trả về 1 mảng hoàn toàn *sạch sẽ*, tức là không bao giờ lo đến chuyện `undefined method ... for nil:NilClass`. Thật sự đây là 1 thông báo lỗi rất củ chuối của **Ruby**, vì trong khi việc viết code mang đến cho người ta cảm giác nhẹ nhàng thư thái bao nhiêu, thì việc bắt và xử lý các tình huống `nil` như thế này lại làm cho người ta cảm thấy khó chịu và xấu xí bấy nhiêu. Đây cũng là 1 trong những khác biệt cơ bản giữa 1 ngôn ngữ **dynamic** như **Ruby** với 1 ngôn ngữ **static** như **Swift**. Coi như Ruby chơi bài *sướng trước khổ sau*, thì **Swift** sẽ ngược lại, *khổ trước sướng sau*.

Rõ ràng với các trường hợp mà phần tử có kiểu xác định (như `Int`, `Double` hay `String`), thì chả bao giờ tồn tại phần tử `nil` nào cả. Tức là `Array` mặc định của **Swift** đã `compact()` mọi thứ sẵn cho chúng ta rồi. Chỉ còn lại các trường hợp, ví dụ như dưới đây, mới cần phải loại bỏ `nil` ra khỏi `Array`:

```swift
let array: [AnyObject?] = [1, 2, "3", 4.0, nil, 5]
```

Kiểu của `array` là `AnyObject?`, tức là tất tần tật mọi thứ (không phải dạng tập hợp như `Array` hay `Dictionary`) đều có thể làm phần tử được, *kể cả* `nil`!. Vấn đề nằm ở chỗ khai báo extension cho hàm `compact()`:

```swift
extension Array {
  public func compact() -> [Element] {
    return self.filter { $0 != nil }
  }
}
```

và gọi `array.compact()` thì không có gì thay đổi cả! Thử in ra các giá trị `$0` và so sánh nó với `nil` xem sao:

```swift
public func compact() -> [Element] {
  return self.filter {
    print($0, $0 != nil)
    return $0 != nil
  }
}
```

Lập tức ta sẽ gặp lỗi **Value of type 'Element' can never be nil, comparision isn't allowed**. Tức là mặc dù ta gọi `compact()` trên 1 `Array` gồm toàn phần tử `Optional`, nhưng hàm trong extension thì không nhận ra điều đó. Ta cũng biết khai báo extension trong **Swift** có thể định nghĩa thêm các điều kiện ràng buộc, ví dụ như:

```swift
extension Array where Element: Equatable {
  ...
}
```

thì có nghĩa là các phần tử (`Element`) của `Array` này phải *conform* protocol tên là `Equatable`. Nhưng vấn đề ở chỗ: không có cách nào để thông báo với **Swift** rằng chúng ta muốn xử lý các mảng có các phần tử kiểu `Optional` cả, do vậy khai báo như sau:

```swift
extension Array where Element: Optional {
  ...
}
```

sẽ gặp lỗi **Reference to generic type 'Optional' requires arguments in <...>**. Lý do chính là các kiểu đứng sau `where Element: ...` phải là protocol, chứ không thể là 1 type. Mà `Optional` thì lại là 1 type! May phước sau 1 hồi **Google** & **StackOverflow**, ta biết được rằng cần phải đi đường vòng 1 chút: tạo ra 1 protocol có tên là `OptionalType` để thể hiện kiểu `Optional` như sau:

```swift
public protocol OptionalType {
  associatedtype Wrapped
  var optional: Wrapped? { get }
}

extension Optional: OptionalType {
  public var optional: Wrapped? { return self }
}
```

Chúng ta đã biết `Optional` là 1 kiểu **[Generics]({% post_url 2016-07-08-swift-generics %})**, và trong khai báo của `Optional` ta có:

```swift
public enum Optional<Wrapped> : _Reflectable, NilLiteralConvertible {
  ...
}
```

Tức là `Optional` có nhiệm vụ *bao bọc* (wrap) một kiểu `Wrapped` nào đó (có thể là `Int`, `Double`, `String` hay thậm chí `AnyObject`). Vậy ta sẽ thêm 1 thuộc tính tên là `optional` để trả về bản thân giá trị của `Optional`, nhưng có 1 kiểu là `Optional`, chứ không phải kiểu `Element` như ở trên (so sánh `Element` với `nil` thì luôn *fail*, nhưng so sánh `Optional` với `nil` thì hợp lệ).

Sau cùng, ta sửa lại extension của chúng ta như sau:

```swift
extension Array where Element: OptionalType {
  public func compact() -> [Element] {
    return self.filter { $0.optional != nil }
  }
}
```

Ở dòng `3`, ta không so sánh trực tiếp `$0 != nil`, mà ta so sánh `$0.optional != nil`, tức là về bản chất thì vẫn là so sánh 1 giá trị `Optional` với `nil`, nhưng về hình thức thì ta đi đường vòng qua thuộc tính `optional`.

Kết quả khi gọi `array.compact()`, ta được mảng `[Optional(1), Optional(2), Optional(3), Optional(4), Optional(5)]`, tức là giá trị `nil` cuối cùng đã bị loại bỏ.

***Nói thêm ra ngoài 1 chút***: trong ví dụ tìm được từ **StackOverflow**, ta có được đoạn code như sau:

```swift
extension Array where Element: OptionalType {
  public func unwrapped() -> [Element.Wrapped]? {
    let initial = Optional<[Element.Wrapped]>([])
    
    return self.reduce(initial) { (reduced, element) in
      reduced.flatMap { (arr) in element.optional.map { a + [$0] } }
    }
  }
}
```

Hàm này có chức năng **unwrap** toàn bộ các phần tử trong mảng, và xử lý 2 trường hợp:

* Nếu mảng tồn tại phần tử `nil`, trả về `nil`.
* Nếu mang không tồn tại phần tử `nil`, trả về 1 mảng kiểu `Optional`, bao gồm tất cả các phần tử đã được **unwrap**.

Hàm này trả về kiểu `[Element.Wrapped]?`, tức là 1 mảng các phần tử đã được **unwrap**, nhưng có thể trả về cả nil. Thân hàm sử dụng `reduce()` với khởi tạo là 1 hàm rỗng (dùng `Optional<[Element.Wrapped]>([])` cũng tương tự với `([Element.Wrapped])?([])` nhưng rối mắt hơn):

* Tại mỗi bước `reduce()`, ta trả về `reduced.flatMap()`, lúc này, do `reduced` là 1 mảng `Optional`, nên nó sẽ trả về chính nó hoặc `nil`, nhưng tham số trong block thì lại là 1 mảng đã được **unwrap**, tức là có kiểu `[Element.Wrapped]`.
* Tại mỗi bước `flatMap()`, ta làm tương tự với `element`. Vì `element` có kiểu `Optional<Wrapped>` nên `map()` và `flatMap()` có tác dụng như nhau. Tại block trong cùng này, nếu cả `arr` (tức là `reduced` được **unwrap**) và `$0` (tức là `element` được **unwrap**) đều tồn tại giá trị, thì ta trả về mảng `arr` thêm phần tử `$0` ở cuối. Bằng không, trả về `nil`.

Lúc này, nếu ta gọi `array.unwrap()` sẽ nhận được giá trị `nil`, vì trong mảng `array` tồn tại phần tử cuối cùng là `nil`. Bỏ phần tử `nil` này đi, tức là toàn bộ mảng đều khác `nil`, `array.unwrap()` trả về giá trị `Optional([1, 2, 3, 4, 5])`:

```swift
var array: [AnyObject?] = [1, 2, "3", 4.0, nil, 5]
print(array.unwrapped())            // nil

array = [1, 2, "3", 4.0, 5]
print(array.unwrapped())            // Optional[1, 2, 3, 4, 5]
```
