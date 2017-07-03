require 'spec_helper'

describe Aphrodite::Bot::VisualRecognizer do

  it 'parses #classify_from_url response' do
    allow(Aphrodite::Bot::VisualRecognizer).to receive(:get).and_return(ExampleResponse.new("classify_from_url"))

    # With only required params
    params = {
      url: "https://avatars0.githubusercontent.com/u/2523244?v=3&s=200"
    }

    response = Aphrodite::Bot::VisualRecognizer.classify_from_url(params)

    #Response attributes
    expect(response.custom_classes).to eq 0
    expect(response.images_processed).to eq 1

    #images
    images = response.images
    expect(images).to be_a_kind_of(Array)

    #image
    image = images[0]
    expect(image).to be_a_kind_of(Aphrodite::Bot::VisualRecognizer::Image)
    expect(image.classifiers).to be_a_kind_of(Array)
    expect(image.resolved_url).to eq("https://avatars0.githubusercontent.com/u/2523244?v=3&s=200")
    expect(image.source_url).to eq("https://avatars0.githubusercontent.com/u/2523244?v=3&s=200")
    expect(image).to_not respond_to(:image)

    #Classifier
    classifier = image.classifiers[0]
    expect(classifier.classes).to be_a_kind_of(Array)
    expect(classifier.classifier_id).to eq("default")
    expect(classifier.name).to eq("default")

    #Class
    klass = classifier.classes[0]
    expect(klass).to be_a_kind_of(Aphrodite::Bot::VisualRecognizer::Class)
    expect(klass.class_name).to eq("flag")
    expect(klass.score).to eq(0.354344)
  end

  it 'parses #classify response with a single image file' do
    params = {
      images_file: image_file_fixture,
    }

    allow(Aphrodite::Bot::VisualRecognizer).to receive(:post)
                                                .with("/classify",
                                                      {:body=> params,
                                                       :headers=> {"Accept-Language"=>"en"},
                                                       :query=> {:version=>"2016-09-20"}})
                                                .and_return(ExampleResponse.new("classify_with_single_image_file"))

    response = Aphrodite::Bot::VisualRecognizer.classify(params)

    #Response attributes
    expect(response.custom_classes).to eq 0
    expect(response.images_processed).to eq 1

    #images
    images = response.images
    expect(images).to be_a_kind_of(Array)

    #image
    image = images[0]
    expect(image).to be_a_kind_of(Aphrodite::Bot::VisualRecognizer::Image)
    expect(image.classifiers).to be_a_kind_of(Array)
    expect(image.image).to eq("profile.jpg")
    expect(image).to_not respond_to(:resolved_url)
    expect(image).to_not respond_to(:source_url)

    #Classifier
    classifier = image.classifiers[0]
    expect(classifier.classes).to be_a_kind_of(Array)
    expect(classifier.classifier_id).to eq("default")
    expect(classifier.name).to eq("default")

    #Class
    klass = classifier.classes[0]
    expect(klass).to be_a_kind_of(Aphrodite::Bot::VisualRecognizer::Class)
    expect(klass.class_name).to eq("person")
    expect(klass.score).to eq(1.0)
    expect(klass.type_hierarchy).to eq("/people")
  end

  it 'parses #classify response with an images zip' do
    params = {
      images_file: images_zip_fixture
    }

    allow(Aphrodite::Bot::VisualRecognizer).to receive(:post).with("/classify",
                                                                    {:body => params,
                                                                     :headers => {"Accept-Language"=>"en"},
                                                                     :query => {:version=>"2016-09-20"}})
                                                             .and_return(ExampleResponse.new("classify_with_an_images_zip"))

    response = Aphrodite::Bot::VisualRecognizer.classify(params)

    #Response attributes
    expect(response.custom_classes).to eq 0
    expect(response.images_processed).to eq 4

    #images
    images = response.images
    expect(images).to be_a_kind_of(Array)

    #image
    image = images[0]
    expect(image).to be_a_kind_of(Aphrodite::Bot::VisualRecognizer::Image)
    expect(image.classifiers).to be_a_kind_of(Array)
    expect(image.image).to eq("Archive.zip/profile.jpg")
    expect(image).to_not respond_to(:resolved_url)
    expect(image).to_not respond_to(:source_url)

    #image with error
    image_with_error = images[1]
    expect(image_with_error).to be_a_kind_of(Aphrodite::Bot::VisualRecognizer::Image)
    expect(image_with_error.image).to eq("Archive.zip/__MACOSX/._profile.jpg")
    expect(image_with_error).to_not respond_to(:classifiers)
    expect(image_with_error).to_not respond_to(:resolved_url)
    expect(image_with_error).to_not respond_to(:source_url)

    error = image_with_error.error
    expect(error).to be_a_kind_of(Aphrodite::Bot::VisualRecognizer::ImageError)
    expect(error.description).to eq("Invalid image data. Supported formats are JPG and PNG.")
    expect(error.error_id).to eq("input_error")


    #Classifier
    classifier = image.classifiers[0]
    expect(classifier.classes).to be_a_kind_of(Array)
    expect(classifier.classifier_id).to eq("default")
    expect(classifier.name).to eq("default")

    #Class
    klass = classifier.classes[0]
    expect(klass).to be_a_kind_of(Aphrodite::Bot::VisualRecognizer::Class)
    expect(klass.class_name).to eq("person")
    expect(klass.score).to eq(1.0)
    expect(klass.type_hierarchy).to eq("/people")
  end

  class ExampleResponse

    def initialize(method)
      @method = method
    end

    def success?
      true
    end

    def body
      return classify_from_url_response if @method == "classify_from_url"
      return classify_with_single_image_file_response if @method == "classify_with_single_image_file"
      return classify_with_an_images_zip_response if @method == "classify_with_an_images_zip"
    end

    private

      def classify_from_url_response
        {"custom_classes"=>0,
         "images"=>
          [{"classifiers"=>
             [{"classes"=>[{"class"=>"flag", "score"=>0.354344}],
               "classifier_id"=>"default",
               "name"=>"default"}],
            "resolved_url"=>"https://avatars0.githubusercontent.com/u/2523244?v=3&s=200",
            "source_url"=>"https://avatars0.githubusercontent.com/u/2523244?v=3&s=200"}],
         "images_processed"=>1}.to_json
      end

      def classify_with_single_image_file_response
        {"custom_classes"=>0,
         "images"=>
          [{"classifiers"=>
             [{"classes"=>[{"class"=>"person", "score"=>1.0, "type_hierarchy"=>"/people"}],
               "classifier_id"=>"default",
               "name"=>"default"}],
            "image"=>"profile.jpg"}],
         "images_processed"=>1}.to_json
      end

      def classify_with_an_images_zip_response
        {"custom_classes"=>0,
         "images"=>
          [{"classifiers"=>
             [{"classes"=>[{"class"=>"person", "score"=>1.0, "type_hierarchy"=>"/people"}],
               "classifier_id"=>"default",
               "name"=>"default"}],
            "image"=>"Archive.zip/profile.jpg"},
           {"error"=>
             {"description"=>"Invalid image data. Supported formats are JPG and PNG.",
              "error_id"=>"input_error"},
            "image"=>"Archive.zip/__MACOSX/._profile.jpg"},
           {"classifiers"=>
             [{"classes"=>[{"class"=>"person", "score"=>1.0, "type_hierarchy"=>"/people"}],
               "classifier_id"=>"default",
               "name"=>"default"}],
            "image"=>"Archive.zip/profile2.jpg"},
           {"error"=>
             {"description"=>"Invalid image data. Supported formats are JPG and PNG.",
              "error_id"=>"input_error"},
            "image"=>"Archive.zip/__MACOSX/._profile2.jpg"}],
         "images_processed"=>4}.to_json
      end
  end

  def fixture_path(filename)
    File.join(File.dirname(__FILE__), "..", "fixtures", filename)
  end

  def image_file_fixture
    File.open(fixture_path("icalialabs.jpeg"))
  end

  def images_zip_fixture
    File.open(fixture_path("archive.zip"))

  end
end
