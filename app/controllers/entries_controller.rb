class EntriesController < UITableViewController

  attr_accessor :tag
  
  def viewDidLoad
    super
    # @tag = "RubyMotion"
    self.title = @tag
    @entries = []
    SVProgressHUD.show
    
    Qiita::Client.fetch_tagged_items(@tag) do | items, error_message|
      if error_message.nil?
        @entries = items
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

    cell.textLabel.text = entry.title
    cell.detailTextLabel.text = "#{entry.updated_at} by #{entry.username}"
    #cell.detailTextLabel.text = entry['url']
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    entry = @entries[indexPath.row]
    
    controller = UIViewController.new
    webView = UIWebView.new
    webView.frame = controller.view.frame
    controller.view.addSubview(webView)

    navigationController.pushViewController(controller, animated:true)
    #webView.loadHTMLString(body, baseURL:nil)
    webView.loadRequest(NSURLRequest.requestWithURL(NSURL.URLWithString(entry.url)))
  end

end
