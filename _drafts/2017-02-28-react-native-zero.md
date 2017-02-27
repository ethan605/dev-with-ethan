---
layout: article
title: "Khởi tạo project React Native với 'Zero' (P1)"
description: "Giới thiệu về react-native-zero, bộ công cụ dùng để khởi tạo 1 project React Native nhanh - gọn - sạch sẽ."
date: 2017-02-28 10:00:00 +0700
categories: [react-native]
tags: [react-native, template, boilerplate]
comments: true
instant_title: Khởi tạo project React Native với 'Zero' (P1)
instant_kicker: React Native
---

Hơn 6 tháng kể từ bài viết cuối cùng được đăng (15/8/2016), mình tập trung phát triển 1 dự án hoàn toàn "mới", từ ý tưởng, công nghệ cho tới địa điểm, thời gian làm việc. Thông thường sau 1 thời gian lăn lộn với 1 bộ công nghệ nào đó, mình sẽ đúc kết lại những kinh nghiệm và kỹ năng vào 1 project mang tính thực hành & có thể dùng lại (reusable) cao, ví dụ như:

* **[UIPhotoGallery][]**: viết bằng Objective-C, sau 1 thời gian phải xử lý các dạng gallery ảnh hoàn toàn thủ công, trong khi các bộ thư viện đình đám hồi đó thì quá to & gần như rất khó để customize 1 mảng nhỏ như thế này.
* **[RubifiedSwift][]**: viết bằng Swift, cũng là sau 1 thời gian phải chuyển từ Objective-C sang Swift `2.2` (bây giờ đã là Swift `3.x`). Nhiều người nói Swift giống Ruby, mình cũng thấy thế, nhưng Ruby thì có nhiều hàm built-in dùng để xử lý chuỗi (String), mảng (Array) & các kiểu dữ liệu key-value (Hash) hay hơn nhiều. Thế là mình port tất cả các hàm nào hay từ Ruby sang Swift.
* Ngoài ra còn 1 vài project lẻ tẻ không được đầu tư nhiều công sức, coi như là nháp (xem thêm tại **[GitHub repo][github-repo]**)

Lần này cũng vậy, 6 tháng vừa rồi làm việc với **[React Native][react-native]** để lại nhiều bài học thú vị. Đây là 1 framework rất hứa hẹn, ở nhiều điểm: team khủng chống lưng (Facebook), giải được bài toán mà các công nghệ cross-platform & hybrid mắc phải (hiệu năng trên các thiết bị Android), sử dụng Javascript thuần tuý (không vướng thêm cả HTML & CSS vào), cộng đồng phát triển nhanh & chất lượng cao,... Nói chung 1 tương lai viết ứng dụng đa nền tảng sử dụng React Native là rất rộng mở.

Vấn đề là nên tổng kết lại dưới dạng nào? Một bộ giao diện như **UIPhotoGallery** thì quá nhiều người đã [làm tốt hơn][js-coach] rồi. Về các công cụ dạng utility, đã có [Lodash][] (thật sự thư viện này rất tuyệt vời ở tính **functional** của nó!).

Vừa hay mình đang cần khởi tạo phiên bản `2.0` dự án đang phát triển ([WeFit][]). Có rất nhiều vấn đề tồn tại ở bản `1.0` mà mình không muốn lặp lại ở bản mới này. Vậy nên mình làm ra **[react-native-zero][]**. Document (bằng tiếng Anh) đã có sẵn trong README của project (và sẽ cố gắng cập nhật khi có tính năng mới!). Bài blog này chủ yếu dùng để chia sẻ các vấn đề mà mình tâm đắc với dự án này.

[UIPhotoGallery]:             https://github.com/ethan605/UIPhotoGallery
[RubifiedSwift]:              https://github.com/ethan605/RubifiedSwift
[github-repo]:                https://github.com/ethan605?tab=repositories
[react-native]:               https://facebook.github.io/react-native/
[js-coach]:                   https://js.coach
[Lodash]:                     https://lodash.com
[WeFit]:                      https://wefit.vn
[react-native-zero]:          https://github.com/ethan605/react-native-zero
