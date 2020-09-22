import '../index.dart';

// 码云首页 仓库列表:推荐,热门,最近
class HomeRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> with SingleTickerProviderStateMixin {
  //TabBar和TabBarView正是通过同一个controller来实现菜单切换和滑动状态同步的
  TabController _tabController;
  List<TabTitleHome> _tabs = TabTitleHome.values;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalizations.of(context).home),

        ///如果给Scaffold添加了抽屉菜单，默认情况下Scaffold会自动将AppBar的leading设置为菜单按钮（如上面截图所示），
        ///点击它便可打开抽屉菜单。如果我们想自定义菜单图标，可以手动来设置leading
        /* leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.menu, color: Colors.white), //自定义图标 , 系统默认 Icons.menu
            onPressed: () {
              // 打开抽屉菜单
              // 代码中打开抽屉菜单的方法在ScaffoldState中，通过Scaffold.of(context)可以获取父级最近的Scaffold 组件的State对象。
              Scaffold.of(context).openDrawer();
            },
          );
        }),*/

        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs.map((e) => Tab(text: e.title)).toList(),
          isScrollable: false,
        ),

        //导航栏右侧菜单
        actions: <Widget>[
          InkWell(
              child: Hero(tag: hero_tag_search, child: const Icon(Icons.search)),
              onTap: () {
                //navToPage2(context: context, page: SearchPageRoute());
                navToPage3(
                  context: context,
                  page: PageRouteBuilder(
                    pageBuilder: (context, Animation animation, Animation secondaryAnimation) {
                      return ScaleTransition(
                        scale: CurvedAnimation(parent: animation, curve: Curves.ease),
                        child: SearchPageRoute(), //路由页
                      );
                    },
                  ),
                );
              }),
          //通知红点
          BadgeWidget(
            future: GiteeApi().notificationCount(true),
            centerIconData: Icons.notifications_none,
            smallTextBgColor: Colors.red,
            smallTextMarginRight: 12,
            smallTextMarginTop: 12,
            onPressed: () {
              navToPage2(context: context, page: NotificationsRoute());
            },
          ),
        ],
      ),
      body: _buildBody(), //主页面
      drawer: _HomeDrawer(), //抽屉菜单
    );
  }

  Widget _buildBody() {
    final UserModel userModel = Provider.of<UserModel>(context);
    // 用户未登录, 显示登录按钮
    if (!userModel.isLogin) {
      return Center(
        child: RaisedButton(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: Text(GmLocalizations.of(context).login),
          ),
          color: Theme.of(context).primaryColor,
          highlightColor: Theme.of(context).primaryColorDark,
          colorBrightness: Brightness.dark,
          splashColor: Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          onPressed: () => navToPage(context, page_login),
        ),
      );
    } else {
      //已登录，构建首页 -> 推荐项目,热门项目,最近更新
      return TabBarView(
        controller: _tabController,
        //创建n个Tab页
        children: _tabs.map((e) => _HomeListWidget(e)).toList(),
      );
    }
  }
}

///抽屉菜单
class _HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      //移除顶部padding
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDrawerHeader(), //构建抽屉菜单头部
            Expanded(child: _buildDrawerMenus()), //构建功能菜单
          ],
        ),
      ),
    );
  }

  ///drawer header
  Widget _buildDrawerHeader() {
    return Consumer(
      builder: (BuildContext context, UserModel userModel, Widget child) {
        return GestureDetector(
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(top: 45.0, bottom: 20.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  // 如果已登录，则显示用户头像；若未登录，则显示默认头像
                  child: userModel.isLogin
                      ? getAvatarCircle(
                          userModel.user.avatar_url,
                          radius: 80.0,
                        )
                      : Image.asset(
                          image_avatar_default,
                          height: 80.0,
                          width: 80.0,
                          fit: BoxFit.cover,
                        ),
                ),
                Text(
                  userModel.isLogin ? userModel.user.name : GmLocalizations.of(context).login,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            if (!userModel.isLogin) navToPage(context, page_login);
          },
        );
      },
    );
  }

  ///drawer menus
  Widget _buildDrawerMenus() {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel userModel, Widget child) {
        var gm = GmLocalizations.of(context);
        return ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: Text(gm.theme),
              onTap: () => navToPage(context, page_theme),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(gm.language),
              onTap: () => navToPage(context, page_language),
            ),
            Builder(builder: (context) {
              if (userModel.isLogin) {
                return ListTile(
                  leading: const Icon(Icons.power_settings_new),
                  title: Text(gm.logout),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        //退出账号前先弹二次确认窗
                        return AlertDialog(
                          content: Text(gm.logoutTip),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(gm.cancel),
                              onPressed: () => Navigator.pop(context),
                            ),
                            FlatButton(
                              child: Text(gm.yes),
                              onPressed: () {
                                //该赋值语句会触发MaterialApp rebuild
                                userModel.user = null;
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              }
              return Container(width: 0.0, height: 0.0);
            }),
            //if(userModel.isLogin)
          ],
        );
      },
    );
  }
}

// 项目列表
class _HomeListWidget extends StatefulWidget {
  _HomeListWidget(this.tab, {Key key}) : super(key: ValueKey(tab.name));
  final TabTitleHome tab;

  @override
  _HomeListWidgetState createState() => _HomeListWidgetState();
}

class _HomeListWidgetState extends State<_HomeListWidget> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; //导航栏切换时保持原有状态

  @override
  Widget build(BuildContext context) {
    return InfiniteListView<RepoV3>(
      onRetrieveData: (int page, List<RepoV3> items, bool refresh) async {
        var data = await GiteeApi().getRepoListV3(tab: widget.tab, refresh: refresh, queryParameters: {'page': page});
        // 把请求到的新数据添加到items中
        items.addAll(data);
        return data.length > 0 && data.length % 20 == 0;
      },
      emptyBuilder: (VoidCallback refresh, BuildContext context) => listNoDataView(refresh, context),
      // 项目信息列表项
      itemBuilder: (List list, int index, BuildContext ctx) => RepoListItemWidgetV3(list[index]),
    );
  }
}

