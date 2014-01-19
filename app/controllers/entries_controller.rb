class EntriesController < UITableViewController
  extend IB
  attr_accessor :tag
  
  def saveTag sender
    savetag = Tag.createEntity
    savetag.name = @tag
    NSManagedObjectContext.defaultContext.saveToPersistentStoreAndWait
    App.alert(@tag+"を登録しました")
  end

  def viewDidLoad
    super
    self.title = @tag
    @entries = []
    SVProgressHUD.showWithStatus("loading", maskType:4)
    @refreshControl = UIRefreshControl.alloc.init
    @refreshControl.addTarget(self,action:"onRefresh",forControlEvents:UIControlEventValueChanged)
    self.refreshControl = @refreshControl
    onRefresh
   end

  def onRefresh
    self.refreshControl.beginRefreshing
    Qiita::Client.fetch_tagged_items(@tag) do | items, error_message|
      if error_message.nil?
        @entries = items
        self.tableView.reloadData
      else
        p response.error_message
      end 
      self.refreshControl.endRefreshing
      SVProgressHUD.dismiss  #初回のみ
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
    # AFMotion::Image.get(entry.profile) do |result|
    #   imageView = UIImageView.alloc.initWithImage(result.object)
    #   imageView.frame = CGRectMake(0, 0, 100, 100)
    #   cell.image = imageView.image
    #   cell.layoutSubviews
    # end
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    @url = @entries[indexPath.row].url
    # self.performSegueWithIdentifier("Body", sender:self)
    webViewController = PBWebViewController.alloc.init
    webViewController.URL = NSURL.alloc.initWithString(@url)
    activity = PBSafariActivity.alloc.init
    webViewController.applicationActivities = [activity]
    webViewController.excludedActivityTypes = [UIActivityTypeMail, UIActivityTypeMessage, UIActivityTypePostToWeibo]
    navigationController.pushViewController(webViewController, animated:TRUE)
  end

  def prepareForSegue(segue, sender:sender)
    controller = segue.destinationViewController
    controller.url = @url
  end

end
