module RubyUpdater
  module GitService
    extend self

    def not_present?
      !present?
    end

    def present?
      `git --version`.include?('git version')
    end

    def stash_clear?(folder_path)
      `cd #{folder_path} && git stash list` == ''
    end

    def stash_present?(folder_path)
      !stash_clear?(folder_path)
    end

    def branch_name(folder_path)
      `cd #{folder_path} && git status`.split("\n").first.gsub('On branch ', '')
    end

    def changes_pending?(folder_path)
      !nothing_to_commit?(folder_path)
    end

    def nothing_to_commit?(folder_path)
      `cd #{folder_path} && git status`.include?('nothing to commit, working tree clean')
    end

    def not_a_repo?(folder_path)
      `cd #{folder_path} && git status`.include?('fatal: not a git repository')
    end

    # This can be dangerous. Check #changes_pending? before making
    # destructive changes or roll-backs
    def reset_changes(folder_path)
      return if not_present?
      return unless changes_pending?(folder_path)

      `cd #{folder_path} && git stash && git stash clear`
    end
  end
end
