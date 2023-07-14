#!/usr/bin/env ruby

$commit_msg_file=ARGV[0]
$commit_source=ARGV[1]
$sha1=ARGV[2]

def print_args
  puts "commit_msg_file is #{$commit_msg_file}" #.git/COMMIT_EDITMSG
  puts "commit_source is #{$commit_source}"
  puts "sha1 is #{$sha1}"
end

def format_msgs(commit_num, msgs)
  result = "\n"
  if msgs.size >= commit_num
    top_commits = msgs.first(commit_num)
    top_commits.each_with_index do |msg, index|
      result << "# #{msg}"
      result << "\n" unless index == commit_num - 1
    end
  end
  result
end

def prepend_string(file, str)
  new_contents = ""
  File.open(file, "r") do |file|
    contents = file.read
    new_contents = "#{str}" << contents
  end
  File.open(file, "w") do |file|
    file.write(new_contents)
  end
end

def show_recent_commit_msgs(commit_num, msgs)
  result = format_msgs(commit_num, msgs)
  prepend_string($commit_msg_file, result)
  exit 0
end

#print_args
show_recent_commit_msgs(3, `git log --pretty=format:'%s'`.split("\n"))
