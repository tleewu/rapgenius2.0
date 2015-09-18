module ApplicationHelper

  def auth_token
    "<input type='hidden', name='authenticity_token', value='#{form_authenticity_token}'>".html_safe
  end

  def ugly_lyrics(lyrics)
    lyrics.gsub!("\r"){'<br> &#9835'}.html_safe
  end

end
