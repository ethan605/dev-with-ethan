---
layout: article
title: "[Swift] Bộ thư viện RubifiedSwift với CocoaPods"
description: "Viết code Swift theo phong cách Ruby, dành cho Rubists"
date: 2016-07-22 11:30:00 +0700
categories: [swift]
tags: [swift, ruby, cocoapods, 'thư viện']
comments: true
redirect_from:
  - /misc/rubified-swift-created
---

***[RubifiedSwift][]*** *là bộ thư viện viết ra nhằm cung cấp các APIs cho lập trình viên Swift để làm việc hiệu quả hơn trên các kiểu dữ liệu phổ biến như Int, Double, String, Array, Dictionary,..., nhưng đặc biệt ở chỗ là nó sẽ sử dụng các ký pháp và phong cách viết hàm của Ruby, như một món quà dành cho những người yêu thích cả 2 ngôn ngữ lập trình này.*

Tính đến thời điểm hiện tại, mình đã làm việc với **iOS** được hơn 4 năm và **Ruby** (on Rails) hơn 3 năm. Bắt đầu với **iOS** thì tất nhiên là gắn bó với **Objective-C** 1 thời gian dài, và đến giờ là **Swift**. Trước khi đến với **Ruby** thì cũng đã thử qua cả **PHP** lẫn **Python**. Nhưng rốt cục không cái nào trụ được quá 3 tháng. Công ty hồi đó (công ty đầu tiên, làm từ lúc thực tập -> part-time cho đến full-time) thì toàn các cao thủ về **Ruby on Rails**, nên tuy không làm về mảng này nhưng cũng lân la học mót được 1 ít.

Cuối cùng, sau thời gian đủ dài, làm việc đủ lâu và tích lũy đủ nhiều, mình vẫn thích và mong muốn gắn bó với **Ruby**, do nó đẹp, tiện và vẫn còn rất nhiều thứ mình chưa biết hết. **Swift** thì lại khác, mới mẻ, là luồng gió mới cho cộng đồng lập trình iOS vốn đau đầu nhức óc nhiều với **Objective-C**.

Vậy nên giờ mình quyết định sẽ làm 1 cái gì đó cho cả 2 thứ mà mình thích: viết & duy trì 1 bộ thư viện bằng **Cocoapods**. Vì sao lại làm việc này?

* Đây không phải là lần đầu tiên mình viết thư viện cho **Cocoapods**. Cách đây khoảng 2 năm, sau 1 thời gian lăn lộn đủ nhiều với `UIScrollView` nhưng không tìm thấy 1 bộ thư viện nào đủ nhẹ nhàng mà vẫn đáp ứng được các nhu cầu, mình viết ra **[UIPhotoGallery][]**. Nhưng công việc hồi đó bận nhiều + mục tiêu của bộ thư viện này là đúc kết lại những cái mà mình đã học được, nên hơi lười maintain. May mắn là nó được nhiều người ủng hộ, cũng coi như 1 niềm vui.
* **Swift** là 1 ngôn ngữ đẹp theo nhiều nghĩa. Nhưng so với **Ruby** thì nó vẫn còn rất thô ráp. Nhiều APIs của **Swift** làm việc rất hiệu quả, nhưng nhìn chung vẫn thiếu nhiều so với **Ruby**. Nếu tính cả **Rails** thì còn kém nữa, nhưng không phải ai cũng thích **Rails**, nên mình vẫn nhắm tới **Ruby** là phần lớn.

Ngoài ra, đây cũng là 1 cách thức để tự răn mình 2 việc:
* Đối với **Swift** và **iOS**, vẫn còn rất nhiều cái ***phải học*** & ***phải hiểu***.
* Làm ra 1 bộ thư viện là rất khó, nhưng để maintain nó còn khó hơn. Liệu mình có thể kiên trì với nó như **[Matt Thompson][]** & đồng sự đã làm với **AFNetworking** & bây giờ là **Alamofire** hay không?

Dự kiến mình sẽ mất khoảng 1 tuần để làm việc với bộ thư viện này & public nó lên **Cocoapods**, nên trong thời gian này sẽ không viết bài nào mới.

***Cập nhật (29/07/2016):*** bộ thư viện đã lên **Cocoapods** với phiên bản **[0.9.2][Pod]**

[RubifiedSwift]:            https://github.com/ethan605/RubifiedSwift
{:rel="nofollow"}

[UIPhotoGallery]:           https://github.com/ethan605/UIPhotoGallery
{:rel="nofollow"}

[Matt Thompson]:            https://twitter.com/mattt
{:rel="nofollow"}

[Pod]:                      https://cocoapods.org/pods/RubifiedSwift
{:rel="nofollow"}
