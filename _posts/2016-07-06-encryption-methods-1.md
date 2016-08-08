---
layout: article
title: "Cryptography: Các phương pháp mã hóa thường dùng"
description: "Hiểu 1 cách đơn giản các phương pháp thường dùng trong mã hóa và những ứng dụng thực tiễn: đối xứng (symmetric), bất đối xứng (asymetric) & hàm băm (hash function)"
date: 2016-07-06 09:00:00 +0700
categories: [misc]
tags: [cryptopgraphy, encryption, 'mã hóa', symmetric, 'đối xứng', asymmetric, 'bất đối xứng', hash, 'hàm băm', md5, sha, aes, digest]
comments: true
instant_title: Các phương pháp mã hóa thường dùng
instant_kicker: Thế giới Công nghệ
---

***Disclaimer:*** *các kiến thức trong bài viết này hoàn toàn chỉ mang tính chất tham khảo, dựa trên những trải nghiệm của cá nhân người viết đối với các thuật toán mã hóa trong quá trình làm việc. Bản thân người viết chưa theo bất kỳ khóa học nào liên quan đến Bảo mật, Mã hóa hay An toàn thông tin.*

## 1. Mã hóa trong lịch sử Khoa học Máy tính ##

**Mã hóa** là 1 khái niệm xuất hiện từ rất lâu trong lịch sử phát triển của loài người, đặc biệt là trong các lĩnh vực quân sự, chính trị, truyền tin - liên lạc. Nói chung con người là 1 loài kỳ lạ: mất hàng chục ngàn năm để phát triển các công cụ giao tiếp ưu việt (ngôn ngữ nói, ngôn ngữ viết) hơn các loài khác, để rồi lại mất hàng ngàn năm để tìm ra những cách thức *mã hóa* chúng, làm cho mọi thứ trở nên *bí hiểm*, *khó hiểu*, thậm chí là *không thể phá giải* nổi.

(Thật sự là trong **Thế chiến II**, có 1 khoảng thời gian dài mà cỗ máy mã hóa **Enigma** của Đức Quốc Xã đã làm toàn bộ Châu Âu điên đầu, cho đến khi **Alan Turing** ra tay! - Nếu bạn là tín đồ phim ảnh thì đừng bỏ qua **The Immitation Game**, bộ phim kể về chính sự kiện này)

Nói vui là vậy, còn quả thật, các tiến bộ của ngành **Mật mã học** (*Cryptography*) đã giúp ích rất nhiều cho sự phát triển của **Khoa học Máy tính**, kèm theo đó là những kỹ thuật mã hóa cao cấp, hiện diện trong hầu hết các lĩnh vực điện tử trong đời sống của chúng ta hiện nay, ví dụ như:

* **Giao thức thần thánh HTTPS** cho phép chúng ta thực hiện các giao dịch điện tử (chuyển tiền, thanh toán online,...) một cách an toàn, giảm thiểu lo ngại đối với những thành phần phá hoại (hackers, attackers)
* **Xác thực điện tử** (bao gồm *Chữ ký điện tử, *Xác thực tập tin*, *Xác thực thông điệp*): không chỉ các giao dịch liên quan đến tiền bạc, các hợp đồng hay thông điệp truyền tin qua mạng bây giờ cũng rất cần đến bảo mật. Tưởng tượng rằng chúng ta nhận được 1 tin nhắn từ 1 người *(mà chúng ta nghĩ là)* bạn hỏi mượn tiền, làm sao ta biết được người đó đúng là bạn ta để quyết định có cho mượn tiền không? *(nghe quen nhỉ?)*
* **Quân sự - Chính trị** *(tất nhiên rồi!)*: nhưng khác với trong quá khứ, Quân sự & Chính trị giờ đây đã được hiện đại hóa nhiều hơn, đồng nghĩa với việc nó cũng trở nên mỏng manh hơn, dễ bị tấn công hơn (ai cũng có máy tính, và hacker thì càng ngày càng trẻ). Và cuộc chiến giữa *mã hóa*, *bảo mật* với *tấn công*, *bẻ khóa* càng ngày càng tinh vi hơn. Những ai có hứng thú và muốn cống hiến tài năng của mình với nền Bảo mật Quốc phòng nước nhà, có thể nộp đơn vào **Học viện Kỹ thuật Mật mã** ngay bây giờ!

