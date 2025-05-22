if Rails.env.production? || Rails.env.development?
  require 'solid_queue'
end
