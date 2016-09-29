class YoutimeController < ApplicationController

  def index
    @youtime = "Fill in the fields and click 'GENERATE'."
    @default_options = ['', 0, 0, 0]
    if session[:new_youtime]
      @youtime = generate_youtime(session[:new_youtime][0],
                                  session[:new_youtime][1],
                                  session[:new_youtime][2],
                                  session[:new_youtime][3])
      @default_options = session[:new_youtime]
      session[:new_youtime] = nil
    end
  end

  def generate
    param = params[:youtime_generator]
    p_youtube_id = param['youtube_id'].to_s[0..10]
    p_hour = param['hour'].to_s
    p_minute = param['minute'].to_s
    p_second = param['second'].to_s
    session[:new_youtime] = [p_youtube_id, p_hour, p_minute, p_second]
    redirect_to(:controller => 'youtime', :action => 'index')
  end

  private

    def generate_youtime(youtube_id, hour, minute, second)
      return 'https://www.youtube.com/watch?v=' + youtube_id + '&t=' + hour + 'h' + minute + 'm' + second + 's'
    end

end
