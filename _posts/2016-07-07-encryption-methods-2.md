---
layout: article
title: "Cryptography: Sử dụng các thuật toán mã hóa phổ biến trong Ruby"
description: "Dùng Ruby để mã hóa / giải mã thông điệp bằng các thuật toán phổ biến: AES, RSA, MD5, SHA"
date: 2016-07-07 17:00:00 +0700
categories: [misc]
tags: [cryptopgraphy, encryption, 'mã hóa', symmetric, 'đối xứng', asymmetric, 'bất đối xứng', hash, 'hàm băm', md5, sha, aes, digest, ruby]
comments: true
instant_title: Dùng Ruby để viết các thuật toán mã hóa phổ biến
instant_kicker: Thế giới Công nghệ
---

*... tiếp theo bài viết [Cryptography: Các phương pháp mã hóa thường dùng][part-1]*

Như đã nói trong bài trước, **Mã hóa** là 1 lĩnh vực quan trọng và thú vị. Rất nhiều nhà khoa học lỗi lạc đã dành cả đời mình nghiên cứu **Mã hóa** và đưa ra nhiều thuật toán có ý nghĩa lớn với toàn bộ nền **Khoa học Máy tính** nói chung. Trong bài này, tôi sẽ đưa ra 1 vài ví dụ về những thuật toán phổ biến, có thể dễ dàng cài đặt và sử dụng bằng Ruby. Một khi đã nắm vững cách sử dụng, các bạn có thể tiếp cận sử dụng với các bộ thư viện tương tự trong các ngôn ngữ khác 1 cách dễ dàng.

## 3. Mã hóa đối xứng ##

Có nhiều thuật toán **Mã hóa đối xứng** được nghiên cứu và phát triển, như  Twofish, Serpent, AES, Blowfish, CAST5, Grasshopper, RC4, 3DES, Skipjack, Safer+/++, IDEA,... Nói chung mỗi thuật toán đều phục vụ cho 1 mục đích khác nhau, và do đều sử dụng phương pháp **Mã hóa đối xứng** nên chúng đều có các ưu điểm và nhược điểm như đã nói ở phần trước, chỉ khác nhau ở độ phức tạp của mã khóa: càng phức tạp thì càng mất nhiều thời gian tính toán nhưng càng khó bẻ khóa.

Tôi thường dùng AES trong các bài toán cần **Mã hóa đối xứng**, vì nó đủ mạnh và dễ làm việc.

### 3.1. Thuật toán AES ###

**AES** là viết tắt của **Advanced Encryption Standard**, có tên gốc là **Rijndael**, kết hợp từ họ của 2 nhà khoa học Bỉ phát minh ra thuật toán này là Joan Daemen & Vincent Rijmen.

**AES** dựa trên 2 yếu tố là `block` và `key`, trong đó `block` có độ dài cố định 128 bit, còn `key` có thể nhận các độ dài 128, 192 hoặc 256 bit.

Có rất nhiều bài viết trên mạng giải thích tường tận về thuật toán này, vậy nên ở đây ta sẽ không đi sâu vào nó. Chỉ cần biết rằng cho tới nay, AES mới bị tấn công 1 lần và được nhiều tổ chức sử dụng để mã hóa do tính an toàn của nó.

### 3.2. Sử dụng AES trong Ruby ###

#### 3.2.1. Mã hóa ####

Trong **Ruby**, chúng ta dùng **AES** thông qua bộ thư viện `OpenSSL::Cipher` (nằm trong `stdlib`).

Để sử dụng AES trong Ruby, ta cần 2 tham số:

* **key size** (độ lớn của `key`): nhận các giá trị 128, 192 hoặc 256 bit.
* **block cipher mode**: trong các thuật toán mã hóa sử dụng `block`, cần chỉ rõ ta muốn sử dụng chế độ nào để thao tác trên `block` đó.

Các chế độ thường dùng bao gồm:

* Electronic Codebook (ECB)
* Cipher Block Chaining (CBC)
* Propagating Cipher Block Chaining (PCBC)
* Cipher Feedback (CFB)
* Output Feedback (OFB)
* Counter (CTR)

Ta sẽ dùng `key` có độ dài 256 (phức tạp nhất) và `block` có chế độ `CBC`:

```ruby
require 'openssl'

cipher = OpenSSL::Cipher::AES.new(256, :CBC)
```

Sau khi khởi tạo `cipher` (có nghĩa là *mật mã*), ta cần khai báo `cipher` này dùng để *mã hóa* (*encrypt*) hay *giải mã* (*decrypt*):

```ruby
cipher.encrypt      ### for encryption
cipher.decrypt      ### for decryption
```

