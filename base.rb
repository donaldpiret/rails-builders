class AppBuilder < Rails::AppBuilder
  
  def test
    @generator.gem 'rspec-rails', group: [:test, :development]
  end
  
  def leftovers
    run 'bundle install'
    generate 'rspec:install'
    
    if yes? "Do you want to generate a root controller?"
      name = ask("What should it be called?").underscore
      generate :controller, "#{name} index"
      route "root to: '#{name}\#index'"
      remove_file "public/index.html"
    end
    
    git :init
    append_file ".gitignore", "config/database.yml"
    run "cp config/database.yml config database.yml.example"
    git add: ".", commit: "-m 'initial commit'"
  end
  
end