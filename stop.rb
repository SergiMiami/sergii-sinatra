#!/usr/bin/env ruby

command = "kill "
File.open("pid.txt"){|f|
command << f.readline
}
exec command
#exec "./main.rb -p 5000"