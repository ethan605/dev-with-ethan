---
layout: post
title: "[Swift] Kinh nghiệm sử dụng Generics"
description: "Khám phá tính năng Generics của Swift để linh hoạt xử lý các kiểu dữ liệu khác nhau"
date: 2016-07-08 16:43:00 +0700
categories: [swift]
tags: [swift, generics, template, 'linh hoạt', 'kiểu dữ liệu', 'data type']
comments: true
---

# 1. Khái niệm Generics trong lập trình #

**Generics** là 1 tính năng xuất hiện khá sớm, từ các ngôn ngữ *cổ điển* như **C/C++** hay **Java**. Tính năng này xuất phát từ 1 thực tế: trong những ngôn ngữ **strong typing** (như **C/C++**, **Java** hay **Swift**), các nhiều kiểu dữ liệu khác nhau không thể được dùng lẫn lộn, và khi có 1 logic nào đó cần xử lý trên nhiều kiểu dữ liệu, ta lại phải định nghĩa hết các hàm tương ứng với từng kiểu dữ liệu đó.

Ví dụ: khi định nghĩa 1 hàm `max()` để tìm số lớn hơn trong 2 số bất kỳ, bình thường thì có bao nhiêu kiểu dữ liệu số, ta phải định nghĩa bấy nhiêu hàm tương ứng:

```swift
func max(number1: Int, _ number2: Int) -> Int {
  return number1 > number2 ? number1 : number2
}

func max(number1: Double, _ number2: Double) -> Double {
  return number1 > number2 ? number1 : number2
}

max(1, 2)               // 2
max(2.8, 1.5)           // 2.8
```

Mặc dù phải định nghĩa nhiều hàm như vậy, nhưng đến lúc gọi hàm, ta chỉ gọi duy nhất 1 lần `max()` cho từng kiểu dữ liệu. Với **Generics**, chúng ta có thể rút ngắn sự phiền toán này lại.

# 2. Generics trong Swift #

Quay trở lại với hàm `max()` ở trên, **Swift** cho phép chúng ta định nghĩa 1 hàm **Generics** như sau:

```swift
func genericsMax<T: Comparable>(number1: T, _ number2: T) -> T {
  return number1 > number2 ? number1 : number2
}

genericsMax(1, 2)       // 2
genericsMax(2.8, 1.5)   // 2.8
```

Như vậy, bằng cú pháp khai báo `<T: Comparable>` ngay sau tên hàm `genericsMax`, ta có thể sử dụng `T` như 1 kiểu dữ liệu hợp lệ. Tuy nhiên, do các phép so sánh (`>`, `>=`, `<`, '<=' và '=') không áp dụng cho mọi kiểu dữ liệu, nên ta cần *hạn chế* bớt các trường hợp có thể của `T` lại.

Trong trường hợp này, ta định nghĩa `T` cần phải **conform protocol** tên là `Comparable`. Việc làm này gọi là **constrains** (nghĩa là *ràng buộc*). Khai báo đầy đủ của **Generics constrains** sử dụng từ khóa `where` như sau:

```swift
func genericsMax<T where T: Comparable>(number1: T, _ number2: T) -> T {
  return number1 > number2 ? number1 : number2
}
```

tức là ta muốn khai báo hàm `genericsMax()` sẽ làm việc trên 1 kiểu **Generics** là `T`, nhưng `T` chỉ nằm trong những kiểu có **conform protocol** tên là `Comparable`. Việc này đồng nghĩa với khi gọi `genericsMax("1", "2")` thì vẫn được, nhưng gọi `genericsMax([1], [2])` thì sẽ báo lỗi **Cannot invoke 'genericsMax' with an argument list of type ([Int], [Int])**

Cái hay của **Generics** trong **Swift** là chúng ta không cần phải khai báo kiểu dữ liệu khi dùng, ví dụ như `genericsMax<Int>(1, 2)` hay `genericsMax<Double>(1.5, 2.8)` mà trình biên dịch sẽ tự động kiểm tra kiểu và xử lý cho phù hợp.

# 3. Ép kiểu khi dùng Generics #

Tuy nhiên trong thực tế, có những lúc chúng ta cần phải đưa ra những cách xử lý khác nhau đối với các kiểu dữ liệu khác nhau, ví dụ:

```swift
func genericsMax<T: Comparable>(number1: T, _ number2: T) -> T {
  if T.self == Double.self {
    print("Compare Double numbers \(number1) & \(number2)")
  }
  
  return number1 > number2 ? number1 : number2
}
```

