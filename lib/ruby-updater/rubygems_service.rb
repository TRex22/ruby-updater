module RubyUpdater
  module RubygemsService
    extend self

    BASE_API_PATH = 'https://rubygems.org/api/v1/'

    #  /api/v1/rubygems/[GEM NAME]/versions/
    #  /api/v1/rubygems/[GEM NAME]/versions/[VERSION NUMBER]
    def versions(name)
      HTTParty.get(
        "#{BASE_API_PATH}/versions/#{name}.json",
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    def latest_version(name)
      HTTParty.get(
        "#{BASE_API_PATH}/versions/#{name}/latest.json",
        headers: { 'Content-Type' => 'application/json' }
      ).dig("version")
    end
  end
end
