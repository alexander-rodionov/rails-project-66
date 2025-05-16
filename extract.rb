pp 'Extract'
root_path = '/project/'
# dir_list = Dir.glob("/project/**/")
# (dir_list.filter { |f| !(f=~/tmp|vendor|storage|node_modules/)}).each { |x| p x }
tests = Dir.glob("#{root_path}test/**/*")
root = Dir.glob("#{root_path}*")

tests.each { |x| p x }
root.each { |x| p x }
