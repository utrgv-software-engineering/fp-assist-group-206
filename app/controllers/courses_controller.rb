class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy register drop]
  
  # GET /courses or /courses.json
  def index
    # Check if the user is signed in
    if user_signed_in?
      # Redirect students to registered courses page only once
      if current_user.id != 1 && !session[:redirected_to_registered_courses]
        session[:redirected_to_registered_courses] = true
        redirect_to registered_courses_path(id: current_user.id)
        return
      end
    else
      # Redirect non-signed-in users to sign-in page
      redirect_to new_user_session_path
      return
    end
  
    # Rest of the code for rendering courses for other users
    course_ids = params[:courses]
    if course_ids.present?
      @courses = Course.where(id: course_ids)
    else
      @courses = Course.all
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
    if current_user.id == 1
      redirect_to root_path
    end

    @course.Capacity -= 1
    current_user.registered_courses.append(@course.id)
    current_user.save
    redirect_to root_path, notice: "Course was successfully registered." 
  end

  # DELETE /courses/1/users/1
  def drop
    current_user.registered_courses.delete(@course.id)
    current_user.save
    @course.Capacity += 1
    redirect_to root_path, notice: "Course was successfully dropped." 
  end

  # POST /courses/search
  def search
    crn = params[:crn]
    course_name = params[:course_name]
    if crn.present?
      # Find the course with the specified CRN
      @course = Course.find_by(CRN: crn)
      if @course
        # Set flash message
        flash[:notice] = "Course found with CRN #{crn}."
        # Redirect to the show page for the course
        redirect_to course_path(@course)
      else
        # Handle the case when no course is found with the specified CRN
        flash[:alert] = "No course found with CRN #{crn}."
        redirect_to courses_path
      end
    elsif course_name.present?
      # Search for courses with the specified name or partial name
      @courses = Course.where("Name LIKE ?", "%#{course_name}%")
      if @courses.present?
        # Set flash message
        flash.now[:notice] = "Courses found with Course Name #{course_name}."
        # Render the view with the filtered courses
        redirect_to courses_path(courses: @courses.pluck(:id))
      else
        # Handle the case when no courses are found with the specified name
        flash[:alert] = "No courses found with Course Name #{course_name}."
        redirect_to courses_path
      end
    else
      # Handle the case when no search criteria is provided
      flash[:alert] = "Please provide search criteria."
      redirect_to courses_path
    end
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
