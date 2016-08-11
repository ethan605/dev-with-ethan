encrypted_data = Base64.decode64(encrypted_base64)

decrypted_content = decipher.update(encrypted_data)
decrypted_content << decipher.final         # Mã hóa đối xứng bằng thuật toán AES-256
