class IssuesController < ApplicationController
  layout "issue"

  #before_filter :load_user
  before_filter :email_id

  helper_method :sort_column, :sort_direction

  # GET /issues
  # GET /issues.json
  def index
    if !@user.nil?
      @issues = @user.issues.order(sort_column + " " + sort_direction)
    else
      @issues = Issue.order(sort_column + " " + sort_direction)
    end
    #@issues = Issue.order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @issues }
    end
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    @issue = Issue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /issues/new
  # GET /issues/new.json
  def new
    @issue = Issue.new

    #@issue.update_attributes(:opened => DateTime.now.to_date)
    @issue.update_attribute(:opened, DateTime.now.to_date)
    @issue.update_attribute(:raised_by, current_user.email) 
    @issue.update_attribute(:user_id,  User.find_by_email(current_user.email).id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /issues/1/edit
  def edit
    @issue = Issue.find(params[:id])
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(params[:issue])

    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
        format.json { render json: @issue, status: :created, location: @issue }
      else
        format.html { render action: "new" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /issues/1
  # PUT /issues/1.json
  def update
    @issue = Issue.find(params[:id])

    respond_to do |format|
      if @issue.update_attributes(params[:issue])
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy

    respond_to do |format|
      format.html { redirect_to issues_url }
      format.json { head :no_content }
    end
  end

  def sort_column
    Issue.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def solve_issue
    @issue = Issue.find(params[:id])
    @issue.update_attribute(:closed, DateTime.now.to_date)
    @issue.update_attribute(:owner, current_user.email)
    @issue.update_attribute(:status, "solved")
    redirect_to issues_url
  end

  def display_mine
    @issues = User.find_by_email(current_user.email).issues
    #@issues = Issue.find_all_by_user_id(@id)
    ap @issues
    #@issues = Issue.find_all_by_user_id(@id).order(sort_column + " " + sort_direction)
    #@issues = Issue.order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @issues }
    end
  end

  private

  def load_user
    #@user = (!params[:user_id].nil?) ? User.find(params[:user_id]) : User.find_by_email(current_user.email)
    if !params[:user_id].nil?
      @user = User.find(params[:user_id])
    else
      @user = User.find_by_email(current_user.email)
    end
  end

  def email_id
    @id = User.find_by_email(current_user.email)
  end
end
