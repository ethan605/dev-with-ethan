---
layout: post
title: "[Swift] Biểu diễn số Phức và các phép toán"
description: Sử dụng Struct và các toán tử để biểu diễn số Phức trong Swift
date: 2016-06-29 9:08:00 +0700
categories: [tutorials]
tags: [swift, struct, complex, 'số phức', 'toán tử']
comments: true
---

# 1. Phát biểu bài toán #

Trong toán học, chúng ta có 1 kiểu số gọi là số **Phức** (*Complex number*), tức là 1 số bao gồm 2 phần: phần **Thực** và phần **Ảo**, trong đó phần **Thực** là phần biểu diễn 1 số trong tập số thực, còn phần **Ảo** cũng là một số thực nhưng đi kèm với ký tự `i`, trong đó `i^2 = -1`. Các bạn có thể tham khảo thêm tại [trang Wikipedia][complex-number].

Chúng ta cần lưu trữ và biểu diễn 1 số **Phức** bao gồm 2 số thực đại diện cho phần **Thực** và phần **Ảo**, kèm theo các phép tính toán đơn giản là **cộng**, **trừ**, **nhân**, **chia**

# 2. Biểu diễn số Phức #

## Class và Struct trong Swift ##

**Swift** là 1 ngôn ngữ đa hình (multi paradigm), vậy nên nó hỗ trợ cả [Object-Oriented Programming][oop] lẫn [Functional Programming][fp], **Class** và **Struct** là 2 cách thể hiện của OOP trong Swift.

Theo cuốn [The Swift Programming Language (2.2)][swift-book], **Class** và **Struct** tương đối giống nhau trong cách khai báo & ý nghĩa, tuy nhiên có 1 số khác nhau:

1. **Class** thì có [Kế thừa][inheritance], **Struct** thì không
2. Tại `run-time`, ta có thể kiểm tra kiểu của **Class**, **Struct** thì không làm được
3. Class thì có các `deinitializers`, ta có thể giải phóng tài nguyên do 1 thực thể (*instance*) của **Class** nắm giữ
4. Theo cơ chế **[Automatic Reference Counting][arc]**, 1 instance của **Class** có thể có nhiều tham chiếu (*references*), trong khi **Struct** thì không

Cơ chế số **4.** tạo ra 1 sự khác biệt rất lớn trong cách dùng của **Class** và **Struct** như sau:

* **Class** là **reference type**, còn **Struct** là **value type**, như vậy, khi thực hiện phép gán (`=`), thì **Swift** thực hiện thao tác **trỏ** vào instance của **Class**, còn với instance của **Struct** thì sẽ là **copy** dữ liệu từ các thuộc tính của instance **Struct** này sang các thuộc tính của instance **Struct** khác
* Nếu quan tâm đến việc các instance mình có thể liên quan đến nhau, di chuyển đến các nơi khác nhau và việc thay đổi thuộc tính sẽ được phản hồi lại đầy đủ về vị trí sử dụng lần đầu, thì chọn **Class**
* Trường hợp chỉ quan tâm đến thông tin lưu trữ trong đó, mà không cần biết nó đi đâu làm gì, được gán như thế nào, thì chọn **Struct**

Như vậy, trong bài toán **Biểu diễn số Phức**, chúng ta sẽ dùng **Struct**

# 3. Định nghĩa Struct số Phức #

Ta có thể định nghĩa 1 số **Phức** bằng **Struct** như thế này:
{% highlight swift %}
struct ComplexNumber: CustomStringConvertible {
  var re: Double = 0
  var im: Double = 0

  init(re: Double, im: Double) {
    self.re = re
    self.im = im
  }

  var description: String {
    if self.isNaN() {
      return "C{NaN}"
    }
    
    if im == 0 {
      return "R{\(re)}"
    }
    
    let imSign = im > 0 ? "+" : "-"
    return "C{\(re) \(imSign) \(abs(im))i}"
  }
  
  func modulus() -> Double {
    return sqrt(re*re + im*im)
  }

  func argument() -> (Double, Double) {
    return (re, im)
  }
}
{% endhighlight %}

Ở đây, ta dùng protocol `CustomStringConvertible` với mục đích định nghĩa thuộc tính `description`, dùng để hiển thị ra 1 `String` dễ đọc trong trường hợp cần `print` hoặc *interpolate* số Phức này vào 1 `String`, ví dụ:

{% highlight swift %}
let c1 = ComplexNumber(re: 1, im: 3)
print(c1)

let c2 = ComplexNumber(re: 2, im: -4)
"Complex number 2: \(c2)"
{% endhighlight %}

Ngoài ra, function `modulus` dùng để lấy **Mođun** và function `argument` dùng để lấy **Argumen** của số Phức này ([xem thêm][modulus-argument]). Ví dụ:

{% highlight swift %}
c1.modulus()        // 3.16227766016838
c1.argument()       // (1, 3)
{% endhighlight %}

# 4. Định nghĩa các phép toán #

Số Phức có đầy đủ các phép toán giống như 1 số Thực: đối (`reflection`) ngịch đảo (`reciprocal`), cộng (`add`), trừ (`subtract`), nhân (`multiply`), chia (`divide`).

{% highlight swift %}
func reflection() -> ComplexNumber {
  var ref = self
  ref.im = -self.im
  return ref
}

