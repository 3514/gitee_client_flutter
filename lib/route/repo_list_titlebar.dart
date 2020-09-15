import '../index.dart';

///码云首页仓库列表:推荐,热门,最近
class RepoListRoute extends StatefulWidget {
  RepoListRoute();

  @override
  State<StatefulWidget> createState() {
    return _RepoListRouteState();
  }
}

class _RepoListRouteState extends State<RepoListRoute> with SingleTickerProviderStateMixin {
  ///TabBar和TabBarView正是通过同一个controller来实现菜单切换和滑动状态同步的
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
      drawer: HomeDrawer(), //抽屉菜单
    );
  }

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

