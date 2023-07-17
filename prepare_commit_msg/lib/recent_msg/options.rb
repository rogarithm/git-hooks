module RecentMsg
  class Options
    attr_reader :commit_msg_file, :commit_source, :sha1

    def initialize(argv)
      @commit_msg_file=argv[0]
      @commit_source=argv[1]
      @sha1=argv[2]
    end

    def print_args
      puts "commit_msg_file is #{@commit_msg_file}" #.git/COMMIT_EDITMSG
      puts "commit_source is #{@commit_source}"
      puts "sha1 is #{@sha1}"
    end
  end
end
