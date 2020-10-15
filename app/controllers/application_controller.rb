class ApplicationController < ActionController::Base
  before_action :load_events, :set_user

  def index
    # reset_session
  end

  def load_events
    @events ||= Event.all.includes(:users).order("created_at desc")
  end

  def logout
    session[:current_user_id] = nil

    redirect_to action: 'index'
  end

  def delete_event
    redirect_to '/' unless @user && @user.admin?

    load_event

    @event.delete
    redirect_to '/' 
  end

  def create_event
    redirect_to '/' unless @user.admin?

    event = Event.new(event_params)
    if event.save
      redirect_to '/', notice: 'User was successfully created.'
    else
      format.html { render '/' }
    end
  end

  def join_event
    redirect_to '/' unless @user

    load_event

    if @event.add_user(@user)
      redirect_to '/', notice: 'Nice of you yo join!'
    else
        format.html { redirect_to '/', notice: 'Something went wrong!' }
    end
  end

  def create_comment
    redirect_to '/' unless @user

    load_event
    comment = Comment.new(comment_params)
    comment.event = @event
    comment.user = @user

    if comment.save
      redirect_to '/', notice: 'Good comment!'
    else
      format.html { redirect_to '/', notice: 'Something went wrong!' }
    end
  end

  def delete_comment
    redirect_to '/' unless @user

    load_comment

    redirect_to '/' unless @comment.user == @user

    if @comment.delete
      redirect_to '/', notice: 'Comment removed'
    else
    end
  end

  def leave_event
    redirect_to '/' unless @user

    load_event

    if @event.remove_user(@user)
      redirect_to '/', notice: 'So sad that you leave!'
    else
        format.html { redirect_to '/', notice: 'Something went wrong!' }
    end
  end

  def login
    user = User.find_by_email(login_params[:email])
    if(user && user.authenticate(login_params[:password]))
        session[:current_user_id] = user.id
        redirect_to action: 'index'
    else
        format.html { redirect_to '/', notice: 'Something went wrong!' }
    end
  end

  def create_user
    @user = User.new(user_params)

    @user.role_id = User::ROLE_USER

    respond_to do |format|
      if @user.save
        session[:current_user_id] = @user.id
        format.html { redirect_to '/', notice: 'User was successfully created.' }
      else
        format.html { render '/' }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    return nil unless session[:current_user_id]
    @user = User.find(session[:current_user_id])
  end
  
  def load_event
    @event ||= Event.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def login_params
    params.require(:login).permit(:email, :password)
  end

  def event_params
    params.require(:event).permit(:name, :description, :start_at, :end_at)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def load_comment
    @comment ||= Comment.find(params[:id])
  end
end
