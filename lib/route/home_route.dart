import '../index.dart';

///首页
class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  List<Widget> _pageList; //所有页面
  Map<String, IconData> navItemMap;
  int _selectedIndex = 0; //底部导航索引位置
  DateTime _lastPressedAt; //上次点击时间

  @override
  void initState() {
    super.initState();
    _pageList = List();
    _pageList.add(RepoListRoute());
    _pageList.add(LanguageRoute());
    _pageList.add(ThemeChangeRoute());
  }

  @override
  Widget build(BuildContext context) {
    var gm = GmLocalizations.of(context);
    navItemMap = {
      gm.navHome: Icons.home,
      gm.navDynamic: Icons.wb_sunny,
      gm.navMe: Icons.perm_identity,
    };

    // return RepoListRoute();

    //todo 暂时不要底部导航...
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: WillPopScope(
        child: IndexedStack(
          index: _selectedIndex,
          children: _pageList,
        ),
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt) > Duration(seconds: 2)) {
            //两次点击间隔超过1s则重新计时
            _lastPressedAt = DateTime.now();
            showToast("再点击一次退出应用");
            return false;
          }
          return true;
        },
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

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      elevation: 0.0,
      type: BottomNavigationBarType.fixed,
      items: navItemMap.entries
          .map((e) => BottomNavigationBarItem(
                icon: Icon(e.value),
                title: Text(
                  e.key,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ))
          .toList(),
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
