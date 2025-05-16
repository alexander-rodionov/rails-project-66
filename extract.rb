pp 'Extract'
dir_list = Dir.glob("#/project/**/")
(dir_list.filter { |f| !(f=~/tmp|vendor|storage|node_modules/)}).each { |x| p x }
