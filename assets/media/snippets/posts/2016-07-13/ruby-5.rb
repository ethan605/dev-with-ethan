get '/login/:provider' do
  content_type 'text/html'
  send_file "views/#{params[:provider]}.html"
end
