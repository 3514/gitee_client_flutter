import '../index.dart';

///首页
class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> with SingleTickerProviderStateMixin {
  ///TabBar和TabBarView正是通过同一个controller来实现菜单切换和滑动状态同步的
  TabController _tabController;
  List<TabTitleHome> _tabs = TabTitleHome.values;

  ///底部导航索引位置
  int _selectedIndex = 0;

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
          tabs: _tabs
              .map((e) => Tab(
                    text: e.title,
                  ))
              .toList(),
          isScrollable: false,
        ),

        ///导航栏右侧菜单
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: _buildBody(), //主页面
      drawer: _HomeDrawer(), //抽屉菜单

      ///底部导航 BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        items: NavTitleHome.values
            .map((e) => BottomNavigationBarItem(
                  icon: Icon(e.getIconData()),
                  title: Text(
                    e.title,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ))
            .toList(),
        currentIndex: _selectedIndex,
        //fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),

      ///Material组件库中提供了一个BottomAppBar 组件，它可以和FloatingActionButton配合实现这种“打洞”效果
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.white,
      //   shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
      //   child: Row(
      //     children: [
      //       IconButton(
      //         icon: Icon(Icons.home),
      //       ),
      //       SizedBox(), //中间位置空出
      //       IconButton(
      //         icon: Icon(Icons.business),
      //       ),
      //     ],
      //     mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
      //   ),
      // ),

      ///可以看到，上面代码中没有控制打洞位置的属性，实际上，打洞的位置取决于FloatingActionButton的位置:
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      ///悬浮按钮
      // BottomAppBar的shape属性决定洞的外形，CircularNotchedRectangle 实现了一个圆形的外形，
      /*floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _onAdd,
      ),*/
    );
  }

  ///底部导航切换监听
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  ///悬浮按钮事件
  void _onAdd() {}

  ///body
  Widget _buildBody() {
    final UserModel userModel = Provider.of<UserModel>(context);
    // 用户未登录, 显示登录按钮
    if (!userModel.isLogin) {
      return Center(
        child: RaisedButton(
          child: Text(GmLocalizations.of(context).login),
          onPressed: () => Global.navToPage(context, page_login),
        ),
      );
    } else {
      //已登录，构建首页 -> 推荐项目,热门项目,最近更新
      return TabBarView(
        controller: _tabController,
        //创建n个Tab页
        children: _tabs.map((e) {
          return HomeListWidget(e);
        }).toList(),
      );
    }
  }
}

///drawer
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
                          userModel.user.portrait_url,
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
            if (!userModel.isLogin) Global.navToPage(context, page_login);
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
              onTap: () => Global.navToPage(context, page_theme),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(gm.language),
              onTap: () => Global.navToPage(context, page_language),
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
