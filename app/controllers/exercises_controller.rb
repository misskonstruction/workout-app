class ExercisesController < ApplicationController
  before_action :set_exercise, only: [:edit, :show, :update, :destroy]

  def index
    # e.g with named scopes we would have something like this for
    # displaying last weeks workouts in desc order
    # @exercises = current_user.exercises.last_week.desc_date
    @exercises = current_user.exercises
    @friends = current_user.friends
    set_current_room
    @message = Message.new
    @messages = current_room.messages if current_room
    @followers = Friendship.where(friend_id: current_user.id)
  end

  def show
    @exercise = current_user.exercises.find(params[:id])
  end

  def new
    @exercise = current_user.exercises.new
  end

  def create
    @exercise = current_user.exercises.new(exercise_params)

    if @exercise.save
      flash[:notice] = "Exercise has been created"
      # redirect_to user_exercise_path(current_user, @exercise)
      # instead of the shorthand below
      redirect_to [current_user, @exercise]
    else
      flash.now[:alert] = "Exercise has not been created"
      render :new
    end
  end

  def edit
    @exercise = current_user.exercises.find(params[:id])
  end

  def update
    @exercise = current_user.exercises.find(params[:id])
    if @exercise.update(exercise_params)
      flash[:notice] = "Exercise has been updated"
      redirect_to [current_user, @exercise]
    else
      flash[:alert] = "Exercise has not been updated"
      render :edit
    end
  end

  def destroy
    @exercise.destroy
    flash[:notice] = "Exercise has been deleted"
    redirect_to user_exercises_path(current_user)
  end

  private

  def set_exercise
    @exercise = current_user.exercises.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:duration_in_min, :workout, :workout_date, :user_id)
  end

  def set_current_room
    if params[:roomId]
      @room = Room.find_by(id: params[:roomId])
    else
      @room = current_user.room
    end
    session[:current_room] = @room.id if @room
  end
end