require 'database_cleaner'

RSpec.configure do |config|

  config.use_transactional_fixtures = false

  config.filter_rails_from_backtrace!

  if defined? ActiveRecord
    config.before :suite do
      DatabaseCleaner.clean_with :truncation
    end

    config.before :each do
      DatabaseCleaner.strategy = :truncation
    end

    config.around :each do |example|
      DatabaseCleaner.start
      example.run
      DatabaseCleaner.clean
    end
  end

end
