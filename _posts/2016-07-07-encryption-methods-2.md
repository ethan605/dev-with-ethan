---
layout: post
title: "Cryptography: Sử dụng các thuật toán mã hóa phổ biến trong Ruby"
description: "Dùng Ruby để mã hóa / giải mã thông điệp bằng các thuật toán phổ biến: AES, RSA, MD5, SHA"
date: 2016-07-07 17:00:00 +0700
categories: [misc]
tags: [cryptopgraphy, encryption, 'mã hóa', symmetric, 'đối xứng', asymmetric, 'bất đối xứng', hash, 'hàm băm', md5, sha, aes, digest]
comments: true
---

*... tiếp theo bài viết [Cryptography: Các phương pháp mã hóa thường dùng]({% post_url 2016-07-06-encryption-methods-1 %})*

Như đã nói trong bài trước, **Mã hóa** là 1 lĩnh vực quan trọng và thú vị. Rất nhiều nhà khoa học lỗi lạc đã dành cả đời mình nghiên cứu **Mã hóa** và đưa ra nhiều thuật toán có ý nghĩa lớn với toàn bộ nền **Khoa học Máy tính** nói chung. Trong bài này, tôi sẽ đưa ra 1 vài ví dụ về những thuật toán phổ biến, có thể dễ dàng cài đặt và sử dụng bằng Ruby. Một khi đã nắm vững cách sử dụng, các bạn có thể tiếp cận sử dụng với các bộ thư viện tương tự trong các ngôn ngữ khác 1 cách dễ dàng.

# 3. Mã hóa đối xứng #

Có nhiều thuật toán **Mã hóa đối xứng** được nghiên cứu và phát triển, như  Twofish, Serpent, AES, Blowfish, CAST5, Grasshopper, RC4, 3DES, Skipjack, Safer+/++, IDEA,... Nói chung mỗi thuật toán đều phục vụ cho 1 mục đích khác nhau, và do đều sử dụng phương pháp **Mã hóa đối xứng** nên chúng đều có các ưu điểm và nhược điểm như đã nói ở phần trước, chỉ khác nhau ở độ phức tạp của mã khóa: càng phức tạp thì càng mất nhiều thời gian tính toán nhưng càng khó bẻ khóa.

Tôi thường dùng AES trong các bài toán cần **Mã hóa đối xứng**, vì nó đủ mạnh và dễ làm việc.

## 3.1. Thuật toán AES ##

**AES** là viết tắt của **Advanced Encryption Standard**, có tên gốc là **Rijndael**, kết hợp từ họ của 2 nhà khoa học Bỉ phát minh ra thuật toán này là Joan Daemen & Vincent Rijmen.

**AES** dựa trên 2 yếu tố là `block` và `key`, trong đó `block` có độ dài cố định 128 bit, còn `key` có thể nhận các độ dài 128, 192 hoặc 256 bit.

Có rất nhiều bài viết trên mạng giải thích tường tận về thuật toán này, vậy nên ở đây ta sẽ không đi sâu vào nó. Chỉ cần biết rằng cho tới nay, AES mới bị tấn công 1 lần và được nhiều tổ chức sử dụng để mã hóa do tính an toàn của nó.

## 3.2. Sử dụng AES trong Ruby ##

### 3.2.1. Mã hóa ###

Trong **Ruby**, chúng ta dùng **AES** thông qua bộ thư viện `OpenSSL::Cipher` (nằm trong `stdlib`).

Để sử dụng AES trong Ruby, ta cần 2 tham số:

* **key size** (độ lớn của `key`): nhận các giá trị 128, 192 hoặc 256 bit
* **block cipher mode**: trong các thuật toán mã hóa sử dụng `block`, cần chỉ rõ ta muốn sử dụng chế độ nào để thao tác trên `block` đó. Các chế độ thường dùng bao gồm:
    - Electronic Codebook (ECB)
    - Cipher Block Chaining (CBC)
    - Propagating Cipher Block Chaining (PCBC)
    - Cipher Feedback (CFB)
    - Output Feedback (OFB)
    - Counter (CTR)

Ta sẽ dùng `key` có độ dài 256 (phức tạp nhất) và `block` có chế độ `CBC`:

```ruby
cipher = OpenSSL::Cipher::AES.new(256, :CBC)
```

Sau khi khởi tạo `cipher` (có nghĩa là *mật mã*), ta cần khai báo `cipher` này dùng để *mã hóa* (*encrypt*) hay *giải mã* (*decrypt*):

