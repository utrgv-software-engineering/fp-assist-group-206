class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy register drop]
  
  # GET /courses or /courses.json
  def index
    if !user_signed_in?
      redirect_to new_user_session_path
    end
  end

  # GET /courses/1 or /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to course_url(@course), notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to course_url(@course), notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy!

    respond_to do |format|
      format.html { redirect_to courses_url, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # POST /courses/1/users/1
  def register
    if current_user.email == "teacher@teacher.com"
      redirect_to root_path
    end

    current_user.registered_courses.append(@course.id)
    current_user.save
    redirect_back fallback_location: root_path, notice: "Course was successfully registered." 
  end

  # DELETE /courses/1/users/1
  def drop
    current_user.registered_courses.delete(@course.id)
    current_user.save
    redirect_back fallback_location: root_path, notice: "Course was successfully dropped." 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:CRN, :Name, :Description, :Capacity)
    end
end