func reciprocal() -> ComplexNumber {
  if self.isZero() {
    return ComplexNumber.NaN
  }
  
  var rec = ComplexNumber()
  let sumOfSquares = self.re*self.re + self.im*self.im
  rec.re = self.re / sumOfSquares
  rec.im = self.im / sumOfSquares
  return rec
}

func divide(otherNumber: ComplexNumber) -> ComplexNumber {
  if otherNumber.isZero() {
    return ComplexNumber.NaN
  }
  
  var result = ComplexNumber()
  
  let sumOfSquares = otherNumber.re*otherNumber.re + otherNumber.im*otherNumber.im
  result.re = (self.re*otherNumber.re + self.im*otherNumber.im) / sumOfSquares
  result.im = (self.im*otherNumber.re - self.re*otherNumber.im) / sumOfSquares
  return result
}
{% endhighlight %}

Ngoài ra còn có thêm các phép toán nhân với 1 số thực (`multiply:factor`), chia cho 1 số thực khác 0 (`divide:factor`) và bị chia bởi 1 số thực (`dividedBy:factor`). Do các phép chia đều phải kiểm tra số chia có bằng `0` hay không, nên ta có thêm 1 phương thức `isZero` kiểm tra điều kiện `re` và `im` đều bằng `0`. Trường hợp cố gắng chia cho 0, ta sẽ có 1 giá trị mặc định là `ComplexNumber.NaN` có cả `re` và `im` đều là `Double.NaN`

{% highlight swift %}
static var NaN: ComplexNumber = ComplexNumber(re: Double.NaN, im: Double.NaN)

func isZero() -> Bool {
  return re == 0 && im == 0
}

func multiply(factor: Double) -> ComplexNumber {
  var result = self
  result.re *= factor
  result.im *= factor
  return result
}

func divide(factor: Double) -> ComplexNumber {
  if factor == 0 {
    return ComplexNumber.NaN
  }
  
  var result = self
  result.re /= factor
  result.im /= factor
  return result
}

func dividedBy(factor: Double) -> ComplexNumber {
  if self.isZero() {
    return ComplexNumber.NaN
  }
  
  var result = self.reciprocal()
  result = result.multiply(factor)
  return result
}
{% endhighlight %}

# 5. Sử dụng các toán tử #

Nhưng nếu cứ dùng các methods như trên thì dài dòng quá. **Swift** cung cấp cho chúng ta các chức năng định nghĩa lại các toán tử:

{% highlight swift %}
prefix func -(c1: ComplexNumber) -> ComplexNumber {
  return c1.reflection()
}

func +(c1: ComplexNumber, c2: ComplexNumber) -> ComplexNumber {
  return c1.add(c2)
}

func -(c1: ComplexNumber, c2: ComplexNumber) -> ComplexNumber {
  return c1.subtract(c2)
}

func *(c1: ComplexNumber, c2: ComplexNumber) -> ComplexNumber {
  return c1.multiply(c2)
}

func *(c1: ComplexNumber, factor: Double) -> ComplexNumber {
  return c1.multiply(factor)
}

func /(c1: ComplexNumber, c2: ComplexNumber) -> ComplexNumber {
  return c1.divide(c2)
}

func /(c1: ComplexNumber, factor: Double) -> ComplexNumber {
  return c1.divide(factor)
}
{% endhighlight %}

Đối với các toán tử không phải là mặc định, ta có thể định nghĩa mới thông qua các khai báo `operator`, ví dụ:

{% highlight swift %}
infix operator + {associativity left precedence 150}
infix operator - {associativity left precedence 150}
infix operator * {associativity left precedence 150}
infix operator / {associativity left precedence 150}
prefix operator - {}
{% endhighlight %}

Trong đó:

* `associativity` quy định chiều của toán tử: `left` là tính toán từ trái qua phải, còn `right` là từ phải qua trái
* `precedence` quy định ưu tiên của toán tử: `precedence` càng cao thì càng được ưu tiên và tính toán trước. Mặc định, các phép toán `+`, `-`, `*`, `/` có `precedence` là 150

***Cập nhật:***
Các bạn có thể tải về file [ComplexNumber.playground][attachment] để cùng xem các cài đặt và ví dụ về số **Phức** trong **Swift** được sử dụng như thế nào

[complex-number]:   https://vi.wikipedia.org/wiki/S%E1%BB%91_ph%E1%BB%A9c
[oop]:              https://vi.wikipedia.org/wiki/L%E1%BA%ADp_tr%C3%ACnh_h%C6%B0%E1%BB%9Bng_%C4%91%E1%BB%91i_t%C6%B0%E1%BB%A3ng
[fp]:               https://vi.wikipedia.org/wiki/L%E1%BA%ADp_tr%C3%ACnh_h%C3%A0m
[swift-book]:       https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/
[inheritance]:      https://en.wikipedia.org/wiki/Inheritance_(object-oriented_programming)
[arc]:              https://en.wikipedia.org/wiki/Automatic_Reference_Counting
[modulus-argument]: https://vi.wikipedia.org/wiki/S%E1%BB%91_ph%E1%BB%A9c#Mo.C4.91un_v.C3.A0_Argumen
[attachment]:       {{ site.BASE_PATH }}/downloads/2016-06-29-ComplexNumber.zip