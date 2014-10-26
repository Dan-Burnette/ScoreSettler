# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( four_person_tournament.css )
Rails.application.config.assets.precompile += %w( eight_person_tournament.css )
Rails.application.config.assets.precompile += %w( loginPage.css)
Rails.application.config.assets.precompile += %w( userPage.css)
Rails.application.config.assets.precompile += %w( groupPage.css)
Rails.application.config.assets.precompile += %w( layout.css)
Rails.application.config.assets.precompile += %w( playTournament.js)
