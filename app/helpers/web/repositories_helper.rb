module Web::RepositoriesHelper
  def available_projects
    [ 
      ["name1", 1],
      ["name2", 2],
      ["name3", 3],
    ]
  end

  def git_commit_link(check)
    "https://github.com/#{controller.current_user.nickname}/project/commit/#{check.commit_id}"
  end
end