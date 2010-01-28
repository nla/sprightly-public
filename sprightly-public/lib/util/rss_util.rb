require 'rss/2.0'
require 'open-uri'
require 'markaby'

class RssReader

  def self.default_options
    {
      :index => 0,
      :length => 5,
      :show_more_link => false
    }
  end

  def self.parse_feed (url, options)

    options = {} if options.blank?

    options = RssReader.default_options.merge(options)

    feed_url = url
    output = "";
    open(feed_url) do |http|
      response = http.read
      result = RSS::Parser.parse(response, false)
      output = "<div class=\"feed-title\">#{result.channel.title}</div><ul class='feed-item-list'>"
      result.items.each_with_index do |item, i|
        output += RssReader.render_item(item) if i >= options[:index] && ++i < options[:index] + options[:length]
      end
      if result.items.length > options[:index] + options[:length]  then
        output += "<li class='more-link'><a href='javascript:void(0);' onclick='RssReader.loadMore("+(options[:index]+options[:length]).to_s+", "+options[:length].to_s+")'>More...</a></li>"
      end
      output += "</ul>"
    end
    return output
  end

  def self.render_item(item)
    mab = Markaby::Builder.new
    mab.li :class=>"feed-item" do
      self.div :class=>"feed-item-title" do
        self.a :href=>item.link, :target=>"_blank", :title=>"View Post", :class=>"feed-item-title-link" do
           self << "View Post"
        end
        self << " "
        self.span :class=>"feed-date" do
          self << item.date.strftime("%I:%M%p %d-%m-%Y")
        end
        if not item.author.blank? then
          self.span :class=>"feed-author" do
            self << "posted by " + item.author
          end
        end
        self << " "
        self.span :class=>"feed-item-title-text" do
          self << item.title
        end                
      end
      self.div :class=>"feed-item-summary" do
        self << item.description
      end
    end
    mab.to_s
  end
  
end