```ruby
cipher.encrypt      # for encryption
cipher.decrypt      # for decryption
```

Đối với các chế độ `CBC`, `CFB`, `OFB` hay `CTR`, ta cần thêm 1 tham số gọi là `iv` (viết tắt của **initialization vector**). Chỉ duy nhất `ECB` là không sử dụng `iv`, vậy nên theo các chuyên gia, không nên sử dụng chế độ `ECB` trừ khi thật sự rất cần đến nó.

Chúng ta có thể đặt `key` và `iv` của `cipher` bằng 1 **String** mà chúng ta muốn. Lưu ý là `iv` luôn có độ dài `16` ký tự (vì `16 * 8 = 128 bit`) còn `key` thì có các độ dài `16`, `24`, `32` tương ứng với `128`, `192` hoặc `256` bit:

```ruby
cipher.key = "secretkey@dev.ethanify.me(c)2016"         # 32 bytes = 256 bits
cipher.iv = "secret_iv(c)2016"                          # 16 bytes = 128 bits
```

hoặc để cho `cipher` tự sinh ngẫu nhiên:

```ruby
key = cipher.random_key             # "Lf\xE7 \xE3bK\x82\xA9\b\x1D\xFE){\x7F\xB9\x94\x9D\xBDc\x99\xBB\x0E\x15B@\xB9\xBE \xC31d"
iv = cipher.random_iv               # "\x96\x86\x93QR\xBE\x00\b\xC9\x90\x18\xF0H\xFB]\f"
```

**AES** trong **Ruby** cho phép ta chèn thêm nội dung vào đoạn thông điệp mã hóa bằng hàm `update()` và chỉ tính toán giá trị cuối cùng khi gọi hàm `final()`

```ruby
encrypted_content = cipher.update("Mã hóa đối xứng")
encrypted_content << cipher.update(" bằng thuật toán AES-256")
encrypted_content << cipher.final
```

Lúc này, `encrypted_content` chứa thông tin mã hóa của chuỗi `"Mã hóa đối xứng bằng thuật toán AES-256"`, nhưng ở dạng các **hexcode**. Đây là do trong quá trình mã hóa / giải mã, **AES** làm việc với các data thô ở dạng binary, chứ không phải **String**, vậy nên thông tin này sẽ khó đọc và thường là khó truyền đi qua Internet (dễ mất mát).

Có 1 cách đơn giản là chúng ta sẽ *encode* toàn bộ các dữ liệu thô này về dạng **Base64**. Về bản chất, **Base64** không mã hóa thông tin phức tạp như **AES**, mà chỉ tìm cách *biểu diễn* các giá trị dạng binary về dạng **String** dễ đọc bằng các ký tự chữ & số:

```ruby
encrypted_base64 = Base64.encode64(encrypted_content) # "DVM+VfhAppOtvolyq9WWhFs7AT7skg5RpsN5YVZs33J5Wr/7nUb1IEFPSfeK\n6UGCsDpN1jQbhwayk4gXiEtUgw==\n"
```

### 3.2.2. Giải mã ###

Để giải mã, ta làm các bước tương tự như khi mã hóa, nhưng với mục đích ngược lại. Có 1 chú ý là, vì đây là **Mã hóa đối xứng**, nên `key` và `iv` để giải mã phải giống hoàn toàn `key` và `iv` khi mã hóa.

```ruby
decipher = OpenSSL::Cipher::AES.new(256, :CBC)
decipher.decrypt

decipher.key = "secretkey@dev.ethanify.me(c)2016"
decipher.iv = "secret_iv(c)2016"
```

Cũng giống như khi mã hóa, giải mã bằng **AES** cũng có thể thực hiện từng phần bằng hàm `update()` và kết thúc bằng `final()`:

```ruby
decrypted_content = decipher.update(encrypted_content)
decrypted_content << decipher.final
```

Nếu sử dụng **Base64**, ta cần *decode* dữ liệu biểu diễn bằng **Base64** trước:

```ruby
encrypted_data = Base64.decode64(encrypted_base64)

decrypted_content = decipher.update(encrypted_data)
decrypted_content << decipher.final         # Mã hóa đối xứng bằng thuật toán AES-256
```

# 4. Mã hóa bất đối xứng #

## 4.1. Thuật toán RSA ##

## 4.2. Sử dụng RSA trong Ruby ##

# 5. Mã hóa bằng hàm băm trong Ruby #

## 5.1. Thuật toán MD5 ##

## 5.2. Thuật toán SHA ##