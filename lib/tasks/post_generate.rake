# frozen_string_literal: true

namespace :post_generate do
  desc 'Add frozen string literal comment to queue_schema.rb'
  task add_frozen_string_literal: :environment do
    file_path = 'db/queue_schema.rb'
    content = File.read(file_path)
    content.prepend("# frozen_string_literal: true\n")
    File.write(file_path, content)
  end
end
