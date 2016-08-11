decrypted_content = decipher.update(encrypted_content)
decrypted_content << decipher.final