## 2. Các phương pháp Mã hóa cơ bản ##

Đối với những ai đã từng lập trình, hẳn sẽ không còn xa lạ với một vài cái tên như **MD5**, **SHA-1**, **SHA-256**, **AES**, **TEA**... Tuy nhiên có 1 vấn đề là đa số chúng ta không phân biệt các **phương pháp** mã hóa với nhau, đồng thời mỗi phương pháp lại có những **thuật toán** khác nhau ra đời nhằm nâng cấp, cải tiến hoặc phục vụ 1 nhu cầu khác.

Vậy nên trước tiên chúng ta cần tìm hiểu 1 chút xem có những phương pháp mã hóa nào, tiếp theo trong từng phương pháp, ta sẽ cùng tìm hiểu xem có những thuật toán nào phổ biến, và ưu nhược điểm của chúng là gì. Từ đó các bạn sẽ có 1 góc nhìn toàn cảnh và biết được công cụ nào là phù hợp trong từng bài toán cụ thể.

Có 3 phương pháp **Mã hóa** mà người ta hay dùng:

* **Mã hóa đối xứng** (Symmetric cryptography) - hay còn gọi là **Mã hóa sử dụng khóa bí mật** (Secret key encryption)
* **Mã hóa bất đối xứng** (Asymmetric cryptography) - hay còn gọi là **Mã hóa sử dụng khóa công khai** (Public key encryption)
* **Mã hóa bằng hàm băm** (Cryptographic hash function) - hay còn gọi là **Mã hóa 1 chiều** (One-way encryption)

### 2.1. Mã hóa đối xứng ###

Mã hóa đối xứng là phương pháp cổ điển nhất, dựa trên 1 cơ chế đơn giản mà chúng ta vẫn dùng hàng ngày, đó là **chìa khóa** & **ổ khóa**. Trong mỗi gia đình, chúng ta đều có những chiếc khóa cửa đúng không? Mỗi chiếc khóa đều đi kèm với 1 chìa khóa riêng, không giống với bất kỳ chiếc chìa khóa nào khác, và chỉ có chiếc chìa khóa đó mới mở được ổ khóa kia.

Từ xa xưa con người đã sáng tạo ra ổ khóa, và công dụng của nó không chỉ khóa nhà, mà còn khóa các thiết bị nhỏ và di động hơn, như *rương*, *hòm*, *tủ*,... Một ví dụ gần với **Mã hóa đối xứng** nhất là khi chúng ta cần di chuyển 1 hòm vàng từ nơi này đến nơi khác chẳng hạn: Giả sử chúng ta có 1 hòm vàng tên là `G`, do người `A` cần chuyển từ nơi `X` đến tay người `B` ở nơi `Y`. Khi đó:

* Người `A` và người `B` cùng thỏa thuận sẽ sử dụng 1 ổ khóa `L`, chỉ có 1 chìa khóa `K` mới mở được. Mỗi người `A` và `B` đều giữ 1 phiên bản giống hệt nhau của chiếc chìa khóa `K`.
* Tại điểm `X`, người `A` khóa cái hòm vàng `G` bằng ổ khóa `L` (đã kiểm tra mở thử bằng chìa khóa `K` thành công).
* Trong quá trình vận chuyển, may mắn không có băng cướp nào động tay được vào cái hòm `G`.
* Tại điểm `Y`, khi nhận hòm, người `B` mở ổ khóa `L` bằng chìa khóa `K` (của người `B`) thành công, nhận được toàn bộ số vàng mà người `A` đã gửi, nguyên vẹn và đầy đủ.

Vậy là quá trình bảo mật & vận chuyển hòm vàng `G` diễn ra thành công tốt đẹp. **Mã hóa đối xứng** cũng hoạt động theo phương pháp tương tự:

