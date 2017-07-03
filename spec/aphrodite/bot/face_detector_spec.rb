require 'spec_helper'
require 'pry'

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
    expect(image).to_not respond_to(:image)

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

  it 'parses #detect response with a single image file' do
    params = {
      images_file: face_image_fixture,
    }

    allow(Aphrodite::Bot::FaceDetector).to receive(:post)
                                                .with("/detect_faces",
                                                      {:body=> params,
                                                       :headers=> {"Accept-Language"=>"en"},
                                                       :query=> {:version=>"2016-09-20"}})
                                                .and_return(FaceDetectorExampleResponse.new("detect_with_a_single_image_file"))


    response = Aphrodite::Bot::FaceDetector.detect(params)

    #Response attributes
    expect(response.images_processed).to eq 1

    #images
    images = response.images
    expect(images).to be_a_kind_of(Array)

    #image
    image = images[0]
    expect(image).to be_a_kind_of(Aphrodite::Bot::FaceDetector::Image)
    expect(image.image).to eq("cejas.png")
    expect(image).to_not respond_to(:resolved_url)
    expect(image).to_not respond_to(:source_url)

    #faces
    faces = image.faces
    expect(faces).to be_a_kind_of(Array)

    #face
    face = faces[0]
    age = face.age
    expect(age).to be_a_kind_of(Aphrodite::Bot::FaceDetector::Face::Age)
    expect(age.max).to eq 2
    expect(age.min).to eq 1
    expect(age.score).to eq 1

    location = face.face_location
    expect(location).to be_a_kind_of(Aphrodite::Bot::FaceDetector::Face::Location)
    expect(location.height).to eq 100
    expect(location.left).to eq 100
    expect(location.top).to eq 100
    expect(location.width).to eq 100

    gender = face.gender
    expect(gender).to be_a_kind_of(Aphrodite::Bot::FaceDetector::Face::Gender)
    expect(gender.gender).to eq "MALE"
    expect(gender.score).to eq 1
  end

  it 'parses #detect response with a zip file' do
    params = {
      images_file: images_zip_fixture,
    }

    allow(Aphrodite::Bot::FaceDetector).to receive(:post)
                                                .with("/detect_faces",
                                                      {:body=> params,
                                                       :headers=> {"Accept-Language"=>"en"},
                                                       :query=> {:version=>"2016-09-20"}})
                                                .and_return(FaceDetectorExampleResponse.new("detect_with_images_zip"))


    response = Aphrodite::Bot::FaceDetector.detect(params)

    #Response attributes
    expect(response.images_processed).to eq 4

    #images
    images = response.images
    expect(images).to be_a_kind_of(Array)

    #image
    image = images[0]
    expect(image).to be_a_kind_of(Aphrodite::Bot::FaceDetector::Image)
    expect(image.image).to eq("Archive.zip/profile.jpg")
    expect(image).to_not respond_to(:resolved_url)
    expect(image).to_not respond_to(:source_url)
    expect(image).to_not respond_to(:error)

    #faces
    faces = image.faces
    expect(faces).to be_a_kind_of(Array)

    #face
    face = faces[0]
    age = face.age
    expect(age).to be_a_kind_of(Aphrodite::Bot::FaceDetector::Face::Age)
    expect(age.max).to eq 2
    expect(age.min).to eq 1
    expect(age.score).to eq 1

    location = face.face_location
    expect(location).to be_a_kind_of(Aphrodite::Bot::FaceDetector::Face::Location)
    expect(location.height).to eq 100
    expect(location.left).to eq 100
    expect(location.top).to eq 100
    expect(location.width).to eq 100

    gender = face.gender
    expect(gender).to be_a_kind_of(Aphrodite::Bot::FaceDetector::Face::Gender)
    expect(gender.gender).to eq "MALE"
    expect(gender.score).to eq 1

    #image_with_error
    image_with_error = images[1]
    expect(image_with_error).to be_a_kind_of(Aphrodite::Bot::FaceDetector::Image)
    expect(image_with_error.image).to eq("Archive.zip/__MACOSX/._profile.jpg")
    expect(image_with_error).to_not respond_to(:faces)
    expect(image_with_error).to_not respond_to(:resolved_url)
    expect(image_with_error).to_not respond_to(:source_url)

    error = image_with_error.error
    expect(error).to be_a_kind_of(Aphrodite::Bot::VisualRecognizer::ImageError)
    expect(error.description).to eq("Invalid image data. Supported formats are JPG and PNG.")
    expect(error.error_id).to eq("input_error")
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
      return detect_with_a_single_image_file_response if @method == "detect_with_a_single_image_file"
      return detect_with_images_zip_response if @method == "detect_with_images_zip"
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

      def detect_with_a_single_image_file_response
        {"images"=>
          [{"faces"=>
             [{"age"=>{"max"=>2, "min"=>1, "score"=>1},
               "face_location"=>{"height"=>100, "left"=>100, "top"=>100, "width"=>100},
               "gender"=>{"gender"=>"MALE", "score"=>1}}],
            "image"=>"cejas.png"}],
         "images_processed"=>1}.to_json
      end

      def detect_with_images_zip_response
        {"images"=>
          [{"faces"=>
            [{"age"=>{"max"=>2, "min"=>1, "score"=>1},
              "face_location"=>{"height"=>100, "left"=>100, "top"=>100, "width"=>100},
              "gender"=>{"gender"=>"MALE", "score"=>1}}],
           "image"=>"Archive.zip/profile.jpg"},
           {"error"=>{"description"=>"Invalid image data. Supported formats are JPG and PNG.", "error_id"=>"input_error"},
            "image"=>"Archive.zip/__MACOSX/._profile.jpg"}
          ],
         "images_processed"=>4}.to_json
      end
  end

  def fixture_path(filename)
    File.join(File.dirname(__FILE__), "..", "fixtures", filename)
  end

  def face_image_fixture
    File.open(fixture_path("cejas.png"))
  end

  def images_zip_fixture
    File.open(fixture_path("archive.zip"))

  end
end
