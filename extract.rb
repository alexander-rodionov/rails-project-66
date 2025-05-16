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

p 'FILE COUNT', tests.size

def extract(file_list)
  zip_file_name = 'archive.zip'

  Zip::File.open(zip_file_name, Zip::File::CREATE) do |zipfile|
    file_list.each do |file_path|
      if File.exist?(file_path)
        zipfile.add(File.basename(file_path), file_path)
      else
        puts "File not found: #{file_path}"
      end
    end
  end

  if File.exist?(zip_file_name)
    zip_content = File.binread(zip_file_name)
    base64_content = Base64.strict_encode64(zip_content)
    puts base64_content
    File.delete(zip_file_name)
  else
    puts "Failed to create zip file."
  end
end

extract(tests)
