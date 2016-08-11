digest = OpenSSL::Digest::SHA256.new
signature = Base64.decode64(signature_base64)

verify_status = public_key.verify(digest, signature, document)          # true
