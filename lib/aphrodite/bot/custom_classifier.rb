require "aphrodite/bot/custom_classifier/get_classifiers_top_level_brief"
require "aphrodite/bot/custom_classifier/get_classifiers_top_level_verbose"

module Aphrodite
  module Bot
    class CustomClassifier < Olimpo::Base
      def self.create(query = {}, form_data = {})
        response = post("/classifiers", query: query, body: form_data)

        parsed_response = JSON.parse(response.body)
        return Aphrodite::Bot::CustomClassifier::GetClassifiersPerClassifierVerbose.new(parsed_response) if response.success?
        raise_exception(response.code, response.body)
      end

      def self.all(query = {})
        response = get("/classifiers", query: query)
        parsed_response = JSON.parse(response.body)

        if(!query[:verbose])
          return Aphrodite::Bot::CustomClassifier::GetClassifiersTopLevelBrief.new(parsed_response) if response.success?
        else
          return Aphrodite::Bot::CustomClassifier::GetClassifiersTopLevelVerbose.new(parsed_response) if response.success?
        end
        raise_exception(response.code, response.body)
      end

      def self.find(id, query = {})
        response = get("/classifiers/#{id}", query: query)

        parsed_response = JSON.parse(response.body)
        return Aphrodite::Bot::CustomClassifier::GetClassifiersPerClassifierVerbose.new(parsed_response) if response.success?
        raise_exception(response.code, response.body)
      end

      def self.update(id, query = {}, form_data = {})
        response = post("/classifiers/#{id}", query: query, body: form_data)
        parsed_response = JSON.parse(response.body)

        return Aphrodite::Bot::CustomClassifier::GetClassifiersPerClassifierVerbose.new(parsed_response) if response.success?
        raise_exception(response.code, response.body)
      end

      def self.destroy(id, query = {})
        response = delete("/classifiers/#{id}", query: query)
        response.success?
      end
    end
  end
end
