class EntriesController < UITableViewController

  attr_accessor :tag
  
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
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    @url = @entries[indexPath.row].url
    self.performSegueWithIdentifier("Body", sender:self)
  end

  def prepareForSegue(segue, sender:sender)
    controller = segue.destinationViewController
    controller.url = @url
  end

end
