---
layout: article
title: Tự tạo một Blog Lập trình với Jekyll & Github Pages
description: Hướng dẫn tạo blog dành cho lập trình viên bằng một cách đơn giản bằng Jekyll & publish lên Github Pages
date: 2016-06-28 13:27:00 +0700
categories: [misc]
tags: [blog, jekyll, github, web]
comments: true
redirect_from:
  - /tutorials/2016/06/28/create-blog-with-jekyll
---

Có nhiều cách để làm ra một blog: **Wordpress**, **Blogspot**, **Joomla**,... Đối với 1 lập trình viên, không gì đẹp đẽ hơn 1 blog đơn giản, chú trọng vào nội dung và dễ dàng quản trị thông qua **git repository** của mình. **Jekyll** - **Github Pages** & **Custom domain** là cách đơn giản nhất.

*(Tất nhiên bạn hoàn toàn có thể tự code cho mình 1 trang blog không cần theo chuẩn nào cả, bài này chỉ đề cập đến việc sử dụng những công cụ có sẵn để làm ra 1 trang blog nhanh - đẹp - hiệu quả)*

## 1. Github là gì? ##

**Github** = **Git** (công cụ quản lý mã nguồn) + **Hub** (một địa điểm đông người qua lại, thường có các siêu thị, trung tâm mua sắm) là nền tảng cho phép các lập trình viên lưu trữ toàn bộ code của mình theo project, vào từng **kho** gọi là **repository**.

Github sử dụng `git` làm công cụ quản lý mã nguồn. Khác với `svn` ra đời từ cách đó khá lâu, lạc hậu và khó dùng, `git` tỏ ra mạnh mẽ, thân thiện và tiện lợi hơn rất nhiều.

## 2. Jekyll là gì? ##

**Jekyll** là công cụ dùng để sinh ra các trang web tĩnh (**HTML**, **Javascript** & **CSS**) từ các file được viết theo cấu trúc gọi là `markup`. Có nhiều loại `markup`: `markdown`, `textile`, hoặc `HTML` chính là 1 `markup` phổ biến nhất. Tùy từng trường hợp mà chúng ta sử dụng cái nào cho phù hợp. Do **Github** sử dụng `markdown` (dưới 1 dạng được custom lại mà họ gọi là **GFM** - Github Flavored Markdown), nên chúng ta sẽ sử dụng `markdown` làm `markup` cho các bài viết trên blog của mình.

Ngoài ra, **Jekyll** cũng là 1 công cụ gọi là *blog aware*, tức là chỉ cần làm theo cấu trúc của 1 trang blog (tuân theo các quy tắc đặt tiêu đề, thời gian & thư mục) là **Jekyll** sẽ tự động sinh ra các bài blog theo thứ tự thời gian cho chúng ta.

## 3. Cần chuẩn bị gì? ##

Do **Jekyll** được **Github** tích hợp rất sâu, nên chúng ta sẽ sử dụng luôn 1 tính năng tên là **Github Pages** để lưu trữ & phân phối các bài viết của mình

Để làm ra 1 Blog theo kiểu này, chúng ta cần 2 điều kiện chính:

### 3.1. Tài khoản Github ###

Một tài khoản **[Github][github-homepage]** còn hoạt động được. Đối với những ai chưa quen dùng **Github**, cần đọc qua series **[Hướng dẫn của Github][github-help]** trước

Tại **Github**, ta tạo 1 repository mới, giả sử tên là `my-blog`, `clone` về máy của mình bằng dòng lệnh

```shell
$ git clone git@github.com:<username>/my-blog.git
```

Trong đó `<username>` là tên tài khoản của bạn trên **Github**

### 3.2. Cài đặt Jekyll ###

Đầu tiên là **Ruby**, phiên bản ổn định nhất hiện tại là 2.2.4. Đối với các bạn dùng Mac OS thì đã có sẵn Ruby rồi, nhưng là phiên bản 1.9.x. Tốt nhất nên cài qua **[RVM][rvm-io]**

Sau khi đã có **Ruby**, ta cần cài đặt 1 `gem` có tên là `bundler`. (**Gem** là các bộ thư viện được cộng đồng viết cho **Ruby**)

```shell
$ gem install bundler
```

Sau khi đã `clone` repository `my-blog` từ Github & cài đặt `bundler` thành công, ta tạo 1 file có tên `Gemfile` trong thư mục `my-blog`. `Gemfile` là cách mà **Ruby** quản lý các `gems` của project.

```shell
$ touch Gemfile
```

Trong `Gemfile`, chúng ta khai báo các `gems` cần dùng với Jekyll

