class PingController < ApplicationController
  def index
    puts "hello world"
  end
  
  def add
    # TODO Add a verify line
    
    if request.post? && request.content_type == "multipart/rfc-822"
      # Request is from smtp2web
      @from = params[:from]
      @to = params[:to]
      # @message = request.body 
      @message = ""
      
    elsif request.post?
      # Normal POST request
      
    else
      # GET request, show the index
      
    end
  end
  
  def smtp2web_73dd6ed076562e0d
    puts ""
  end
end
