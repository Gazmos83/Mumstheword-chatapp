#if Rails.env.production?
#  CarrierWave.configure do |config|
#    config.fog_credentials = {
#      # Configuration for MEGA
#      :provider              => 'MEGA',
#      :key    => ENV['MEGA_ACCESS_KEY'],
#      :user_password => ENV['MEGA_PASSWORD']
#    }
#    config.fog_directory     =  ENV['S3_BUCKET']
#  end
#end
