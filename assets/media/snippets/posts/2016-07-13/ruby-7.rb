use omniauth::builder do
  provider :facebook, settings.facebook["app_id"], settings.facebook["app_secret"]
  provider :google_oauth2, settings.google["client_id"], settings.google["client_secret"]
end
