---
title: Tự tạo một Blog Lập trình với Jekyll & Github Pages
date: 2016-06-28 6:27:00
description: "Hướng dẫn tạo blog dành cho lập trình viên bằng một cách đơn giản bằng Jekyll & publish lên Github Pages"
---

Có nhiều cách để làm ra một blog: `Wordpress`, `Blogspot`, `Joomla`,... Đối với 1 lập trình viên, không gì đơn giản và đẹp đẽ hơn 1 blog đơn giản, chú trọng vào nội dung và dễ dàng quản trị thông qua `git` repository của mình. **Jekyll** - **Github Pages** & **Custom domain** là cách đơn giản nhất.

*(Tất nhiên bạn hoàn toàn có thể tự code cho mình 1 trang blog không cần theo chuẩn nào cả, bài này chỉ đề cập đến việc sử dụng những công cụ có sẵn để làm ra 1 trang blog nhanh - đẹp - hiệu quả)*

# Chuẩn bị #

1. Đăng ký tài khoản **[Github][github-homepage]**
2. Ruby 2.2.4, tốt nhất là cài qua **[RVM][rvm-io]**

{% highlight shell %}
gem install jekyll
{% endhighlight %}

[github-homepage]:  https://github.com/
[rvm-io]:           https://rvm.io
