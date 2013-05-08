class SectionsController < ApplicationController

  layout 'admin'

  before_filter :confirm_logged_in
  before_filter :find_page
  
  def index
  
    list 
    render('list')  

  end

  def list
    
    @sections = Section.sorted.where(:page_id => @page.id)

  end

  def show

    @section = Section.find(params[:id])

  end

  def new
    @section = Section.new(:page_id => @page.id)
    @section_count = @page.sections.size + 1
    @pages = Page.order("position ASC")
  end

  def create
    new_position = params[:section].delete(:position)
    # Instantiate a new object using form parameters
    @section = Section.new(params[:section])
    # Save the object
    if @section.save
      @section.move_to_position(new_position)
      # If save succeeds, redirect to the list action
      flash[:notice] = "Section created successfully."
      redirect_to(:action => 'list', :page_id => @section.page_id)
    else
      # If save fails, redisplay the form so the user can fix the problem
      @pages = Page.order("position ASC")
      @section_count = @page.sections.size + 1
      render('new')
    end
  end

  def edit

    @section = Section.find(params[:id])
    @section_count = @page.sections.size
    @pages = Page.order("position ASC")

  end

  def update
    new_position = params[:section].delete(:position)
    # Find an object using form parameters
    @section = Section.find(params[:id])
    # Update the object
    if @section.update_attributes(params[:section])
      @section.move_to_position(new_position)
      # If update succeeds, redirect to the list action
      flash[:notice] = "Section updated successfully."
      redirect_to(:action => 'show', :id => @section.id, :section_id => @section.page_id)
    else
      # If save fails, redisplay the form so the user can fix the problem
      @pages = Page.order("position ASC")
      @section_count = @page.sections.size + 1
      render('edit')
    end

  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
     section = Section.find(params[:id])
     section.move_to_position(nil)
     section.destroy
     flash[:notice] = "It's dead Jim!"
     redirect_to(:action => 'list', :subject_id => @page.id)
  end

  private

  def find_page
    if params[:page_id]
      @page = Page.find_by_id(params[:page_id])
    end
  end
  
end
