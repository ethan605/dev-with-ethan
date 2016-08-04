---
layout: article
title: "[Swift] Làm việc với các tập dữ liệu hiệu quả hơn với Map-Reduce"
description: "Ý nghĩa và cách sử dụng của các hàm Map, Reduce, Filter & Flat Map trong Swift (có đối chiếu với các hàm tương ứng trong Ruby)"
date: 2016-07-15 12:39:00 +0700
categories: [swift]
tags: [array, dictionary, map, reduce, filter, flat, ruby, 'tập dữ liệu']
comments: true
---

Trong các ứng dụng ngày nay, việc xử lý những tập dữ liệu lớn càng ngày càng trở thành 1 bài toán quan trọng. Không cần phải làm việc với các bảng dữ liệu hàng triệu bản ghi, chỉ cần xử lý 1 **Array** và **Dictionary** làm sao cho hiệu quả cũng là 1 vấn đề đau đầu. **Swift**, giống như những ngôn ngữ hiện đại khác, đưa vào các khái niệm **Map-Reduce** nhằm cung cấp cho các Lập trình viên một bộ thư viện linh hoạt, dễ sử dụng và mạnh mẽ.

Do **Swift** kế thừa rất nhiều triết lý của **Ruby**, và bản thân tôi cũng là người yêu cái đẹp của ngôn ngữ này, nên trong bài viết sẽ trình bày các tính năng **Map-Reduce** trong cả 2 ngôn ngữ để bạn đọc cùng theo dõi.

## 1. Map-Reduce là gì? ##

Tuy đây là 1 kỹ thuật ra đời khá lâu, nhưng có 1 số bạn vẫn chưa nắm rõ chúng thực sự là gì, tôi sẽ giới thiệu qua 1 vài khái niệm cơ bản. Trong phần sau, ta sẽ xét 1 vài ví dụ cụ thể để hiểu hơn về những tính năng này.

* **Map** (ánh xạ): là hành động *chạy qua* toàn bộ tập dữ liệu và *nhặt ra* những thông tin mà ta cần dùng nhất.
* **Reduce** (tiêu giảm): đối với 1 tập dữ liệu, đôi khi người ta quan tâm đến việc *tổng hợp* chúng lại thành 1 chỉ số duy nhất, **Reduce** giúp xử lý các tác vụ như thế này (**Reduce** có nghĩa là *tiêu giảm*, tức là thay vì phải nhìn và xử lý 1 danh sách rất dài, chúng ta lược bớt đi và chỉ quan tâm đến những thông tin cốt lõi nhất).
* **Filter** (lọc): là hành động so sánh từng giá trị của tập dữ liệu với 1 tiêu chí cụ thể, từ đó lấy ra được 1 danh sách nhỏ hơn, tập trung hơn vào thông tin mà ta muốn. Chức năng này tương đương với **Search** trong 1 vài ngôn ngữ khác.
* **Flat map** (ánh xạ phẳng): đôi khi tập dữ liệu của chúng ta không *bằng phẳng* mà nó bao gồm nhiều tập dữ liệu con, các tập con này lại không có số lượng đều nhau. **Flat map** giúp chúng ta đưa tất cả các dữ liệu trong các tập con về 1 tập duy nhất, từ đó sử dụng được các chức năng **Map**, **Reduce** hay **Filter** một cách dễ dàng.

## 2. Cách sử dụng ##

Xét ví dụ sau: giả sử ta có 1 tập dữ liệu bao gồm các thông tin như thế này:

```swift
// Swift
// "Id", "First name", "Last name", "Title", "Salary"
let records : [[AnyObject]] = [
  [1, "Robert", "Baratheon", "Decreased King", 0],
  [2, "Jofrey", "Baratheon", "King of Westeros", 50000],
  [3, "Tyrion", "Lannister", "Hand of the King", 10000],
  [4, "Eddard", "Stark", "Lord of Winterfell", 9000],
  [5, "Daenerys", "Targaryen", "Mother of Dragons", 8000],
  [6, "Jon", "Snow", "Bastard of Lord Stark", 7000],
  [7, "Cersei", "Lannister", "Queen of Westeros", 8500],
  [8, "Khal", "Drogo", "Khal of Dothraki", 6000],
  [9, "Petyr", "Baelish", "Littlefinger", 7500],
  [10, "Varys", "of Lys", "The Spider", 7500]
]
```

