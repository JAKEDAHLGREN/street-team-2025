class AssignmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_users, only: %i[new create edit update]
  before_action :set_assignment, only: %i[show edit update update_wave destroy]

  layout 'application'
  def index
    @q = Assignment.joins(:user).ransack(params[:q])
    @assignments = @q.result

    @business_names = Constants::BUSINESS_NAMES
    @areas = Constants::AREAS
  end

  def show
  end

  def new
    @assignment = Assignment.new
    @users = User.all
  end

  def create
    @assignment = Assignment.new(assignment_params)

    if @assignment.save
      redirect_to  assignments_path, notice: 'Assignment was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @business_names = Constants::BUSINESS_NAMES
    @areas = Constants::AREAS
    @users = User.all
  end

  def update
    @q = Assignment.ransack(params[:q])
    @assignments = @q.result

    respond_to do |format|
      if @assignment.update(assignment_params)
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(
              'assignments_table',
              partial: 'assignments/table',
              locals: { assignments: @assignments, q: @q }
            ),
            turbo_stream.append(
              'flash',
              partial: 'application/flash',
              locals: { message: 'Assignment was successfully updated.', flash_type: 'notice' }
            )
          ]
        end
        format.html { redirect_to assignments_path, notice: 'Assignment was successfully updated.' }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            'assignments_form',
            partial: 'assignments/form',
            locals: { assignment: @assignment }
          )
        end
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def update_wave
    if @assignment.update(assignment_wave_params)
      render turbo_stream: turbo_stream.replace(@assignment, partial: 'assignment',
                                                             locals: {
                                                               assignment: @assignment.reload
                                                             })
    else
      render json: { success: false, errors: @assignment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @assignment.destroy
    redirect_to assignments_path, notice: 'Assignment was deleted successfully.'
  end

  private

  def set_assignment
    @assignment = Assignment.find(params[:id])
  end

  def set_users
    @users = User.all
  end

  def set_assignment
    @assignment = Assignment.find_by(id: params[:id]) # Use find_by to avoid exceptions
    return if @assignment

    redirect_to assignments_path, alert: 'Assignment not found'
  end

  def assignment_params
    params.require(:assignment).permit(:user_id, :area, :business_name, :wave_one, :wave_two, :wave_three,
                                       :other, :notes).transform_values do |value|
      transform_to_boolean(value)
    end
  end

  def transform_to_boolean(value)
    if %w[true false 1 0].include?(value)
      ActiveModel::Type::Boolean.new.cast(value)
    else
      value
    end
  end

  def assignment_wave_params
    wave_params = params.require(:assignment)
                        .permit(:wave_one, :wave_two, :wave_three, :other)

    Rails.logger.info "Wave params before transform: #{wave_params.inspect}"

    transformed_params = wave_params.transform_values { |v| ActiveModel::Type::Boolean.new.cast(v) }

    Rails.logger.info "Wave params after transform: #{transformed_params.inspect}"

    transformed_params
  end
end
