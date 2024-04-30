Rails.application.config.action_mailer.tap do |action_mailer|
  action_mailer.default_options = {
    from: ENV.fetch('FROM_ADDRESS', 'draw.mcgill@gmail.com'),
    bcc: ENV.fetch('BCC_ADDRESS', nil)
  }

  if Rails.env.test?
    action_mailer.default_url_options = { host: "localhost" }
  elsif Rails.env.development?
    action_mailer.tap do |action_mailer|
      action_mailer.default_url_options = { host: 'localhost', port: 5200 }
      action_mailer.delivery_method = :smtp
      action_mailer.perform_deliveries = true
      action_mailer.raise_delivery_errors = true
      action_mailer.smtp_settings = {
        address:              ENV.fetch("SMTP_SERVER") { 'localhost' },
        port:                 ENV.fetch("SMTP_PORT") { 1025 },
        domain:               ENV.fetch("SMTP_SERVER") { 'localhost' }
      }
    end
  else
    # ensure that the correct portocol is used when generating emails
    protocal = Rails.application.config.force_ssl ? "https" : "http"

    action_mailer.tap do |action_mailer|
      action_mailer.default_url_options = { host: ENV["HOSTNAME"], protocol: protocal }
      action_mailer.delivery_method = :smtp
      action_mailer.perform_deliveries = true
      action_mailer.raise_delivery_errors = true
      action_mailer.smtp_settings = {
        address: ENV.fetch('SMTP_SERVER', 'localhost'),
        port: ENV.fetch("SMTP_PORT") { 25 },
        domain: ENV.fetch('SMTP_DOMAIN', nil),
        openssl_verify_mode: 'none',
        enable_starttls_auto: false,
        tls: false
      }

      user_name = ENV.fetch('SMTP_USERNAME', nil)
      action_mailer.smtp_settings[:user_name] = user_name if user_name
      password = ENV.fetch('SMTP_PASSWORD', nil)
      action_mailer.smtp_settings[:password] = password if password
      authentication = ENV.fetch('SMTP_AUTHENTICATION', nil) # plain etc
      action_mailer.smtp_settings[:authentication] = authentication if authentication
      enable_starttls_auto = ENV.fetch('SMTP_SSL_START_AUTO', nil)
      action_mailer.smtp_settings[:enable_starttls_auto] = enable_starttls_auto if enable_starttls_auto
      openssl_verify_mode = ENV.fetch('SMTP_SSL_VERIFY_MODE', nil)
      action_mailer.smtp_settings[:openssl_verify_mode] = openssl_verify_mode if openssl_verify_mode
      tls_mode = ENV.fetch('SMTP_TLS', nil)
      action_mailer.smtp_settings[:tls] = tls_mode if tls_mode
    end
  end
end
