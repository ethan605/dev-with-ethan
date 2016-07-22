---
layout: post
title: "[Swift] Làm việc với các tập dữ liệu hiệu quả hơn với Map-Reduce"
description: "Ý nghĩa và cách sử dụng của các hàm `map()`, `reduce()`, `filter()` & `flatMap()` trong Swift (có đối chiếu với các hàm tương ứng trong Ruby)"
date: 2016-07-15 12:39:00 +0700
categories: [swift]
tags: [array, dictionary, map, reduce, filter, flat, ruby, 'tập dữ liệu']
comments: true
---

Trong các ứng dụng ngày nay, việc xử lý những tập dữ liệu lớn càng ngày càng trở thành 1 bài toán quan trọng. Không cần phải làm việc với các bảng dữ liệu hàng triệu bản ghi, chỉ cần xử lý 1 **Array** và **Dictionary** làm sao cho hiệu quả cũng là 1 vấn đề đau đầu. **Swift**, giống như những ngôn ngữ hiện đại khác, đưa vào các khái niệm **Map-Reduce** nhằm cung cấp cho các Lập trình viên một bộ thư viện linh hoạt, dễ sử dụng và mạnh mẽ.

Do **Swift** kế thừa rất nhiều triết lý của **Ruby**, và bản thân tôi cũng là người yêu cái đẹp của ngôn ngữ này, nên trong bài viết sẽ trình bày các tính năng **Map-Reduce** trong cả 2 ngôn ngữ để bạn đọc cùng theo dõi.

# 1. Map-Reduce là gì? #

Tuy đây là 1 kỹ thuật ra đời khá lâu, nhưng có 1 số bạn vẫn chưa nắm rõ chúng thực sự là gì, tôi sẽ giới thiệu qua 1 vài khái niệm cơ bản. Trong phần sau, ta sẽ xét 1 vài ví dụ cụ thể để hiểu hơn về những tính năng này.

* **Map** (ánh xạ): là hành động *chạy qua* toàn bộ tập dữ liệu và *nhặt ra* những thông tin mà ta cần dùng nhất.
* **Reduce** (tiêu giảm): đối với 1 tập dữ liệu, đôi khi người ta quan tâm đến việc *tổng hợp* chúng lại thành 1 chỉ số duy nhất, **Reduce** giúp xử lý các tác vụ như thế này (**Reduce** có nghĩa là *tiêu giảm*, tức là thay vì phải nhìn và xử lý 1 danh sách rất dài, chúng ta lược bớt đi và chỉ quan tâm đến những thông tin cốt lõi nhất).
* **Filter** (lọc): là hành động so sánh từng giá trị của tập dữ liệu với 1 tiêu chí cụ thể, từ đó lấy ra được 1 danh sách nhỏ hơn, tập trung hơn vào thông tin mà ta muốn. Chức năng này tương đương với **Search** trong 1 vài ngôn ngữ khác.
* **Flat map** (ánh xạ phẳng): đôi khi tập dữ liệu của chúng ta không *bằng phẳng* mà nó bao gồm nhiều tập dữ liệu con, các tập con này lại không có số lượng đều nhau. **Flat map** giúp chúng ta đưa tất cả các dữ liệu trong các tập con về 1 tập duy nhất, từ đó sử dụng được các chức năng **Map**, **Reduce** hay **Filter** một cách dễ dàng.

# 2. Cách sử dụng #
