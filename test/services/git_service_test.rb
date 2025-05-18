# frozen_string_literal: true

require 'test_helper'

class GitServiceTest < ActiveSupport::TestCase
  fixtures :users

  test 'do something' do
    #StorageManagementService.clean_up_directories
    #gs = GitService.new users(:main)
    clone_dir = 'tmp/repos/f35be4aa-3540-49f9-98d8-fa70a5447bdf'#= p gs.clone('rails-project-66')
    rcs = RubyCheckService.new(clone_dir)
    p rcs.check

  end
end

