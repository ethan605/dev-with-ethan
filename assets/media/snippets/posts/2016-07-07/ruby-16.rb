document = "Mã hóa bất đối xứng bằng thuật toán RSA 4096 bit"

digest = OpenSSL::Digest::SHA256.new            # empty digest
signature = private_key.sign(digest, document)
signature_base64 = Base64.encode64(signature)
