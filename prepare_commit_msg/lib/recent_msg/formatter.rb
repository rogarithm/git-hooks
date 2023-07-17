module RecentMsg
  class Formatter

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
  end
end
