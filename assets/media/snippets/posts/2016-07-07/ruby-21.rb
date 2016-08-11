require 'securerandom'

password = "password@dev.ethanify.me"
salt = SecureRandom.base64(8)                                         # ruvewNfnOlA=

encrypted_password = OpenSSL::Digest::MD5.hexdigest(password + salt)  # 0ed88631a7ec520edb71ad513b2b1a25
