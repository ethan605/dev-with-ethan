private_key_content = File.read("private_key.pem")
private_key = OpenSSL::PKey::RSA.new(private_key_content, pass_phrase)