Đối với các chế độ `CBC`, `CFB`, `OFB` hay `CTR`, ta cần thêm 1 tham số gọi là `iv` (viết tắt của **initialization vector**). Chỉ duy nhất `ECB` là không sử dụng `iv`, vậy nên theo các chuyên gia, không nên sử dụng chế độ `ECB` trừ khi thật sự rất cần đến nó.

Chúng ta có thể đặt `key` và `iv` của `cipher` bằng 1 String mà chúng ta muốn. Lưu ý là `iv` luôn có độ dài `16` ký tự (vì `16 * 8 = 128 bit`) còn `key` thì có các độ dài `16`, `24`, `32` tương ứng với `128`, `192` hoặc `256` bit:

```ruby
cipher.key = "secretkey@dev.ethanify.me(c)2016"         ### 32 bytes = 256 bits
cipher.iv = "secret_iv(c)2016"                          ### 16 bytes = 128 bits
```

hoặc để cho `cipher` tự sinh ngẫu nhiên:

```ruby
key = cipher.random_key             ### "Lf\xE7 \xE3bK\x82\xA9\b\x1D\xFE){\x7F\xB9\x94\x9D\xBDc\x99\xBB\x0E\x15B@\xB9\xBE \xC31d"
iv = cipher.random_iv               ### "\x96\x86\x93QR\xBE\x00\b\xC9\x90\x18\xF0H\xFB]\f"
```

**AES** trong **Ruby** cho phép ta chèn thêm nội dung vào đoạn thông điệp mã hóa bằng hàm `update()` và chỉ tính toán giá trị cuối cùng khi gọi hàm `final()`

```ruby
encrypted_content = cipher.update("Mã hóa đối xứng")
encrypted_content << cipher.update(" bằng thuật toán AES-256")
encrypted_content << cipher.final
```

Lúc này, `encrypted_content` chứa thông tin mã hóa của chuỗi `"Mã hóa đối xứng bằng thuật toán AES-256"`, nhưng ở dạng các **hexcode**. Đây là do trong quá trình mã hóa / giải mã, **AES** làm việc với các data thô ở dạng binary, chứ không phải String, vậy nên thông tin này sẽ khó đọc và thường là khó truyền đi qua Internet (dễ mất mát).

Có 1 cách đơn giản là chúng ta sẽ *encode* toàn bộ các dữ liệu thô này về dạng **Base64**. Về bản chất, **Base64** không mã hóa thông tin phức tạp như **AES**, mà chỉ tìm cách *biểu diễn* các giá trị dạng binary về dạng String dễ đọc bằng các ký tự chữ & số:

```ruby
encrypted_base64 = Base64.encode64(encrypted_content) ### "DVM+VfhAppOtvolyq9WWhFs7AT7skg5RpsN5YVZs33J5Wr/7nUb1IEFPSfeK\n6UGCsDpN1jQbhwayk4gXiEtUgw==\n"
```

#### 3.2.2. Giải mã ####

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
decrypted_content << decipher.final         ### Mã hóa đối xứng bằng thuật toán AES-256
```

## 4. Mã hóa bất đối xứng ##

Đối với **Mã hóa bất đối xứng**, **RSA** là 1 đại diện rất tiêu biểu. Đây là 1 trong những thuật toán ra đời sớm nhất và vẫn còn được sử dụng rộng rãi đến ngày hôm nay.

### 4.1. Thuật toán RSA ###

Thuật toán này được đặt tên theo họ của 3 nhà khoa học đồng phát minh ra nó là Ron **Rivest**, Adi **Shamir**, and Leonard **Adleman**. **RSA** dựa trên nguyên lý: tích của 2 số nguyên tố thì rất dễ để tính ra, nhưng sẽ rất vất vả để tìm ra 2 số ban đầu là số nào.

### 4.2. Sử dụng RSA trong Ruby ###

#### 4.2.1. Khởi tạo cặp public - private key ###

Giống như **AES**, **Ruby** cung cấp sẵn các cài đặt của **RSA** thông qua bộ thư viện `OpenSSL`:

```ruby
require 'openssl'

key = OpenSSL::PKey::RSA.new(4096)
File.write("public_key.pem", key.public_key.to_pem)