{% include figure.html
   filename="/assets/media/posts/misc/2016-07-06-symmetric-crypt-demo.jpg"
   alt="Mã hóa đối xứng"
   caption="Mã hóa đối xứng *(Nguồn: [Gigatux.nl](http://books.gigatux.nl/mirror/securitytools/ddu/ch09lev1sec1.html))*" %}

Trong trường hợp này:

* **Plain text document** chính là vàng trong hòm `G`.
* Nó bị khóa lại bằng 1 **shared key** chính là chiếc chìa khóa `K` của chúng ta.
* Cái hòm bị khóa là phần **Encrypted document**, không ai đọc hiểu thông tin của nó là gì.
* Đến tay người `B` (**Recipient**), toàn bộ thông tin được giải mã (**Decrypted**) vẫn bằng 1 chiếc chìa khóa là **shared key** và nhận được **Plain text document** nguyên vẹn.

Phương pháp này có ưu điểm ở chỗ:

* Đơn giản: chỉ cần 1 chìa khóa `K` đánh thành 2 bản giống hệt nhau chia cho 2 người & 1 ổ khóa `L` đủ tin tưởng là có thể tiến hành.
* Dễ thực hiện: sử dụng cùng 1 thuật toán để mã hóa và giải mã (chỉ khác là ngược chiều nhau).
* Tính xác thực cao: chỉ duy nhất người `A` có chìa khóa `K` mới gửi được 1 hòm vàng `G`, những ai giả mạo người `A` chắc chắn sẽ không thể gửi được 1 hòm vàng đúng cho người `B`

Tuy nhiên nó cũng có các nhược điểm:

* Mất chìa khóa là mất hết: giả sử người `A` đang ở Việt Nam, người `B` ở Mỹ, một khi người `B` mất chìa khóa `K` thì phải 1 thời gian dài sau mới nhận lại được chìa khóa đúng để mở hòm -> rất mất công
* Độ an toàn kém: giả sử người `A` để lộ thiết kế của chiếc chìa khóa `K`, khi đó bất kỳ kẻ xấu nào cũng có thể lợi dụng để mở hòm vàng `G` trên đường vận chuyển, trước khi tới tay người `B`

Do vậy, người ta mới sáng tạo ra phương pháp thứ 2, đó là **Mã hóa bất đối xứng**

### 2.2. Mã hóa bất đối xứng ###

Quay trở lại ví dụ của chúng ta về chiếc hòm chứa vàng tên là `G`. Giờ chúng ta được yêu cầu thay đổi thiết kế để nâng cấp độ an toàn của chiếc hòm lên như sau:

* Người `B` muốn chỉ 1 mình anh này giữ chìa khóa mà thôi, tức là kể cả người `A` cũng không có phiên bản nào chìa khóa `K` cả, do anh này nghĩ rằng: 1 là không ai đủ tin tưởng để chia sẻ chiếc chìa khóa `K` ngoài bản thân mình; 2 là mỗi khi muốn nâng cấp hệ thống khóa cho cái hòm, thì anh ta chỉ cần thay 1 bộ chìa khóa - ổ khóa khác, không cần phải gửi chìa khóa mới cho ai; 3 là càng ít người biết về cái chìa khóa, càng ít người có khả năng mở khóa.
* Cái hòm nếu chỉ chứa vàng của người `A` thì vẫn thừa chỗ, trong khi nếu làm thêm nhiều cái hòm nữa để những người khác (giả sử `C`, `D`, `E`,... nào đó) cùng gửi vàng cho người `B` thì lại tốn kém. Phải có cách nào đó để cái hòm `G` có thể nhận được nhiều vàng từ nhiều người, mà không làm thay đổi độ an toàn của cái hòm.

Những yêu cầu này chính là cơ sở của cơ chế **Mã hóa bất đối xứng** như trong hình dưới đây:

{% include figure.html
   filename="/assets/media/posts/misc/2016-07-06-asymmetric-crypt-demo.jpg"
   alt="Mã hóa bất đối xứng"
   caption="Mã hóa bất đối xứng *(Nguồn: [Gigatux.nl](http://books.gigatux.nl/mirror/securitytools/ddu/ch09lev1sec1.html))*" %}