```ruby
## Ruby
records = [
  [1, "Robert", "Baratheon", "Decreased King", 0],
  [2, "Jofrey", "Baratheon", "King of Westeros", 50000],
  [3, "Tyrion", "Lannister", "Hand of the King", 10000],
  [4, "Eddard", "Stark", "Lord of Winterfell", 9000],
  [5, "Daenerys", "Targaryen", "Mother of Dragons", 8000],
  [6, "Jon", "Snow", "Bastard of Lord Stark", 7000],
  [7, "Cersei", "Lannister", "Queen of Westeros", 8500],
  [8, "Khal", "Drogo", "Khal of Dothraki", 6000],
  [9, "Petyr", "Baelish", "Littlefinger", 7500],
  [10, "Varys", "of Lys", "The Spider", 7500]
]
```

Ta gọi là các **records**, mỗi **record** bao gồm 1 mảng các giá trị theo thứ tự đại diện cho **Id**, **First name** (tên), **Last name** (họ), **Title** (chức danh) và **Salary** (lương tháng) của 1 người cụ thể.

### 2.1. Map ###

Đầu tiên, ta cần tính toán xem trong 1 tháng ta phải trả cho tất cả những người này bao nhiêu tiền. Ta dùng hàm `map()` để làm việc này như sau:

```swift
// Swift
let allSalaries = records.map { $0.last as! Int }
print(allSalaries)      // [0, 50000, 10000, 9000, 8000, 7000, 8500, 6000, 7500, 7500]
```

```ruby
## Ruby
all_salaries = records.map {|r| r.last}
puts(all_salaries)      ### [0, 50000, 10000, 9000, 8000, 7000, 8500, 6000, 7500, 7500]
```

Lúc này ta có `allSalaries` là 1 mảng `Int` chứa giá trị tất cả tiền lương trong 1 tháng của từng người. Tất nhiên ta mới chỉ lấy được dữ liệu chứ chưa biết tổng, vì hàm `map()` không có chức năng tính tổng! Ta sẽ biết tổng số lương cần phải trả trong tháng là bao nhiêu ở phần về hàm `reduce()`

### 2.2. Filter ###

Tiếp đến, ta muốn *lọc* ra tất cả những người nhận *nhiều* lương, giả sử là `8000` trở lên, ta có:

```swift
// Swift
let goodPays = records.filter { ($0.last as! Int) >= 8000 }
```

```ruby
## Ruby
good_pays = records.select {|r| r.last >= 8000}
```

Tuy nhiên như thế này thì chỉ có được các **records**, ta sẽ kết hợp với hàm `map()` để lấy ra tên người:

```swift
// Swift
let goodPays = records.filter { ($0.last as! Int) >= 8000 }
let names = goodPays.map { "\($0[1]) \($0[2])" }  // ["Jofrey Baratheon", "Tyrion Lannister", "Eddard Stark", "Daenerys Targaryen", "Cersei Lannister"]
```

```ruby
## Ruby
good_pays = records.select {|r| r.last >= 8000}
names = good_pays.map {|r| "#{r[1]} ##{r[2]}"}     ### ["Jofrey Baratheon", "Tyrion Lannister", "Eddard Stark", "Daenerys Targaryen", "Cersei Lannister"]
```

### 2.3. Reduce ###

Như đã nói ở trên, sau khi `map()`, ta nhận được 1 mảng các giá trị. Nhưng đối với trường hợp đầu tiên là 1 danh sách số tiền mà ta phải trả cho mỗi người hàng tháng, thì ta lại quan tâm thêm đến tổng số tiền. Tất nhiên có 1 cách là sau khi đã có mảng các giá trị đó, ta có thể dùng nhiều cách để tính tổng. **Ruby** có 1 hàm rất hay là `sum()` để tính tổng của 1 mảng các số, nhưng **Swift** thì không. Vậy nên `reduce()` trong **Swift** có giá trị rất lớn.

Thể đơn giản nhất của hàm `reduce()` được dùng như sau:

```swift
// Swift
let allSalaries = records.map { $0.last as! Int }
let totalPays = allSalaries.reduce(0, combine: +)
print(totalPays)        // 113500
```

