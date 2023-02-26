#!/usr/bin/env ruby

$commit_msg_file=ARGV[0]
$commit_source=ARGV[1]
$sha1=ARGV[2]

def file_prepend(file, str)
  new_contents = ""
  File.open(file, "r") do |file|
    contents = file.read
    new_contents = "##{str}\n" << contents
  end
  File.open(file, "w") do |file|
    file.write(new_contents)
  end
end

def show_recent_commit_msgs
  msgs = `git log --pretty=format:'%s'`.split("\n")

  if msgs.size <= 1
    puts "commit count less than 1"
    exit 1
  end

  msgs.each do |msg|
    file_prepend($commit_msg_file, msg)
  end
end

show_recent_commit_msgs

