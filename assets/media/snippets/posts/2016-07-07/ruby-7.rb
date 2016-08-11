decipher = OpenSSL::Cipher::AES.new(256, :CBC)
decipher.decrypt

decipher.key = "secretkey@dev.ethanify.me(c)2016"
decipher.iv = "secret_iv(c)2016"
