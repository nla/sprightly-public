# Rake task to execute all unit tests
# It purposely clears the prerequisites
# so that rake db:prepare is NOT executed
namespace :sprightly do
  desc "Sprightly Test Tasks for testing"

    task :test_functionals do

      RAILS_ENV = 'test'

      puts "Recreate the test database"
      Rake::Task['db:test:prepare'].invoke

      puts "Seed test database with lookup values"
      Rake::Task['db:fixtures:load'].invoke

      puts "Executing Functional Tests"
      Rake::Task['test:functionals'].prerequisites.clear
      Rake::Task['test:functionals'].invoke
    end

    task :test_units do

      RAILS_ENV = 'test'

      puts "Recreate the test database"
      Rake::Task['db:test:prepare'].invoke

      puts "Seed test database with lookup values"
      Rake::Task['db:fixtures:load'].invoke

      puts "Executing Unit Tests"
      Rake::Task['test:units'].prerequisites.clear
      Rake::Task['test:units'].invoke
    end


    task :test do
      
      Rake::Task['sprightly:test_units'].invoke
      Rake::Task['sprightly:test_functionals'].invoke

    end
  
end