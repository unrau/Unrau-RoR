# Run to re-save all articles
# Use to fix 'unititialized constant' error with FriendlyID

# rake articles:save
# rake articles:save RAILS_ENV=production

require 'rake'
namespace :articles do
  desc "Save all articles"
  task :save => :environment do
    puts "--- Saving articles ---"
    Article.find_each(&:save)
    puts "All articles have been saved.\n"
  end
end 