cipher = OpenSSL::Cipher::AES.new(256, :CBC)
pass_phrase = "rsa@dev.ethanify.me(c)2016"
secured_key = key.export(cipher, pass_phrase)
File.write("private_key.pem", secured_key)
```

Ở đây, chúng ta dùng 1 **RSA** `key` có độ lớn `4096 bit`. Do cả **public key** và **private key** đều lớn và cần được dùng đi dùng lại nhiều lần, nên chúng ta sẽ ghi ra file, ở đây là `public_key.pem` và `private_key.pem`. **PEM** là viết tắt của **Privacy-enhanced Electronic Mail**, có định dạng là 1 file text với nội dung nằm giữa 2 dòng `-----BEGIN CERTIFICATE-----` và `-----END CERTIFICATE-----`.

Do **private key** rất nhạy cảm, và thường thì file `private_key.pem` sẽ được lưu trữ tại máy tính của chúng ta, điều đó có nghĩa là cứ ai truy cập được vào máy tính của ta là sẽ có **private key** này. Vì vậy ta làm thêm 1 bước là mã hóa **private key** vừa tạo bằng thuật toán **AES** 256 bit, và *export* nó ra thành dữ liệu kiểu String bằng lệnh `key.export()`.

Các bạn có thể download 2 file này ở [đây][rsa-key-pairs].

#### 4.2.2. Đọc dữ liệu public - private key từ file ###

Do đã lưu vào file, mỗi lần cần dùng, ta phải đọc các dữ liệu từ 2 file này để có được cặp **public key** & **private key** đúng.

Để đọc 1 key file không bị mã hóa:

```ruby
public_key_content = File.read("public_key.pem")
public_key = OpenSSL::PKey::RSA.new(public_key_content)
```

Để đọc 1 key file đã bị mã hóa:

```ruby
private_key_content = File.read("private_key.pem")
private_key = OpenSSL::PKey::RSA.new(private_key_content, pass_phrase)
```

**RSA** cung cấp cho chúng ta 2 hàm `public?()` và `private?()` để kiểm tra xem 1 key có đúng là **public key** hay **private key** hay không:

```ruby
public_key.public?          ### true
private_key.public?         ### false

public_key.private?         ### false
private_key.private?        ### true
```

#### 4.2.3. Mã hóa - giải mã ###

Để mã hóa 1 thông điệp, ta dùng `public_key`, để giải mã, ta dùng `private_key`:

```ruby
encrypted_data = public_key.public_encrypt("Mã hóa bất đối xứng bằng thuật toán RSA 4096 bit")
encrypted_base64 = Base64.encode64(encrypted_data)
```

```ruby
encrypted_data = Base64.decode64(encrypted_base64)
decrypted_data = private_key.private_decrypt(encrypted_data)        ### Mã hóa bất đối xứng bằng thuật toán RSA 4096 bit
```

#### 4.2.4. Xác thực điện tử ###

Ngoài *mã hóa* & *giải mã*, điểm mạnh của **Mã hóa bất đối xứng** là bạn có thể *ký* vào 1 dữ liệu bằng **private key** và người nhận có thể *xác thực* bằng **public key**.

Đầu tiên, chúng ta sẽ định nghĩa 1 `digest` và *ký* vào dữ liệu bằng `digest này`:

```ruby
document = "Mã hóa bất đối xứng bằng thuật toán RSA 4096 bit"

digest = OpenSSL::Digest::SHA256.new            ### empty digest
signature = private_key.sign(digest, document)
signature_base64 = Base64.encode64(signature)
```

Khi nhận được dữ liệu, người dùng tiến hành xác thực:

```ruby
digest = OpenSSL::Digest::SHA256.new
signature = Base64.decode64(signature_base64)

verify_status = public_key.verify(digest, signature, document)          ### true
```

`verify_status` trả về `true` chỉ trong trường hợp `digest`, `signature` và `document` tại đích trùng khớp với dữ liệu tương ứng tại nguồn.

## 5. Mã hóa bằng hàm băm trong Ruby ##

Các thuật toán **Mã hóa bằng hàm băm** phổ biến nhất hiện nay là **MD5** (Message Digest 5) và **SHA** (Secure Hash Algorithm), cũng nằm trong bộ thư viện `stdlib` của **Ruby**. Do không sử dụng cơ chế chìa khóa - ổ khóa như 2 phương pháp mã hóa trên, nên cách dùng của **Mã hóa bằng hàm băm** đơn giản hơn nhiều.

### 5.1. Thuật toán MD5 ###

Để tính `digest` của 1 `message`, ta chỉ cần gọi:

```ruby
OpenSSL::Digest::MD5.digest("Mã hóa bằng hàm băm với thuật toán MD5")       ### \xFE\x7F\xBC\x94\xFE\x9E\x94O\x144\xDF\xB0\x97\xADD\xBD
```

Cũng giống như **AES** hay **RSA**, mặc định các thuật toán này trả về các giá trị dạng binary. Tuy nhiên bộ thư viện `Digest` cung cấp luôn cho chúng ta 2 phương pháp *encode* là `hexdigest` và `base64digest`:

```ruby
OpenSSL::Digest::MD5.hexdigest("Mã hóa bằng hàm băm với thuật toán MD5")    ### fe7fbc94fe9e944f1434dfb097ad44bd

