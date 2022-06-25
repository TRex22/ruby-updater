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
      folder_path = args[0]
      puts "Folder path: #{folder_path}"

      abort 'git is not installed!' if RubyUpdater::GitService.not_present?
      abort 'Destination folder is not a git repo!' if RubyUpdater::GitService.not_a_repo?(folder_path)
      abort 'Destination folder has pending changes!' if RubyUpdater::GitService.changes_pending?(folder_path)

      find_gem_updates_from_file
      binding.pry
    end

    private

    def find_gem_updates_from_file
      list_of_static_gems = RubyUpdater::BundlerService
        .current_gemfile_gems_with_specified_versions(folder_path)

      list_of_static_gems.map { |name, local_version|
        current_version = RubyUpdater::RubygemsService.latest_version(name)
        [name, local_version, current_version]
      }
    end
  end
end