Ở đây, ta sẽ có:

* Vẫn sử dụng 1 cơ chế hòm chứa vàng `G`, nhưng thay vì có 1 ổ khóa `L` mà người `A` có thể mở được, ta thiết kế nó bằng 1 ổ khóa cao cấp hơn `Lx`, chỉ có người `B` mới mở được bằng chìa khóa `K`. Ngoài ra, trên cái hòm `G` có thêm 1 cái lỗ để người `A` đút vàng vào được. Lỗ này chỉ vừa nhỏ bằng 1 thỏi vàng, và theo cơ chế cửa 1 chiều: tức là đút vàng vào được mà không thể moi vàng ra ngoài được.
* Người `A` đút hết vàng vào hòm, trên đường vận chuyển về cho người `B`, chúng ta có thể ghé qua chỗ người `C`, `D`, `E`,... để lấy thêm vàng.
* Trên đường vận chuyển, chẳng may bị cướp, cái hòm vẫn nguyên vẹn vì không ai biết mở cái hòm ra như thế nào cả. Ngoài người `B` thì ngay cả `A`, `C`, `D` hay `E` cũng đều ko biết cái khóa được thiết kế thế nào, mở kiểu gì.
* Cuối cùng, cái hòm vẫn trở về được với người `B`, tuy có xây xát 1 chút do bọn cướp cố gắng mở, nhưng về cơ bản thì vàng trong hòm vẫn an toàn. Dùng chìa khóa `K`, người `B` nhận được toàn bộ số vàng nguyên vẹn và đầy đủ.

Tất nhiên về mặt giải thuật, phương pháp **Mã hóa bất đối xứng** không đơn giản là làm ra 1 *cái lỗ* như cái hòm vàng kia, mà nó sử dụng 1 cơ chế gọi là **public key** - **private key**:

* **public key** là 1 đoạn mã công khai, tất cả mọi người cùng biết, thường được tính toán dựa trên việc nhân 2 số nguyên tố rất lớn với nhau. Tinh thần của việc này là việc nhân 2 số nguyên tố rất lớn thì ra 1 kết quả là 1 số nguyên dương rất lớn và hiển nhiên, nhưng sẽ cực kỳ mất công và gần như không có thuật toán đủ tốt để tìm ra 2 số nguyên tố ban đầu sử dụng là 2 số nào.
* **private key** là 1 đoạn mã bí mật, chỉ duy nhất 1 người (trong trường hợp trên là người `B`) biết được. Đây có thể là 1 trong 2 số nguyên tố dùng để tính **public key** ở trên.
* Cứ mỗi người muốn gửi 1 thông điệp cho người `B`, họ có thể dùng **public key** mà người `B` công khai để mã hóa thông điệp. Thông điệp này sẽ chỉ được mở bằng **private key** mà người `B` đang nắm giữ. Việc này giống như đút vàng vào hòm mà không thể nào lấy ra được. Tức là ngay cả khi người `A` đã mã hóa bằng **public key**, thì bản thân người `A` cũng không thể giải mã nổi (vì không có **private key** của người `B`)

Một ứng dụng rất hay của **Mã hóa bất đối xứng** chính là **Chữ ký điện tử**. Cơ chế này hoạt động như sau:

* Một người nào đó muốn **ký** vào 1 văn bản cần xác thực (thường là *hợp đồng*, *chứng từ* hoặc *giấy tờ pháp lý*) sẽ sử dụng **private key** của mình để ký vào.
* Bất kỳ ai nhận được văn bản trên, đều có thể sử dụng **public key** của người **ký** để kiểm tra: nếu kết quả tính toán từ **public key** khớp với **chữ ký** mà họ nhận được, thì khả năng cao (không phải 100% nhưng cũng phải 99.99%) họ đang nhận được 1 văn bản hợp pháp với chữ ký hợp lệ của chính người gửi.
* Bất kỳ ai cố tình sinh ra 1 chữ ký giả đều không thể vượt qua bài kiểm tra **public key** của người gửi được.
* Bất kỳ ai cố tình sửa chữ ký cũng sẽ bị phát hiện do chữ ký đã sửa không khớp với bài kiểm tra **public key**.

