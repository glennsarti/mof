# create HTML hierarchy
#
# Usage: [ -p <prefix> ] [ -b <basedir> ] <schema>
#
# prefix: Html prefix, defaults to SystemsManagement/CIM/Schema
# basedir: base directory, defaults to /usr/share/mof/cim-current
#
#

COLUMNS = 3

arg = ARGV.shift
basedir = "/usr/share/mof/cim-current"
if arg == "-b"
  basedir = ARGV.shift
else
  schema = arg
end

prefix = "SystemsManagement/CIM/Schema"

if schema.nil?
  $stderr.puts "Usage: [ -b <basedir> ] <schema>"
  exit 1
end

puts "<HTML>"
puts "<HEAD>"
puts "<TITLE>CIM : #{schema}</TITLE>"
puts "</HEAD>"
puts "<BODY>"
puts "<h1>#{schema}</h1>"
puts
puts "<table>"

classes = []
Dir.foreach( File.join(basedir, schema) ) do |f|
  next if f[0,1] == "."
  classes << File.basename(f, ".mof")
end
classes.sort!

count = classes.size
i = 0
classes.each do |classname|
  if i % COLUMNS == 0
    puts "<tr>"
  end
  print "<td><a href=\"#{classname}.html\">#{classname}</a></td>"
  i += 1
  if i < count
    if i % COLUMNS == 0
      puts "</tr>"
    end
  end
end
puts "</TABLE>"
puts "</BODY>"
puts "</HTML>"
