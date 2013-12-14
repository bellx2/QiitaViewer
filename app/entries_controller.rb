class EntriesController < UITableViewController
  def viewDidLoad
    super
    @tag = "RubyMotion"
    self.title = @tag
    @entries = []
    SVProgressHUD.show
    url = "https://qiita.com/api/v1/tags/#{@tag}/items"
    BW::HTTP.get(url) do |response|
      if response.ok?
        json = BW::JSON.parse(response.body.to_s)
        @entries = json
        self.tableView.reloadData
        SVProgressHUD.dismiss
      else
        p response.error_message
      end
    end
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @entries.count
  end

  ENTRY_CELL_ID = 'Entry'
  def tableView(table, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(ENTRY_CELL_ID)
    if cell.nil?
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:ENTRY_CELL_ID)
    end
    entry = @entries[indexPath.row]

    cell.textLabel.text = entry['title']
    cell.detailTextLabel.text = "#{entry['updated_at_in_words']} by #{entry['user']['url_name']}"
    #cell.detailTextLabel.text = entry['url']
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    entry = @entries[indexPath.row]
    body = entry['body']

    controller = UIViewController.new
    webView = UIWebView.new
    webView.frame = controller.view.frame
    controller.view.addSubview(webView)

    navigationController.pushViewController(controller, animated:true)
    #webView.loadHTMLString(body, baseURL:nil)
    webView.loadRequest(NSURLRequest.requestWithURL(NSURL.URLWithString(entry['url'])))
  end

end
