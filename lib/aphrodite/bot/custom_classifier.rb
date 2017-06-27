require "aphrodite/bot/custom_classifier/get_classifiers_top_level_brief"
require "aphrodite/bot/custom_classifier/get_classifiers_top_level_verbose"

module Aphrodite
  module Bot
    class CustomClassifier < Olimpo::Base
      def self.create(query = {}, formData = {})
        input_file = File.new(query[:file])
        response = post("/classifiers?", query: query, formData: formData)

        parsed_response = JSON.parse(response.body)
        return Aphrodite::Bot::GetClassifiersTopLevelVerbose.new(parsed_response) if response.success?
        raise_exception(response.code, response.body)
      end

      def self.all(query = {})
        response = get("/classifiers?", query: query)
        parsed_response = JSON.parse(response.body)

        if(!query[:verbose])
          return Aphrodite::Bot::GetClassifiersTopLevelBrief.new(parsed_response) if response.success?
        else
          return Aphrodite::Bot::GetClassifiersTopLevelVerbose.new(parsed_response) if response.success?
        end
        raise_exception(response.code, response.body)
      end

      def self.find(id, query = {})
        response = get("/classifier/#{id}", query: query)

        parsed_response = JSON.parse(response.body)
        return Aphrodite::Bot::GetClassifiersPerClassifierVerbose.new(parsed_response) if response.success?
        raise_exception(response.code, response.body)
      end

      def self.update(id, query = {}, formData = {})
        input_file = File.new(query[:file])
        response = post("/classifier/#{id}", query: query, formData: formData)
        parsed_response = JSON.parse(response.body)

        return Aphrodite::Bot::GetClassifiersPerClassifierVerbose.new(parsed_response) if response.success?
        raise_exception(response.code, response.body)
      end

      def self.destroy(id, query = {})
        response = delete("/classifier/#{id}", query: query)
        response.success?
      end
    end
  end
end
