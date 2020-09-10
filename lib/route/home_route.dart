import '../index.dart';

///首页
class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalizations.of(context).home),
      ),
      body: _buildBody(), //主页面
      drawer: _HomeDrawer(), //抽屉菜单
    );
  }

  ///body
  Widget _buildBody() {
    UserModel userModel = Provider.of<UserModel>(context);
    return HomeTabViewPagerWidget();

    //用户未登录, 显示登录按钮
    // if (!userModel.isLogin) {
    //   return Center(
    //     child: RaisedButton(
    //       child: Text(GmLocalizations.of(context).login),
    //       onPressed: () => Global.navToPage(context, page_login),
    //     ),
    //   );
    // } else {
    //   //已登录，构建首页, 推荐项目,热门项目,最近更新
    //   return HomeTabViewPagerWidget();
    // }


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
    return Center(
      child: RaisedButton(
        child: Text('Header'),
      ),
    );
  }

  ///drawer menus
  Widget _buildDrawerMenus() {
    return Builder(
      builder: (context) {
        return ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: Text('主题'),
              onTap: () => Navigator.pushNamed(context, page_theme),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text('语言'),
              onTap: () => Navigator.pushNamed(context, page_language),
            ),
          ],
        );
      },
    );
  }
}
