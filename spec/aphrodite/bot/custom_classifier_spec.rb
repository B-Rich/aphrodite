require 'spec_helper'
require 'pry'

describe Aphrodite::Bot::CustomClassifier do
  describe "API Methods" do
    describe ".create" do

      before :each do
        stub_response = CreateCustomClassifierExampleResponse.new
        allow(Aphrodite::Bot::CustomClassifier).to receive(:post).and_return(stub_response)
        allow(File).to receive(:new).and_return("")
      end

      it "should return information about the new custom classifier" do
        expect(Aphrodite::Bot::CustomClassifier.create(file: "")).to be_a_kind_of(Aphrodite::Bot::GetClassifiersTopLevelVerbose)
      end
    end
  end
end


class CreateCustomClassifierExampleResponse
  def body
    '{
      "classifiers": [
        {
          "classifier_id": "string",
          "name": "string",
          "owner": "string",
          "status": "string",
          "explanation": "string",
          "created": "string",
          "classes": [
            {
              "class": "string"
            }
          ]
        }
      ]
    }'
  end

  def success?
    true
  end
end