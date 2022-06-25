module RubyUpdater
  module BundlerService
    extend self

    THREE_DIGIT_VALUE = /\d+.\d+.\d+/
    TWO_DIGIT_VALUE = /\d+.\d+/

    def not_present?
      !present?
    end

    def present?
      `bundle --version`.include?('Bundler version')
    end

    def gemspec_present?(folder_path)
      `cd #{folder_path} && ls |grep .gemspec`.include?('.gemspec')
    end

    def gemfile_present?(folder_path)
      `cd #{folder_path} && ls |grep Gemfile`.include?('Gemfile')
    end

    def current_gemfile_gems_with_specified_versions(folder_path)
      if gemspec_present?(folder_path)
        filename = `cd #{folder_path} && ls |grep *.gemspec`.split("\n").first
        return if filename == ''

        lines = File.read("#{folder_path}/#{filename}").split("\n")
        process_gemspec(lines)
      elsif gemfile_present?(folder_path)
        lines = File.read("#{folder_path}/Gemfile").split("\n")
        process_gemfile(lines)
      end
    end

    def remove_lockfile(folder_path)
      `cd #{folder_path} && rm Gemfile.lock`
    end

    def install(folder_path)
      `cd #{folder_path} && bundle install`
    end

    def update(folder_path)
      `cd #{folder_path} && bundle update`
    end

    private

    def process_gemspec(lines)
      lines
        .map(&:strip)
        .reject { |line| line[0] == '#' || line.include?('git:') }
        .select { |line| line.include?('spec.add_dependency') || line.include?('spec.add_development_dependency') }
        .map { |line| line.gsub('spec.add_dependency ', '') }
        .map { |line| line.gsub('spec.add_development_dependency ', '') }
        .map { |line|
          split_line = line.split("', '")
          name = split_line[0].gsub("'", '')

          version = line.match(THREE_DIGIT_VALUE).to_s
          version = line.match(TWO_DIGIT_VALUE).to_s if version == ''

          next if version == ''

          [name, version]
        }.compact
    end

    def process_gemfile(lines)
      lines
        .map(&:strip)
        .reject { |line| line[0] == '#' || line.include?('git:') }
        .select { |line| line.include?("gem '") || line.include?("gem \"") }
        .map { |line|
          # split_line = line.gsub("gem '", '').split("', '")
          split_line = line.gsub("gem '", '').gsub("  gem \"", '').gsub("gem '", '').gsub("\"", "'").split("', '")
          name = split_line[0].gsub("'", '')

          version = line.match(THREE_DIGIT_VALUE).to_s
          version = version.match(TWO_DIGIT_VALUE).to_s if version == ''

          next if version == ''

          [name, version]
        }.compact
    end
  end
end
