require_relative 'options'
require_relative 'formatter'

module RecentMsg
  class Runner
    def initialize(argv)
      @options = Options.new(argv)
      @formatter = Formatter.new
    end

    def show_recent_commit_msgs(commit_num, msgs)
      result = @formatter.format_msgs(commit_num, msgs)
      @formatter.prepend_string(@options.commit_msg_file, result)
      exit 0
    end

    def run
      if @options.commit_source != 'message'
        show_recent_commit_msgs(3, `git log --pretty=format:'%s'`.split("\n"))
      end
    end
  end
end

