# frozen_string_literal: true

require 'webmock'

require_relative '../../lib/stubs/stubs'

if Rails.env.test?
  # WebMock.disable_net_connect!(allow_localhost: true)

  # url = Addressable::Template.new "https://api.github.com/repositories/{id}/commits"
  WebMock.stub_request(:any, 'https://api.github.com/user/repos?sort=asc&type=owner')
    .with(
      headers: {
        'Accept' => 'application/vnd.github.v3+json',
        'User-Agent' => 'Octokit Ruby Gem 10.0.0'
      }
    )
    .to_return(status: 200, body: Stubs.generate_fake_github_repo, headers: {})

  url = Addressable::Template.new 'https://api.github.com/repositories/{id}/commits'
  WebMock.stub_request(:any, url)
         .with(
           headers: {
             'Accept' => 'application/vnd.github.v3+json',
             'User-Agent' => 'Octokit Ruby Gem 10.0.0'
           }
         )
         .to_return(status: 200, body: Stubs.generate_fake_github_commit, headers: {})

  # url = Addressable::Template.new "https://api.github.com/repositories/{id}/commits"
  WebMock.stub_request(:any, 'https://api.github.com/user/repos?sort=asc&type=owner')
         .with(
           headers: {
             'Accept' => 'application/vnd.github.v3+json',
             'User-Agent' => 'Octokit Ruby Gem 10.0.0'
           }
         )
         .to_return(status: 200, body: Stubs.generate_fake_github_repo, headers: {})

  # url = Addressable::Template.new "https://api.github.com/repositories/{id}/commits"
  WebMock.stub_request(:any, 'https://api.github.com/user')
         .with(
           headers: {
             'Accept' => 'application/vnd.github.v3+json',
             'User-Agent' => 'Octokit Ruby Gem 10.0.0'
           }
         )
         .to_return(status: 200, body: Stubs.generate_fake_github_user, headers: {})

  url = Addressable::Template.new 'https://api.github.com/repos/{id1}/{id2}/languages'
  WebMock.stub_request(:any, url)
         .with(
           headers: {
             'Accept' => 'application/vnd.github.v3+json',
             'User-Agent' => 'Octokit Ruby Gem 10.0.0'
           }
         )
         .to_return(status: 200, body: Stubs.generate_fake_languages, headers: {})

  url = Addressable::Template.new 'https://api.github.com/repositories/{id}/hooks'
  WebMock.stub_request(:get, url)
         .with(
           headers: {
             'Accept' => 'application/vnd.github.v3+json',
             'User-Agent' => 'Octokit Ruby Gem 10.0.0'
           }
         )
         .to_return(status: 200, body: Stubs.generate_fake_github_hooks_response, headers: {})
end
