class TopicScreen < PM::TableScreen

  attr_accessor :tag

  refreshable callback: :on_refresh,
    pull_message: "Pull to refresh",
    refreshing: "Refreshing data..."

  BASE_URL = 'https://qiita.com/api/v1'
  def fetch_feed
    url = BASE_URL + "/tags/#{tag}/items"
    BW::HTTP.get(url) do |response|
      if response.ok?
        json = BW::JSON.parse(response.body.to_s)
        @items = [{
          cells: json.map do |item|
            {
              title: item['title'],
              subtitle: "#{item['updated_at']} by #{item['user']['url_name']}",
              action: :tapped_item,
              arguments: item['url'],              
            }
          end
        }]
      else
        p "受信エラー"
      end
      end_refreshing
      SVProgressHUD.dismiss
      update_table_data
    end
  end

  def on_load
    if tag[-1] == "*"
      set_nav_bar_button :right, system_icon: :add, action: :add_tag
      tag.chop!()
    end
    self.title = tag
    SVProgressHUD.showWithStatus("loading", maskType:4)
    fetch_feed
  end

  def on_refresh
    fetch_feed
  end

  def table_data
    @items ||= []
  end

  def add_tag
    close saved_tag: tag
  end

  def tapped_item(item)
    # open WebScreen.new(url: item, title: item)
    webViewController = PBWebViewController.alloc.init
    webViewController.URL = NSURL.alloc.initWithString(item)
    activity = PBSafariActivity.alloc.init
    webViewController.applicationActivities = [activity]
    webViewController.excludedActivityTypes = [UIActivityTypeMail, UIActivityTypeMessage, UIActivityTypePostToWeibo]
    navigationController.pushViewController(webViewController, animated:TRUE)
  end

end