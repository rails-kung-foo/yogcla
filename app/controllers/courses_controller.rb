class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, only: [:edit, :update,:destroy, :new, :create]

  # GET /courses
  # GET /courses.json
  def index
		@courses	= Course.filter_by(day: params[:filter_weekday], style: params[:filter_style], studio: params[:filter_studio])
	end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
		@course.studio_id = Studio.find_by(name: course_params[:studio_id]).id
		@course.style_id = Style.find_by(stil: course_params[:style_id]).id

	respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice:"Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      @course.assign_attributes course_params
      @course.assign_attributes studio_id: Studio.find_by(name: course_params[:studio_id]).id,
        style_id: Style.find_by(stil: course_params[:style_id]).id

      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:studio_id, :style_id, :start, :ending, :weekday)
    end

    def filtered_params

    end
end
