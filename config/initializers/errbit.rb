Airbrake.configure do |config|
  config.api_key = '477847f7f0e936c237b07a48d70637c4'
  config.host    = 'errbit.hut.shefcompsci.org.uk'
  config.port    = 443
  config.secure  = config.port == 443
end
