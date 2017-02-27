---
layout: article
title: "Khởi tạo project React Native với 'Zero'"
description: "Giới thiệu về react-native-zero, bộ công cụ dùng để khởi tạo 1 project React Native nhanh - gọn - sạch."
date: 2017-02-27 10:00:00 +0700
categories: [react-native]
tags: [react-native, template, boilerplate]
comments: true
instant_title: Khởi tạo project React Native với 'Zero'
instant_kicker: React Native
---

Hơn 6 tháng kể từ bài viết cuối cùng được đăng (15/8/2016), mình tập trung phát triển 1 dự án hoàn toàn "mới", từ ý tưởng, công nghệ cho tới địa điểm, thời gian làm việc. Thông thường sau 1 thời gian lăn lộn với 1 bộ công nghệ nào đó, mình sẽ đúc kết lại những kinh nghiệm và kỹ năng vào 1 project mang tính thực hành & có thể dùng lại (reusable) cao, ví dụ như:

* **[UIPhotoGallery][]**: viết bằng Objective-C, sau 1 thời gian phải xử lý các dạng gallery ảnh hoàn toàn thủ công, trong khi các bộ thư viện đình đám hồi đó thì quá to & gần như rất khó để customize 1 mảng nhỏ như thế này.
* **[RubifiedSwift][]**: viết bằng Swift, cũng là sau 1 thời gian phải chuyển từ Objective-C sang Swift 2.2 (bây giờ đã là Swift 3.x). Nhiều người nói Swift giống Ruby, mình cũng thấy thế, nhưng Ruby thì có nhiều hàm built-in dùng để xử lý chuỗi (String), mảng (Array) & các kiểu dữ liệu key-value (Hash) hay hơn nhiều. Thế là mình port tất cả các hàm nào hay từ Ruby sang Swift.
* Ngoài ra còn 1 vài project lẻ tẻ không được đầu tư nhiều công sức, coi như là nháp (xem thêm tại **[GitHub repo](github-repo)**)

[UIPhotoGallery]:             https://github.com/ethan605/UIPhotoGallery
[RubifiedSwift]:              https://github.com/ethan605/RubifiedSwift
[github-repo]:                https://github.com/ethan605?tab=repositories