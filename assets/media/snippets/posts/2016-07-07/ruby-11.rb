public_key_content = File.read("public_key.pem")
public_key = OpenSSL::PKey::RSA.new(public_key_content)
