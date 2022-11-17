# frozen_string_literal: true

require 'bundler/setup'
Bundler.setup

require 'hubspot_client'

require 'dotenv'
require 'pry'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('<BEARER_TOKEN>') { |interaction|
    auths = interaction.request.headers['Authorization'].first
    if (match = auths.match /^Bearer\s+([^,\s]+)/ )
      match.captures.first
    end
  }
end

Dotenv.load

RSpec.configure do |config|
  config.warnings = true
  config.order = :random
end

HubspotClient.configure do |config|
  config.access_token = ENV['ACCESS_TOKEN']
end