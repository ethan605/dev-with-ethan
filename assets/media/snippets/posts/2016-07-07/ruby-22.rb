digest = OpenSSL::Digest::SHA256.new
digest.update("Mã hóa bằng hàm băm")
digest << " với thuật toán MD5"
digest.hexdigest                # 2e22dfb0aed5c8b078a13b996790b522bad45b4207009bb32daf571776a75808

digest = OpenSSL::Digest::SHA384.new
digest.update("Mã hóa bằng hàm băm")
digest << " với thuật toán MD5"
digest.hexdigest                # d526adc561a59241c5d864f65a684a02f6c8f27c53a522177a6e709e5dd3a3f1

digest = OpenSSL::Digest::SHA512.new
digest.update("Mã hóa bằng hàm băm")
digest << " với thuật toán MD5"
digest.hexdigest                # 0953e45472e0d2e0a668c2812358d6a29d8277c86a7ff0d120be2db84f0f021d5afd44b26bc6d5f25dfdcf8b605c5c18f66c1cc831168f4a954c861b1e97f751