### 2.3. Mã hóa bằng hàm băm ###

Về lý thuyết, 1 phép **Mã hóa bằng hàm băm** được định nghĩa là 1 thuật toán biến 1 chuỗi thông tin có độ dài bất kỳ thành 1 chuỗi thông tin có độ dài cố định. Thông tin có độ dài bất kỳ như vậy được gọi là `message` (hay thông điệp), còn thông tin được tính toán ra có độ dài cố định được gọi là `digest` (hay tóm tắt của thông điệp). Một thuật toán như vậy được gọi là lý tưởng nếu nó đảm bảo 4 điều kiện:

* Dễ dàng và tốn ít thời gian để tính toán được ra `digest` của 1 `message` bất kỳ
* Rất khó khăn và tốn kém tài nguyên để lần ngược `message` từ 1 `digest` có sẵn, hoặc phải thử toàn bộ các trường hợp khả thi và đối chiếu với `digest` để tìm ra `message` đúng
* Một thay đổi nhỏ trong `message` cũng dẫn đến thay đổi rất lớn ở `digest` tính toán ra, dẫn đến việc 2 `message` gần gần giống nhau sẽ sinh ra 2 `digest` hoàn toàn khác biệt.
* Rất khó khăn và gần như không thể tìm được 2 `message` khác nhau sinh ra cùng 1 `digest` giống nhau.

Chính do những tính chất như vậy mà **Mã hóa bằng hàm băm** còn được gọi là **Mã hóa 1 chiều**.

So với 2 phương pháp ở trên, **Mã hóa bằng hàm băm** đơn giản hơn ở chỗ: chúng ta không cần dùng đến chìa khóa & ổ khóa để mã hóa, nhưng cũng do nó là 1 chiều, nên thường thuật toán này không dùng để truyền thông điệp, mà nó được ứng dụng nhiều hơn trong **xác thực**:

* Xác thực mật khẩu: chắc có nhiều người quen với việc dùng **MD5** hay **SHA** để lưu và xác thực 1 mật khẩu có đúng không. Ngoài ra việc lưu 1 mật khẩu dưới dạng `digest` trong database làm cho nó an toàn hơn rất nhiều: kể cả khi database có bị đánh cắp, mật khẩu người dùng cũng không bị lộ.
* Xác thực độ toàn vẹn của 1 file hay 1 tin nhắn: việc truyền dữ liệu qua Internet không phải lúc nào cũng đảm bảo dữ liệu toàn vẹn 100%. Đôi khi những lúc mạng chậm, chập chờn hoặc có lỗi về đường truyền, chúng ta nhận được 1 file hoặc 1 thông điệp không toàn vẹn (thường là bị lỗi 1 phần). Nếu dữ liệu đủ nhỏ (1 tin nhắn vài dòng, 1 file dữ liệu vài kB) thì không nói làm gì vì ta có thể dễ dàng kiểm tra bằng mắt thường. Nhưng nếu dữ liệu lớn cỡ vài trăm MB hay GB thì không thể dùng mắt thường được.

Khi đó:

* Tại nguồn của dữ liệu, ta tiến hành tính toán `digest` (thường là **SHA-128**, **SHA-256** hoặc **SHA-512** nếu dữ liệu rất lớn)
* Dữ liệu truyền qua Internet 1 cách bình thường & kèm theo `digest` đã tính toán (do `digest` này có độ dài tối đa là 512 bytes nên hầu như nó không thể bị lỗi khi truyền)
* Tại đích, ta lại tính toán `digest` của dữ liệu, nếu trùng khớp với `digest` tại nguồn thì tức là ta đã truyền tải thành công, còn nếu không, chắc chắn đã xảy ra lỗi ở đâu đó, ta cần truyền tải lại.

Trong bài [sau][part-2], chúng ta sẽ cùng tìm hiểu 1 số thuật toán mã hóa phổ biến và cách dùng chúng trong ngôn ngữ **Ruby**.

[part-2]:     {{ site.url }}{% post_url 2016-07-07-encryption-methods-2 %}
