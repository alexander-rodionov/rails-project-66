# frozen_string_literal: true

namespace :db do
  task reset: :environment do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:schema:load'].invoke
    Rake::Task['db:seed'].invoke
  end
end