Trong trường hợp này, chúng ta kiểu tra xem `T` có phải là `Double` hay không, nếu đúng thì in ra 1 dòng **Compare Double numbers [number1] & [number2]**.

Khi gọi `genericsMax(1, 2)`, vì trình biên dịch tự động nhận kiểu là `Int`, nên đoạn `if` không được thực thi, nhưng khi gọi `genericsMax(1.5, 2.8)` thì do kiểu của 2 tham số là `Double`, nên có 1 dòng in ra **Compare Double numbers 1.5 & 2.8**.

Vấn đề là nếu ta cũng muốn gọi `genericsMax(1, 2)` và in ra dòng kia thì sao? Bình thường ta có thể ép kiểu `genericsMax(Double(1), Double(2))`, nhưng có 1 cách ngắn gọn hơn:

```swift
let result: Double = genericsMax(1, 2)

// Alternatively
genericsMax(1, 2) as Double
```

Do ta khai báo kiểu trả về của `genericsMax()` cũng là `T`, nên nếu ta thông báo với trình biên dịch là ta muốn trả về kiểu `Double` thì trong thân hàm, `T` sẽ nhận kiểu `Double`

# 4. Dùng kiểu dữ liệu như biến số #
Ngoài ra, trong quá trình làm việc, người ta nhận thấy rằng đôi khi cần phải sử dụng các kiểu dữ liệu như **biến số** (*variable*). Xét ví dụ sau:

```swift
class Base: NSObject {
  required override init() {}

  class func announce() -> String {
    let classType = NSStringFromClass(self)
    let className = classType.componentsSeparatedByString(".").last!
    return "Using class \(className)"
  }
  
  func greet() -> String {
    let classType = NSStringFromClass(self.dynamicType)
    let className = classType.componentsSeparatedByString(".").last!
    return "Hi, I'm a \(className)"
  }
}

class Person: Base {
}

class Animal: Base {
}
```

Ta có 3 class `Base`, `Person` và `Animal`. Đây là 1 ví dụ điển hình để demo các tính năng **kế thừa** của 1 ngôn ngữ **Hướng đối tượng** (*Object-Oriented Programming*). Ở đây chúng ta sẽ chỉ xét đến khả năng sử dụng các kiểu dữ liệu `Base`, `Person`, `Animal` như biến số.

Tại `Base`, ta định nghĩa 1 **class function** là `announce()`, có nhiệm vụ trả ra 1 `String` cho biết chúng ta đang sử dụng kiểu dữ liệu nào, và 1 **instance function** tên là `greet()` cũng có nhiệm vụ trả ra 1 `String`, nhưng là 1 *lời chào* từ chính kiểu dữ liệu đó:

```swift
Base.announce()         \\ "Using class Base"
Person.announce()       \\ "Using class Person"
Animal.announce()       \\ "Using class Animal"

Base().greet()          \\ "Hi, I'm a Base"
Person().greet()        \\ "Hi, I'm a Person"
Animal().greet()        \\ "Hi, I'm a Animal"
```

Giờ giả sử ta có 1 hàm **Generics** tên là `objectGreeting()`, nhận vào 1 tham số `classType` là 1 trong 3 kiểu `Base`, `Person` & `Animal`, có nhiệm vụ: với mỗi kiểu giá trị tương ứng thì tạo 1 **instance** và gọi hàm `greet()`.

```swift
func objectGreeting<T: Base>(classType: T.Type) -> String {
  print(T.announce())
  return classType.init().greet()
}

objectGreeting(Base.self)           \\ "Hi, I'm a Base"
objectGreeting(Person.self)         \\ "Hi, I'm a Person"
objectGreeting(Animal.self)         \\ "Hi, I'm a Animal"
```

Lúc này, khi gọi hàm `objectGreeting()` với các tham số lần lượt là `Base.self`, `Person.self` & `Animal.self`, ta sẽ nhận được các *lời chào* tương ứng.

Có 1 điểm đặc biệt ở đây, là do việc tạo 1 object `classType.init()` đang sử dụng dạng **dynamic** thay vì `Base()`, `Person()` hay `Animal()` thông thường, **Swift** yêu cầu chúng ta phải định nghĩa hàm `required init()`:

```swift
class Base: NSObject {
  required override init() {}
  ...
}
```