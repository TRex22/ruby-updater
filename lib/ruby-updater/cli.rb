module RubyUpdater
  class Cli
    attr_reader :args

    def initialize(args)
      @args = args
    end

    def valid?
      return true if args.size == 1
      false
    end

    def invalid?
      !valid?
    end

    def call
      # TODO: Use ConsoleStyle::Functions
      # TODO: Heading and better CLI interface
      # Simple cli for now
      puts "Ruby Updater © Jason Chalom 2022, Version: #{RubyUpdater::VERSION}"
      abort 'Folder path is required!' if invalid?

      # Using default config for now
      original_folder_path = args[0]
    end
  end
end
