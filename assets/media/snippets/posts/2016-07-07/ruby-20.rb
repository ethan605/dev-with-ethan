digest = OpenSSL::Digest::MD5.new
digest.update("Mã hóa bằng hàm băm")
digest << " với thuật toán MD5"
digest.hexdigest                # fe7fbc94fe9e944f1434dfb097ad44bd
digest.base64digest             # /n+8lP6elE8UNN+wl61EvQ==
