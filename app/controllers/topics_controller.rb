 class TopicsController < UITableViewController
  extend IB

  outlet :searchBar, UISearchBar

  def viewDidLoad
    super
    self.navigationController.navigationBar.barTintColor = BubbleWrap.rgb_color(89, 187, 12)
    self.navigationController.navigationBar.titleTextAttributes = {
      NSForegroundColorAttributeName => UIColor.whiteColor
    }
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor
    self.navigationItem.rightBarButtonItem = self.editButtonItem
    
    searchBar.delegate = self
  end

  def viewWillAppear(animated)
    p "viewWillAppear"
    @tags = nil
    view.reloadData
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
    @nexttag = self.tags[indexPath.row].name
    self.performSegueWithIdentifier("Entries", sender:self)
  end

  def prepareForSegue(segue, sender:sender)
    controller = segue.destinationViewController
    controller.tag = @nexttag
  end

  def setEditing(editing, animated:animated)
    super
    # if(editing)
    #   self.navigationItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAdd, target:self, action: :addRow)
    # else
    #   self.navigationItem.leftBarButtonItem = nil
    # end
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

  def searchBarSearchButtonClicked(searchBar)
    @nexttag = searchBar.text
    self.performSegueWithIdentifier("Entries", sender:self)
  end

end