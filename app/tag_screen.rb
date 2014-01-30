class TagScreen < PM::TableScreen
	
  title "Qiita"

  def on_load
    # @tags = ["RubyMotion","Ruby","iPad"]
    bar = UISearchBar.alloc.initWithFrame(CGRectMake(0,0,self.tableView.frame.size.width,0))
    bar.delegate = self
    bar.placeholder = "タグ検索"
    bar.sizeToFit()
    view.tableHeaderView = bar
    fetch_feed
  end
  
  def fetch_feed
    @tags = Tag.findAll
    @items = [{
      cells: @tags.map do |d|
        {
          title: d.name,
          action: :tapped_item,
          arguments: d.name,
          editing_style: :delete,
        }
      end
      }]
    update_table_data
  end

  def table_data
    @items ||= []
  end

  def on_cell_deleted(cell)
    # tag = Tag.findByAttribute(:name, withValue:cell['title'])
    # tag.deleteEntry
    # NSManagedObjectContext.defaultContext.saveToPersistentStoreAndWait
    p cell
    true
  end

  def tapped_item(item)
    open TopicScreen.new(tag: item)
  end

  def searchBarSearchButtonClicked(searchBar)
    open TopicScreen.new(tag: searchBar.text+"*")
  end

  def on_return(args={})
    tag = Tag.createEntity    
    tag.name = args[:saved_tag]
    NSManagedObjectContext.defaultContext.saveToPersistentStoreAndWait
    fetch_feed
  end

end
