module RubyUpdater
  module GitService
    extend self

    def present?
      `git --version`.include?('git version')
    end

    def branch_name(folder_path)
      `cd #{folder_path} && git status`.split("\n").first.gsub('On branch ', '')
    end
  end
end
