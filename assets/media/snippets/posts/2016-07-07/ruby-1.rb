require 'openssl'

cipher = OpenSSL::Cipher::AES.new(256, :CBC)
