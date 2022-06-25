module RubyUpdater
  class Cli
    attr_reader :args, :folder_path

    def initialize(args)
      @args = args
      @folder_path = args[0]
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
      puts "Folder path: #{folder_path}"

      abort 'git is not installed!' if RubyUpdater::GitService.not_present?
      abort 'Destination folder is not a git repo!' if RubyUpdater::GitService.not_a_repo?(folder_path)
      abort 'Destination folder has pending changes!' if RubyUpdater::GitService.changes_pending?(folder_path)

      # Check Gems with static version numbers
      gems_needing_updates = find_gem_updates_from_file
      puts "Gems are up-to-date! :)" if gems_needing_updates == []

      # Check that the Gemfile.lock has no updates
      RubyUpdater::BundlerService.remove_lockfile(folder_path)
      RubyUpdater::BundlerService.install(folder_path)
      RubyUpdater::BundlerService.update(folder_path)

      # Get Changes

      # Reset changes
      # TODO: Make this safe check for stash before!
      RubyUpdater::GitService.reset_changes(folder_path)
      binding.pry
    end

    private

    def find_gem_updates_from_file
      list_of_static_gems = RubyUpdater::BundlerService
        .current_gemfile_gems_with_specified_versions(folder_path)

      list_of_static_gems.map { |name, local_version|
        current_version = RubyUpdater::RubygemsService.latest_version(name)
        next if local_version == current_version

        [name, local_version, current_version]
      }.compact
    end
  end
end
