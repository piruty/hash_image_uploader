require 'securerandom'

class ImagesController < ApplicationController
  # GET /images
  def index
    @images = Image.all
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # POST /images
  def create
    uploaded_file = image_params.first
    original_filename = uploaded_file.original_filename

    hash_val = SecureRandom.alphanumeric(32)

    image = Image.new(filename: original_filename, hash_val: hash_val, content_type: uploaded_file.content_type)
    image.uploaded_image.attach uploaded_file
    image.save

    redirect_to action: :index
  end

  def download
    image = Image.find_by_hash_val params[:hash]
    send_data image.uploaded_image.download, type: image.content_type, disposition: 'inline'
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      # params.require(:image).permit(:filename, :path, :hash_val)
      params.require(:file)
    end
end
