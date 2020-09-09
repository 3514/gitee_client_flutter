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
        title: Text('Flutter Gitee'),
      ),
      body: _buildBody(),
      drawer: _HomeDrawer(),
    );
  }

  ///body
  Widget _buildBody() {
    return Center(
      child: RaisedButton(
        child: Text('登录'),
        onPressed: () => Navigator.of(context).pushNamed("login"),
      ),
    );
  }
}

///drawer
class _HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
