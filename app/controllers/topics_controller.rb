class TopicsController < UITableViewController
  def viewDidLoad
    super
    self.navigationController.navigationBar.barTintColor = BubbleWrap.rgb_color(89, 187, 12)
    self.navigationController.navigationBar.titleTextAttributes = {
      NSForegroundColorAttributeName => UIColor.whiteColor
    }
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor

    @entries = ['RubyMotion','Objective-C','xcode','nodejs','php']

    # url = "http://qiita.com/api/v1/tags"
    # BW::HTTP.get(url) do |response|
    #   if response.ok?
    #     @entries = BW::JSON.parse(response.body.to_s)
    #     self.tableView.reloadData
    #   end
    # end
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @entries.count
  end

  ENTRY_CELL_ID = 'Topics'
  def tableView(table, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(ENTRY_CELL_ID)
    if cell.nil?
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:ENTRY_CELL_ID)
    end

    entry = @entries[indexPath.row]
    cell.textLabel.text = entry
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    ud = NSUserDefaults.standardUserDefaults
    ud["tag"] = @entries[indexPath.row]
    self.performSegueWithIdentifier("Entries", sender:self)
  end

end