```ruby
// Swift
all_salaries = records.map {|r| r.last}
total_pays = all_salaries.reduce(:+)
puts(total_pays)        ### 113500
```

Trong **Swift**, khi muốn `reduce()` một mảng, ta cung cấp 1 giá trị khởi tạo và một **closure** ở tham số `combine`, lặp tuần tự:

* Tại bước đầu tiên, hàm `reduce()` sẽ thực hiện tính toán nằm trong **closure** giữa giá trị khởi tạo và giá trị đầu tiên của mảng, lưu lại giá trị vào 1 biến trung gian.
* Từ bước thứ 2 cho đến hết mảng, `reduce()` thực hiện tính toán giữa giá trị trung gian với các phần tử từ thứ 2 trở đi trong mảng.
* Cuối cùng, hàm này trả về giá trị tính toán cuối cùng.

Trong trường hợp này, giá trị khởi tạo là `0`, `combine` là phép `+`, tức là cứ mỗi bước ta lại **cộng** phần tử mảng tại bước đó vào giá trị trung gian. Kết quả cuối cùng là tổng của cả mảng.

Để các bạn nắm rõ hơn từng bước, ta sẽ viết lại hàm này bằng 1 **closure** do ta tự định nghĩa như sau:

```swift
// Swift
let allSalaries = records.map { $0.last as! Int }
let totalPays = allSalaries.reduce(0) { (temp, salary) in
  print("Reduce step: temp = \(temp), salary = \(salary)")
  return temp + salary
}
print("Total pays = \(totalPays)")
```

Khi đó, tại màn hình **Debug**, ta nhận được các dòng in ra như sau:

```shell
Reduce step: temp = 0, salary = 0
Reduce step: temp = 0, salary = 50000
Reduce step: temp = 50000, salary = 10000
Reduce step: temp = 60000, salary = 9000
Reduce step: temp = 69000, salary = 8000
Reduce step: temp = 77000, salary = 7000
Reduce step: temp = 84000, salary = 8500
Reduce step: temp = 92500, salary = 6000
Reduce step: temp = 98500, salary = 7500
Reduce step: temp = 106000, salary = 7500
Total pays = 113500
```

Ta có tổng cộng 10 dòng `Reduce step:`, tại mỗi dòng, biến `salary` là phần tử tại vị trí tương ứng, còn biến `temp` được cập nhật mới, là tổng của phép tính ở trước.

Tương tự, ta cũng có thể sử dụng `combine: +` với mảng các giá trị kiểu **String**:

```swift
// Swift
let goodPayNames = names.reduce("", combine: +)
print(goodPayNames)       // Jofrey BaratheonTyrion LannisterEddard StarkDaenerys TargaryenCersei Lannister
```

```ruby
## Ruby
good_pay_names = names.reduce(:+)
puts(good_pay_names)       // Jofrey BaratheonTyrion LannisterEddard StarkDaenerys TargaryenCersei Lannister
```

Tuy nhiên, giá trị trả về thì bị *dính chữ* (`Jofrey BaratheonTyrion LannisterEddard`), ta cần xử lý kỹ hơn chỗ này 1 chút:

```swift
// Swift
let goodPayNames = names.reduce("") { (temp, name) in
  if temp == "" {
    return name
  } else {
    return temp + ", \(name)"
  }
}
print(goodPayNames)     // Jofrey Baratheon, Tyrion Lannister, Eddard Stark, Daenerys Targaryen, Cersei Lannister
```

```ruby
## Ruby
good_pay_names = names.reduce {|temp, name|
  temp.empty? ? name : temp + ", ##{name}"
}
puts(good_pay_names)    ### Jofrey Baratheon, Tyrion Lannister, Eddard Stark, Daenerys Targaryen, Cersei Lannister
```

Giờ đến yêu cầu phức tạp hơn: ta thấy, trong số 10 người xuất hiện những cặp có cùng họ, ví dụ `Baratheon`, `Lannister`,... Giờ ta sẽ tìm cách để nhóm những ai có cùng họ lại:

