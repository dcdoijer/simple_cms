class DemoController < ApplicationController

  layout 'admin'
  
  def index
    # render('hello')  
    # redirect_to(:action => 'other_hello')
  end

  def hello
    # redirect_to("http://www.google.com")
    @array = [1,2,3,4,5]
    @id = params[:id]
    @page = params[:page].to_i

  end

  def other_hello
    render (:text => 'Hello everyone!')
  end

  def text_helpers

  end

  def escape_output
  end

  def logging
    @subjects = Subject.all
    ActiveSupport::Deprecation.warn("THis is a Deprecation")
    logger.debug("This is debug.")
    logger.info("This is info")
    logger.warn("This is warn")
    logger.error("This is error")
    logger.fatal("This is fatal")
    render(:text => "Logged!")
  end

end
