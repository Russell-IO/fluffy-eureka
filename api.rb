#!/usr/bin/env ruby
require 'sinatra'
require 'open-uri'
require 'json'

set :bind, '0.0.0.0'
set :port, 8080

def get_atlassian_release(app)
  # Get payload from Atlassian
  json = open("https://my.atlassian.com/download/feeds/current/#{app}.json") { |f| f.read }

  # Parse it & Clean up as Atlassian use non standard JSON...
  data = JSON.parse(json.dup.gsub("downloads(", "")[0...-1])

  # Filter down to unix results
  unix = data.select {|i| i['platform'] == 'Unix' }.select {|i| i['zipUrl'].include?('x64')}

  # select the latest release number
  latest = unix.max {|a,b| a['version'] <=> b['version'] }
  return {
    "version" => latest['version'],
    "url" => latest['zipUrl'],
    "released" => latest['released']
  }

end

get '/:app' do
  app = params['app']
  get_atlassian_release(app).to_json
end
