encrypted_data = Base64.decode64(encrypted_base64)
decrypted_data = private_key.private_decrypt(encrypted_data)        # Mã hóa bất đối xứng bằng thuật toán RSA 4096 bit