```swift
// Swift
let fullNames: [(String, String)] = records.map { ($0[1] as! String, $0[2] as! String) }
let lastNameGroups = fullNames.reduce([String: [String]]()) { (var temp: [String: [String]], fullName) in
  let (firstName, lastName) = fullName
  if temp[lastName] == nil { temp[lastName] = [] }

  temp[lastName]!.append(firstName)
  return temp
}

print(lastNameGroups)   // ["Stark": ["Eddard"], "Lannister": ["Tyrion", "Cersei"], "of Lys": ["Varys"], "Targaryen": ["Daenerys"], "Baratheon": ["Robert", "Jofrey"], "Drogo": ["Khal"], "Snow": ["Jon"], "Baelish": ["Petyr"]]
```

```ruby
## Ruby
full_names = records.map {|r| [r[1], r[2]]}
last_name_groups = full_names.reduce({}) {|temp, full_name|
  first_name, last_name = full_name
  temp[last_name] ||= []
  temp[last_name] << first_name
  temp
}
puts(last_name_groups)  ### {"Baratheon"=>["Robert", "Jofrey"], "Lannister"=>["Tyrion", "Cersei"], "Stark"=>["Eddard"], "Targaryen"=>["Daenerys"], "Snow"=>["Jon"], "Drogo"=>["Khal"], "Baelish"=>["Petyr"], "of Lys"=>["Varys"]}
```

Ở đây có 1 lưu ý: đó là biến `temp` trong **closure** được khai báo sau từ khóa `var`, tức là biến `temp` này có thể thay đổi được trong quá trình tính toán. Bình thường các tham số của hàm & closure trong **Swift** nếu là **value type** (`Int`, `String`, `Array`, `Dictionary`,...) sẽ không thể thay đổi giá trị trong suốt quá trình làm việc. Khai báo `var` cho phép chúng ta thay đổi.

Tuy nhiên kể từ **Swift 3**, chúng ta sẽ không thể dùng từ khóa `var` này nữa:

![Closure var parameter warning][var-param-warning]
{:style="text-align: center"}

Nên ta cần sửa lại như sau:

```swift
// Swift
let lastNameGroups = fullNames.reduce([String: [String]]()) { (temp: [String: [String]], fullName) in
  var temp = temp

  let (firstName, lastName) = fullName
  if temp[lastName] == nil { temp[lastName] = [] }

  temp[lastName]!.append(firstName)
  return temp
}
```

Lúc này ta tạo ra 1 biến **local** cũng tên là `temp`, khác với tham số `temp`, nhưng biến `temp` này có thể thay đổi được giá trị và tiến hành các tính toán như bình thường.

### 2.4. Flat-map ###

Hàm cuối cùng trong series này là `flatMap()`, cách dùng tương đối đơn giản:

```swift
// Swift
let flatRecords = records.flatMap { $0 }
print(flatRecords)  // [1, Robert, Baratheon, Decreased King, 0, 2, Jofrey, Baratheon, King of Westeros, 50000, 3, Tyrion, Lannister, Hand of the King, 10000, 4, Eddard, Stark, Lord of Winterfell, 9000, 5, Daenerys, Targaryen, Mother of Dragons, 8000, 6, Jon, Snow, Bastard of Lord Stark, 7000, 7, Cersei, Lannister, Queen of Westeros, 8500, 8, Khal, Drogo, Khal of Dothraki, 6000, 9, Petyr, Baelish, Littlefinger, 7500, 10, Varys, of Lys, The Spider, 7500]
```

```ruby
## Ruby
flat_records = records.flatten
puts(flat_records)  ### [1, "Robert", "Baratheon", "Decreased King", 0, 2, "Jofrey", "Baratheon", "King of Westeros", 50000, 3, "Tyrion", "Lannister", "Hand of the King", 10000, 4, "Eddard", "Stark", "Lord of Winterfell", 9000, 5, "Daenerys", "Targaryen", "Mother of Dragons", 8000, 6, "Jon", "Snow", "Bastard of Lord Stark", 7000, 7, "Cersei", "Lannister", "Queen of Westeros", 8500, 8, "Khal", "Drogo", "Khal of Dothraki", 6000, 9, "Petyr", "Baelish", "Littlefinger", 7500, 10, "Varys", "of Lys", "The Spider", 7500]
```

Các bạn có thể tải về file [MapReduce.playground & map_reduce.rb][attachment] để cùng xem các ví dụ về **Map-Reduce** đã trình bày trong bài.

[var-param-warning]:      /assets/media/posts/swift/2016-07-15-closure-var-param-warning.png
[attachment]:             /assets/downloads/swift/2016-07-15-MapReduce.zip