OpenSSL::Digest::MD5.base64digest("Mã hóa bằng hàm băm với thuật toán MD5") ### /n+8lP6elE8UNN+wl61EvQ==
```

Ngoài ra, ta cũng có thể dùng hàm `update()` hoặc toán tử `<<` để chèn thêm các nội dung mà ta muốn mã hóa:

```ruby
digest = OpenSSL::Digest::MD5.new
digest.update("Mã hóa bằng hàm băm")
digest << " với thuật toán MD5"
digest.hexdigest                ### fe7fbc94fe9e944f1434dfb097ad44bd
digest.base64digest             ### /n+8lP6elE8UNN+wl61EvQ==
```

#### Salt ####

Trước đây, khi **MD5** mới ra đời, người ta nhận thấy đây là 1 thuật toán hiệu quả để lưu trữ các dữ liệu nhạy cảm như **mật khẩu** hay các thông tin xác thực. Hàng loạt các server lúc đó sử dụng **MD5** làm phương thức xác thực chính (bên cạnh **SHA** được phát triển từ trước). Tuy nhiên qua thời gian, **MD5** bộc lộ các điểm yếu và được chứng minh là không an toàn trước các tấn công quy mô lớn, sử dụng các kỹ thuật phức tạp và công phu.

Do vậy, người ta nghĩ ra **salt** để *cứu* các hệ thống sử dụng **MD5** này. Cách sử dụng **salt** dựa trên nguyên lý rất đơn giản: khi nấu ăn chúng ta cho thêm muối để vừa miệng, khi tính toán `digest`, ta thêm **salt** để tạo ra `digest` *khó xơi* hơn. Mục đích chính của **salt** là làm cho các mật khẩu khó đoán hơn, và ngay cả đối với các mật khẩu cực kì đơn giản, khi thêm **salt** vào sẽ trở nên phức tạp hơn nhiều. Vậy nên nếu các hackers có nắm giữ được database mật khẩu người dùng, và có 1 danh sách các mật khẩu hay gặp, thì cũng không thể nào dò đúng được mật khẩu.

Có nhiều cách sử dụng **salt**, dưới đây là 1 ví dụ: với mỗi mật khẩu, chúng ta tạo **salt** là 1 String 8 ký tự ngẫu nhiên, thêm vào đuôi của mật khẩu, rồi tính ra `digest` và lưu vào databse:

```ruby
require 'securerandom'

password = "password@dev.ethanify.me"
salt = SecureRandom.base64(8)               ### ruvewNfnOlA=

encrypted_password = OpenSSL::Digest::MD5.hexdigest(password + salt) ### 0ed88631a7ec520edb71ad513b2b1a25
```

Như vậy, thay vì chúng ta lưu **MD5** của `password` (là `b47f5aae2b8344569d8e0831906867ce`), ta sẽ lưu cả `salt` và **MD5** của `password + salt` (lúc này là `0ed88631a7ec520edb71ad513b2b1a25`, hoàn toàn không có mối liên hệ gì với **MD5** của `password` thuần).

### 5.2. Thuật toán SHA ###

Cũng giống như **MD5**, **SHA** là 1 thuật toán rất nổi tiếng và được sử dụng rộng rãi. Tuy nhiên khác với **MD5**, **SHA** cung cấp 3 chế độ mã hóa với các chuẩn `256`, `384` và `512` bit (. Nói chung, **SHA** càng dài thì càng an toàn, nhưng cũng mất nheiefu thời gian để tính toán hơn, đặc biệt với các tập dữ liệu lớn.

Cách sử dụng của **SHA** không khác với **MD5**:

```ruby
digest = OpenSSL::Digest::SHA256.new
digest.update("Mã hóa bằng hàm băm")
digest << " với thuật toán MD5"
digest.hexdigest                ### 2e22dfb0aed5c8b078a13b996790b522bad45b4207009bb32daf571776a75808

digest = OpenSSL::Digest::SHA384.new
digest.update("Mã hóa bằng hàm băm")
digest << " với thuật toán MD5"
digest.hexdigest                ### d526adc561a59241c5d864f65a684a02f6c8f27c53a522177a6e709e5dd3a3f1

digest = OpenSSL::Digest::SHA512.new
digest.update("Mã hóa bằng hàm băm")
digest << " với thuật toán MD5"
digest.hexdigest                ### 0953e45472e0d2e0a668c2812358d6a29d8277c86a7ff0d120be2db84f0f021d5afd44b26bc6d5f25dfdcf8b605c5c18f66c1cc831168f4a954c861b1e97f751
```

[rsa-key-pairs]:        {{ site.url }}/assets/downloads/misc/2016-07-07-rsa-key-pairs.zip
[part-1]:               {{ site.url }}{% post_url 2016-07-06-encryption-methods-1 %}
