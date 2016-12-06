require 'spec_helper'

describe Aphrodite::Bot::FaceDetector do

  it 'parses #detect_from_url response' do
    allow(Aphrodite::Bot::FaceDetector).to receive(:get).and_return(FaceDetectorExampleResponse.new("detect_from_url"))

    params = {
      url: "https://avatars0.githubusercontent.com/u/944683?v=3&s=460"
    }

    response = Aphrodite::Bot::FaceDetector.detect_from_url(params)

    #Response attributes
    expect(response.images_processed).to eq 1

    #images
    images = response.images
    expect(images).to be_a_kind_of(Array)

    #image
    image = images[0]
    expect(image).to be_a_kind_of(Aphrodite::Bot::FaceDetector::Image)
    expect(image.resolved_url).to eq("https://avatars0.githubusercontent.com/u/944683?v=3&s=460")
    expect(image.source_url).to eq("https://avatars0.githubusercontent.com/u/944683?v=3&s=460")

    #faces
    faces = image.faces
    expect(faces).to be_a_kind_of(Array)

    #face
    face = faces[0]
    age = face.age
    expect(age).to be_a_kind_of(Aphrodite::Bot::FaceDetector::Face::Age)
    expect(age.max).to eq 44
    expect(age.min).to eq 35
    expect(age.score).to eq 0.436882

    location = face.face_location
    expect(location).to be_a_kind_of(Aphrodite::Bot::FaceDetector::Face::Location)
    expect(location.height).to eq 185
    expect(location.left).to eq 144
    expect(location.top).to eq 167
    expect(location.width).to eq 176

    gender = face.gender
    expect(gender).to be_a_kind_of(Aphrodite::Bot::FaceDetector::Face::Gender)
    expect(gender.gender).to eq "MALE"
    expect(gender.score).to eq 0.993307
  end

  class FaceDetectorExampleResponse

    def initialize(method)
      @method = method
    end

    def success?
      true
    end

    def body
      return detect_from_url_response if @method == "detect_from_url"
    end

    private

      def detect_from_url_response
        {"images"=>
        [{"faces"=>
           [{"age"=>{"max"=>44, "min"=>35, "score"=>0.436882},
             "face_location"=>{"height"=>185, "left"=>144, "top"=>167, "width"=>176},
             "gender"=>{"gender"=>"MALE", "score"=>0.993307}}],
          "resolved_url"=>"https://avatars0.githubusercontent.com/u/944683?v=3&s=460",
          "source_url"=>"https://avatars0.githubusercontent.com/u/944683?v=3&s=460"}],
       "images_processed"=>1}.to_json
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
