require 'spec_helper'
require 'pry'

describe Aphrodite::Bot::CustomClassifier do
  describe "API Methods" do
    describe ".create" do
      it "should return information about the new custom classifier" do
        stub_response = CustomClassifierExampleResponse.new
        allow(Aphrodite::Bot::CustomClassifier).to receive(:post).and_return(stub_response)
        allow(File).to receive(:new).and_return("")

        expect(Aphrodite::Bot::CustomClassifier.create(file: "")).to be_a_kind_of(Aphrodite::Bot::GetClassifiersTopLevelVerbose)
      end
    end

    describe ".all" do
      it "should return a brief list of the custom classifiers" do
        stub_response = ListOfBriefCustomClassifiersExampleResponse.new
        allow(Aphrodite::Bot::CustomClassifier).to receive(:get).and_return(stub_response)

        expect(Aphrodite::Bot::CustomClassifier.all()).to be_a_kind_of(Aphrodite::Bot::GetClassifiersTopLevelBrief)
      end
      it "should return a verbose list of the custom classifiers" do
        stub_response = ListOfVerboseCustomClassifiersExampleResponse.new
        allow(Aphrodite::Bot::CustomClassifier).to receive(:get).and_return(stub_response)

        expect(Aphrodite::Bot::CustomClassifier.all(verbose: true)).to be_a_kind_of(Aphrodite::Bot::GetClassifiersTopLevelVerbose)
      end
    end

    describe ".find" do
      it "should return information about a specific classifier" do
        stub_response = CustomClassifierExampleResponse.new
        allow(Aphrodite::Bot::CustomClassifier).to receive(:get).and_return(stub_response)

        expect(Aphrodite::Bot::CustomClassifier.find("")).to be_a_kind_of(Aphrodite::Bot::GetClassifiersPerClassifierVerbose)
      end
    end

    describe ".update" do
      it "should return information about the updated custom classifier" do
        stub_response = CustomClassifierExampleResponse.new
        allow(Aphrodite::Bot::CustomClassifier).to receive(:post).and_return(stub_response)
        allow(File).to receive(:new).and_return("")

        expect(Aphrodite::Bot::CustomClassifier.update(file: "")).to be_a_kind_of(Aphrodite::Bot::GetClassifiersPerClassifierVerbose)
      end
    end

    describe ".destroy" do
      it "should delete a custom classifier" do
        stub_response = DeleteCustomClassifierExampleResponse.new
        allow(Aphrodite::Bot::CustomClassifier).to receive(:delete).and_return(stub_response)
        
        expect(Aphrodite::Bot::CustomClassifier.destroy("")).to eq(true)
      end
    end
  end
end

class CustomClassifierExampleResponse
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

class ListOfBriefCustomClassifiersExampleResponse
  def body
    '{
      "classifiers": [
        {
          "classifier_id": "string",
          "name": "string"
        },
        {
          "classifier_id": "string",
          "name": "string"
        }
      ]
     }'
  end

  def success?
    true
  end
end

class ListOfVerboseCustomClassifiersExampleResponse
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
        },
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

class DeleteCustomClassifierExampleResponse
  def success?
    true
  end
end
