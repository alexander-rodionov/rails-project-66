# frozen_string_literal: true

require 'test_helper'

class GitServiceTest < ActiveSupport::TestCase
  fixtures :users

  test 'do something' do
    # StorageManagementService.clean_up_directories
    clone_dir = 'tmp/repos/360580cc-b92d-4473-9129-ac718a8a8457' #= p gs.clone('rails-project-66')
    repo_name = 'rails-project-66'
    gs = GitService.new users(:main)
    languages = gs.repo_languages(repo_name)
    checks = BaseCheckService.checks_factory(languages)

    results = checks.to_h do |c|
      check_result = c.new(clone_dir).check
      [c.language, { success: check_result[0], result: check_result[1] }]
    end
    p results

    # p gs.primary_language('rails-project-66')

    # clone_dir = 'tmp/repos/360580cc-b92d-4473-9129-ac718a8a8457'#= p gs.clone('rails-project-66')
    # clone_dir = gs.clone('rails-project-66')
    # rcs = RubyCheckService.new(clone_dir)
    # p rcs.check
    # rcs = EslintCheckService.new(clone_dir)
    # p rcs.check
  end
end
