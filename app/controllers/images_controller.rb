require 'securerandom'

class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  # GET /images
  # GET /images.json
  def index
    @images = Image.all
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    uploaded_file = image_params.first
    original_filename = uploaded_file.original_filename

    hash_val = SecureRandom.alphanumeric(32)
    hashed_path = "images/#{hash_val}#{File.extname(original_filename)}"
    output_path = Rails.root.join('public', hashed_path)

    File.open(output_path, 'w+b') do |f|
      f.write uploaded_file.read
    end

    Image.create(filename: original_filename, path: hashed_path, hash_val: hash_val, content_type: uploaded_file.content_type)

    redirect_to action: :index
    # @image = Image.new(image_params)

    # respond_to do |format|
    #   if @image.save
    #     format.html { redirect_to @image, notice: 'Image was successfully created.' }
    #     format.json { render :show, status: :created, location: @image }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @image.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

def download
  image = Image.find_by_hash_val params[:hash]
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      # params.require(:image).permit(:filename, :path, :hash_val)
      params.require(:file)
    end
end