```ruby
source 'https://rubygems.org'

group :jekyll_plugins do
  gem 'github-pages', '~> 84'
  gem 'jekyll-paginate', '~> 1.1'
end
```

Trong **Terminal** ta gọi `bundle` để cài đặt các `gems` đã khai báo trong `Gemfile`

```shell
$ bundle
```

## 4. Sử dụng custom theme ##

Cộng đồng lập trình viên ưa thích **Jekyll** đã tạo ra rất nhiều bộ theme đẹp, tiện dụng và public lên các trang chia sẻ theme của **Jekyll** (tính năng này giống với **Wordpress** hay **Joomla**). Một trong các trang tập hợp các theme đẹp là **JekyllThemes.io**

Sau khi chọn được 1 theme ưng ý, các bạn download và giải nén vào thư mục `my-blog` của mình. *Chú ý:* cần phải giải nén toàn bộ nội dung vào thư mục gốc `my-blog`, dễ nhận thấy nhất là có file `_config.yml`, đây là file chứa các cài đặt gốc của blog viết bằng **Jekyll**

## 5. Viết post bằng Jekyll ##

Các bài post của chúng ta sẽ được viết bằng `markdown`, sử dụng các cú pháp **kramdown**

Các bài blog được đặt trong thư mục `_posts`, có cú pháp đặt tên theo dạng `yyyy-mm-dd-<post-name>.markdown`, trong đó

* `yyyy`: năm bài viết, dưới dạng 4 chữ số
* `mm`: tháng bài viết, 2 chữ số
* `dd`: ngày bài viết, 2 chữ số
* `<post-name>`: tên bài viết, chứa các ký tự chữ và số, không nên chứa các ký tự tiếng Việt có dấu

Sau khi có bài viết bằng `markdown`, chạy lệnh `serve` để xem được bài viết

```shell
$ jekyll serve
```

Lúc này, toàn bộ blog sẽ truy cập được thông qua địa chỉ `localhost:4000` hoặc `127.0.0.1:4000`

## 6. Deploy lên Github Pages ##

**Github** cung cấp cơ chế **Github Pages**, thông qua đó giúp người dùng publish các trang web tĩnh (**HTML**, **Javascript** & **CSS**) tại địa chỉ `https://<username>.github.io/<repo-name>`. Ở đây, `<repo-name>` chính là `my-blog`

Để deploy được lên **Github Pages**, tại Terminal, ta `commit` các thay đổi và `checkout` sang branch mới tên là `gh-pages`:

```shell
## In master branch
$ git checkout -b gh-pages

## In gh-pages branch
$ git push -u origin gh-pages
```

Tại các lần sau, khi viết bài mới, ta vẫn làm việc ở `master`, nhưng khi muốn deploy thì `merge` các thay đổi vào `gh-pages` và `push` lên:

```shell
## In master branch
$ git checkout gh-pages

## In gh-pages branch
$ git merge master
$ git push origin gh-pages
```

Lúc này, các thay đổi sẽ được cập nhật lên trang `https://<username>.github.io/<repo-name>`

**Lưu ý:** để sử dụng trang `https://<username>.github.io` (không có phần `<repo-name>` ở đằng sau), chúng ta cần tạo 1 repo có tên là `<username>.github.io` trên **Github** và thao tác giống như project `my-blog` ở trên.

## Cập nhật ##

### [2016-06-30] ###

* Để dùng được gem `jekyll-sitemap` thì cần phải có gem `github-pages`. [Xem chi tiết][github-sitemap]
* [Link hay][jekyll-seo] để config SEO cho Jekyll

### [2016-08-01] ###

* Tại Terminal, nếu chỉ gọi `jekyll serve` thì có thể gặp lỗi `GitHub Metadata: No GitHub API authentication could be found. Some fields may be missing or have incorrect data.`. Lỗi này xảy ra do server tại local của ta không có biến môi trường `$JEKYLL_GITHUB_TOKEN`. Để không gặp lỗi này nữa, ta chạy lệnh sau:

```shell
$ JEKYLL_GITHUB_TOKEN=jkghtoken jekyll serve
```

Trong đó `jkghtoken` là 1 chuỗi bất kỳ, thế nào cũng được.

[github-homepage]:  https://github.com/
{:rel="nofollow"}

[github-help]:      https://help.github.com/articles/set-up-git/
{:rel="nofollow"}

[rvm-io]:           https://rvm.io
{:rel="nofollow"}

[github-sitemap]:   https://help.github.com/articles/sitemaps-for-github-pages/
{:rel="nofollow"}

[jekyll-seo]:       http://vdaubry.github.io/2014/10/21/SEO-for-your-Jekyll-blog/
{:rel="nofollow"}
