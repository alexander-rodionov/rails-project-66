require 'zip'
require 'base64'

pp 'Extract'
root_path = '/project/'
# dir_list = Dir.glob("/project/**/")
# (dir_list.filter { |f| !(f=~/tmp|vendor|storage|node_modules/)}).each { |x| p x }
tests = Dir.glob("#{root_path}test/**/*")
tests << "/project/docker-compose.override.yml"
tests << "/project/docker-compose.production.yml"
tests << "/project/docker-compose.yml"
tests << "/project/test.rb"
tests << "/project/code/.rubocop.yaml"

p 'FILE COUNT', tests.size

def extract(file_list)
  p 'Enter function'
  zip_file_name = 'archive.zip'

  Zip::File.open(zip_file_name, Zip::File::CREATE) do |zipfile|
    file_list.each do |file_path|
      if File.exist?(file_path)
        zipfile.add(file_path[1..], file_path)
      else
        p "File not found: #{file_path}"
      end
    end
  end

  if File.exist?(zip_file_name)
    p "Printing"
    zip_content = File.binread(zip_file_name)
    base64_content = Base64.strict_encode64(zip_content)
    p base64_content
    File.delete(zip_file_name)
  else
    p "Failed to create zip file."
  end
rescue => e
  p 'Exception', e
end

p 'Starting extract', tests

extract(tests)


# def save_base64_to_zip(base64_text, output_file = 'archive.zip')
#   # Decode the base64 text to binary data
#   binary_data = Base64.strict_decode64(base64_text)

#   # Write the binary data to a zip file
#   File.open(output_file, 'wb') do |file|
#     file.write(binary_data)
#   end

#   puts "File saved as #{output_file}"
# rescue => e
#   puts "An error occurred: #{e.message}"
# end

# # Example usage:
# base64_text = "UEsDBBQAAAAI..." # Replace with your base64 encoded text
# save_base64_to_zip(base64_text)