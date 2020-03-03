class WidgetsController < ApplicationController
  before_action :authenticate_user, except: :landing
  before_action :set_widget, only: [:edit]

  # GET /widgets
  # GET /widgets.json

  def index
    @widgets = Widget.user_widgets(term: params[:term], token: session[:token])
  end

  def landing
    @widgets = Widget.all(params[:term])
  end

  # GET /widgets/1
  # GET /widgets/1.json
  def show
  end

  # GET /widgets/new
  def new
    @widget = Widget.new
  end

  # GET /widgets/1/edit
  def edit
  end

  # POST /widgets
  # POST /widgets.json
  def create
    @widget = Widget.new(widget: widget_params, token: session[:token])
    respond_to do |format|
      if @widget.save!
        format.html { redirect_to widgets_path, notice: 'Widget was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /widgets/1
  # PATCH/PUT /widgets/1.json
  def update
    @widget = Widget.new(widget: widget_params, token: session[:token])
    respond_to do |format|
      if @widget.update!
        format.html { redirect_to widgets_path, notice: 'Widget was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /widgets/1
  # DELETE /widgets/1.json
  def destroy
    @widget = Widget.new(widget: {id: params[:id]}, token: session[:token])
    @widget.delete!
    respond_to do |format|
      format.html { redirect_to widgets_url, notice: 'Widget was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_widget
      @widget = Widget.new(widget: widget_params, token: session[:token])
    end

    # Only allow a list of trusted parameters through.
    def widget_params
      params.require(:widget).permit(:id, :name, :description, :kind)
    end
end
