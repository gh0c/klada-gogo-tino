class StaticPagesController < ApplicationController
  def home
    @micropost = current_user.microposts.build if logged_in?
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
  
  def standings
    require 'open-uri'
    @html_standings_doc = "--None--"
    url = "http://www.nba.com/standings/team_record_comparison/conferenceNew_Std_Cnf.html"
    doc = Nokogiri::HTML(open(url))

    doc2 = Nokogiri::HTML('<html><body><table></table></body></html>')
    doc2_table = doc2.at('table')
    
    tr = doc.css('.genStatTable .confTitle').first.parent
    while tr do
      doc2_table.add_child(tr.to_html) 
      tr = tr.next
    end
    
    
    @html_standings_doc = doc2.at('table').inner_html.html_safe
  end
end
