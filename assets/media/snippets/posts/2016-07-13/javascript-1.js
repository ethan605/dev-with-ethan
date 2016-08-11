$('a').click(function(e) {
  FB.login(function(response) {
    if (response.authResponse) {
      $('#connect').html('Kết nối thành công! Gọi callback GET /auth/facebook/callback...');
      
      $.getJSON('/auth/facebook/callback', function(user) {
        $('#connect').html('Xác thực thành công! Kết thúc quá trình đăng nhập.');

        $('#uid').html(user.uid)
        $('#display-name').html(user.info.name)
        $('#profile-image').attr('src', user.info.image)
        $('#access-token').html(user.credentials.token)

        $('#results').show(500)
      });
    }
  });
});
