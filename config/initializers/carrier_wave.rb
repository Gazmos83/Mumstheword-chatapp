if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for MEGA
      :provider              => 'MEGA',
      :user_name    => ENV['S3_ACCESS_KEY'],
      :user_password => ENV['S3_SECRET_KEY']
    }
    config.fog_directory     =  ENV['S3_BUCKET']
  end
end
