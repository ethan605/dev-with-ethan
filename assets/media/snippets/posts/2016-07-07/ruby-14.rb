encrypted_data = public_key.public_encrypt("Mã hóa bất đối xứng bằng thuật toán RSA 4096 bit")
encrypted_base64 = Base64.encode64(encrypted_data)
