encrypted_content = cipher.update("Mã hóa đối xứng")
encrypted_content << cipher.update(" bằng thuật toán AES-256")
encrypted_content << cipher.final
