import '../index.dart';

///码云首页仓库列表:推荐,热门,最近
class RepoListRoute extends StatefulWidget {
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
          InkWell(
            child: Hero(
              tag: hero_tag_search,
              child: Icon(Icons.search),
            ),

            // child: Hero(
            //   tag: hero_tag_search,
            //   child: IconButton(
            //     icon: const Icon(Icons.search),
            //     onPressed: () {
            //       navToPage2(context: context, page: HeroAnimationRouteB());
            //     },
            //   ),
            // ),

            // child:  Hero(
            //   tag: hero_tag_search, //唯一标记，前后两个路由页Hero的tag必须相同
            //   child: ClipOval(
            //     child: Image.asset(
            //       "static/image/logo_dark.png",
            //       width: 60.0,
            //     ),
            //   ),
            // ),
            onTap: () {
              navToPage3(
                context: context,
                page: PageRouteBuilder(
                  pageBuilder: (context, Animation animation, Animation secondaryAnimation) {
                    return FadeTransition(
                      opacity: animation,
                      //child: SearchPageRoute(), //路由页
                      child: HeroAnimationRouteB(), //路由页
                    );
                  },
                ),
              );
            },
          ),
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
          onPressed: () => navToPage(context, page_login),
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

// 路由B
class HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple[50],
      child: Center(
        child: Hero(
          tag: hero_tag_search, //唯一标记，前后两个路由页Hero的tag必须相同
          child: Image.asset("static/image/logo_dark.png"),
        ),
      ),
    );
  }
}
