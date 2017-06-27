require 'spec_helper'
require 'pry'

describe Aphrodite::Bot::CustomClassifier do
  describe "API Methods" do
    describe ".create" do
      before :each do
        stub_response = CustomClassifierExampleResponse.new
        allow(Aphrodite::Bot::CustomClassifier).to receive(:post).and_return(stub_response)
        allow(File).to receive(:new).and_return("")
      end
      it "should return information about the new custom classifier" do
        expect(Aphrodite::Bot::CustomClassifier.create(file: "")).to be_a_kind_of(Aphrodite::Bot::GetClassifiersTopLevelVerbose)
      end
    end

    describe ".all" do
      before :each do
        stub_response = ListOfCustomClassifiersExampleResponse.new
        allow(Aphrodite::Bot::CustomClassifier).to receive(:get).and_return(stub_response)
      end
      it "should return a list of the custom classifiers" do
        expect(Aphrodite::Bot::CustomClassifier.all).to be_a_kind_of(Aphrodite::Bot::GetClassifiersTopLevelVerbose)
      end
    end

    describe ".find" do
      before :each do
        stub_response = CustomClassifierExampleResponse.new
        allow(Aphrodite::Bot::CustomClassifier).to receive(:get).and_return(stub_response)
      end
      it "should return information about a specific classifier" do
        expect(Aphrodite::Bot::CustomClassifier.find("")).to be_a_kind_of(Aphrodite::Bot::GetClassifiersPerClassifierVerbose)
      end
    end

    describe ".update" do
      before :each do
        stub_response = CustomClassifierExampleResponse.new
        allow(Aphrodite::Bot::CustomClassifier).to receive(:post).and_return(stub_response)
        allow(File).to receive(:new).and_return("")
      end
      it "should return information about the updated custom classifier" do
        expect(Aphrodite::Bot::CustomClassifier.update(file: "")).to be_a_kind_of(Aphrodite::Bot::GetClassifiersPerClassifierVerbose)
      end
    end

    describe ".destroy" do
      before :each do
        stub_response = DeleteCustomClassifierExampleResponse.new
        allow(Aphrodite::Bot::CustomClassifier).to receive(:delete).and_return(stub_response)
      end
      it "should delete a custom classifier" do
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

class ListOfCustomClassifiersExampleResponse
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
