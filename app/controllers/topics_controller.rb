class TopicsController < UITableViewController
  def viewDidLoad
    super
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

  ENTRY_CELL_ID = 'Entry'
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
    controller = EntriesController.new
    controller.tag = @entries[indexPath.row]
    navigationController.pushViewController(controller, animated:true)
  end
end