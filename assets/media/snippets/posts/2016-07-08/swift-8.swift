func objectGreeting<T: Base>(classType: T.Type) -> String {
  print(T.announce())
  return classType.init().greet()
}

objectGreeting(Base.self)           \\ "Hi, I'm a Base"
objectGreeting(Person.self)         \\ "Hi, I'm a Person"
objectGreeting(Animal.self)         \\ "Hi, I'm a Animal"
```

Lúc này, khi gọi hàm `objectGreeting()` với các tham số lần lượt là `Base.self`, `Person.self` & `Animal.self`, ta sẽ nhận được các *lời chào* tương ứng.

Có 1 điểm đặc biệt ở đây, là do việc tạo 1 object `classType.init()` đang sử dụng dạng **dynamic** thay vì `Base()`, `Person()` hay `Animal()` thông thường, **Swift** yêu cầu chúng ta phải định nghĩa hàm `required init()` và sử dụng `classType.init()` thay vì `classType()` như bình thường:

```swift
class Base: NSObject {
  required override init() {}
  ...
}
