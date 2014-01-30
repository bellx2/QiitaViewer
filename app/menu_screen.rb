class MenuScreen < PM::TableScreen


  def on_load  
    self.title = "メニュー"
    self.edgesForExtendedLayout = UIRectEdgeNone
  end

  def table_data
    [{
      title: "Qiita Viewer",
      cells: [
        { title: "お気に入り", action: :menu_favorite },
        { title: "フィード", action: :menu_feed },
        { title: "自分の投稿", action: :menu_mine }
      ]
    }, {
      title: "設定",
      cells: [
        { title: "ユーザー情報", action: :menu_user },
        { title: "著作権", action: :menu_about }
      ]
    }]
  end

  def menu_favorite
    self.sidePanelController.centerPanel = TagScreen.new(nav_bar: true).navigationController
  end

  def menu_feed
    self.sidePanelController.centerPanel = TagScreen.new(nav_bar: true).navigationController
  end

  def menu_mine
    self.sidePanelController.centerPanel = TagScreen.new(nav_bar: true).navigationController
  end

end
