require 'openssl'

key = OpenSSL::PKey::RSA.new(4096)
File.write("public_key.pem", key.public_key.to_pem)

cipher = OpenSSL::Cipher::AES.new(256, :CBC)
pass_phrase = "rsa@dev.ethanify.me(c)2016"
secured_key = key.export(cipher, pass_phrase)
File.write("private_key.pem", secured_key)
