class TopicsController < UITableViewController

  def viewDidLoad
    super
    self.navigationController.navigationBar.barTintColor = BubbleWrap.rgb_color(89, 187, 12)
    self.navigationController.navigationBar.titleTextAttributes = {
      NSForegroundColorAttributeName => UIColor.whiteColor
    }
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor
    self.navigationItem.rightBarButtonItem = self.editButtonItem

    # @topics = Topic.all().to_a
    # if @topics == nil
    #   Topics.new([:title=>'RubyMotion'])      
    #   save
    #   @topics = Topic.all().to_a
    # end
    #@topics = ['RubyMotion','Objective-C','xcode','nodejs','php']
    # @topics = Array.new
    # url = "http://qiita.com/api/v1/tags?per_page=100"
    # BW::HTTP.get(url) do |response|
    #   if response.ok?
    #     BW::JSON.parse(response.body.to_s).each do |obj|
    #       @topics << obj['name'].to_s
    #     end
    #     self.tableView.reloadData
    #   end
    # end
  end

  def tags
    @tags ||= Tag.findAll
  end

  def tableView(tableView, numberOfRowsInSection:section)
    self.tags.size
  end

  ENTRY_CELL_ID = 'Topics'
  def tableView(table, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(ENTRY_CELL_ID)
    if cell.nil?
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:ENTRY_CELL_ID)
    end
    tag = self.tags[indexPath.row]
    cell.textLabel.text = tag.name
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    @nexttag = self.tags[indexPath.row]
    self.performSegueWithIdentifier("Entries", sender:self)
  end

  def prepareForSegue(segue, sender:sender)
    controller = segue.destinationViewController
    controller.tag = @nexttag.name
  end

  def setEditing(editing, animated:animated)
    super
    if(editing)
      self.navigationItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAdd, target:self, action: :addRow)
    else
      self.navigationItem.leftBarButtonItem = nil
    end
  end

  def tableView(tableView, commitEditingStyle:editingStyle, forRowAtIndexPath:indexPath)
    if (editingStyle == UITableViewCellEditingStyleDelete)
      tag = self.tags[indexPath.row]
      deleteTag(tag)
      NSManagedObjectContext.defaultContext.saveToPersistentStoreAndWait
      @tags = nil
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimationFade)
    end
  end

  def deleteTag(tag)
    tag.deleteEntity
    NSManagedObjectContext.defaultContext.saveToPersistentStoreAndWait
    @tags = nil
  end

  def addRow
    BW::UIAlertView.new({
      title: 'Add Tag',
      buttons: ['OK', 'Cancel'],
      cancel_button_index: 1,
      style: 'plain_text_input'
    }) do |alert|
      if !alert.clicked_button.cancel?
        tag = Tag.createEntity
        tag.name = alert.plain_text_field.text
        NSManagedObjectContext.defaultContext.saveToPersistentStoreAndWait
        @tags = nil
        view.reloadData
      end
    end.show
  end

end