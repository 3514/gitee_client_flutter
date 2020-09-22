import 'dart:ui';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';
import '../index.dart';

class PersonDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PersonDetailState();
}

class _PersonDetailState extends State<PersonDetailPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  var statusBarHeight = MediaQueryData.fromWindow(window).padding.top;
  var _tabs = <String>['仓库', "星标"];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // _futureBuilderFuture = _getPersonDetailData();
  }

  @override
  Widget build(BuildContext context) {
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
      return Scaffold(body: _personDetailWidget());
    }
  }

  //个人详情页内容
  Widget _personDetailWidget() {
    final User user = Global.profile.user;

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          //一个状态栏大小的背景，防止上滑后TabBar一部分显示在状态栏中
          SliverPersistentHeader(
            pinned: true,
            delegate: MySliverPersistentHeaderDelegate(
              minHeight: statusBarHeight,
              maxHeight: statusBarHeight,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          //卡片中的内容
          SliverPersistentHeader(
            pinned: false,
            delegate: MySliverPersistentHeaderDelegate(
              minHeight: 200,
              maxHeight: 200,
              //图片蒙层背景的实现
              child: Stack(
                children: <Widget>[
                  //图片加载loading
                  Center(child: CircularProgressIndicator()),
                  //第一层是背景图
                  Container(
                    width: double.infinity,
                    child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage, image: user?.avatar_url ?? "", fit: BoxFit.cover),
                  ),
                  //第二层是当前主题色的半透明处理
                  Container(
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    width: double.infinity,
                  ),
                  //第三层是对前两层背景做高斯模糊处理，然后显示上面的内容
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        child: _headPersonInfo(user),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //tab栏
          SliverPersistentHeader(
            pinned: true,
            delegate: MySliverPersistentHeaderDelegate(
              minHeight: 45,
              maxHeight: 45,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: TabBar(
                    labelColor: Colors.white,
                    labelStyle: TextStyle(fontSize: 15.0),
                    unselectedLabelColor: Colors.white60,
                    indicatorColor: Colors.white38,
                    controller: _tabController,
                    tabs: _tabs.map((String label) => Tab(text: label)).toList()),
              ),
            ),
          ),
        ];
      },
      //导航
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((e) => RepoListWidget(_tabs.indexOf(e))).toList(),
      ),
    );
  }

  _headPersonInfo(User user) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: getAvatarCircle(user.avatar_url ?? user.portrait_url, radius: 80),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PhotoViewPage(user.avatar_url ?? user.portrait_url)),
                    );
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          user.login,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                        ),
                        _infoWithIcon(null, Icons.location_on, 15.0), //todo 2020年9月22日 获取授权用户的地址
                        _infoWithIcon(user.email, Icons.email, 15.0),
                        _infoWithIcon(user.blog, Icons.link, 15.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "创建于：" + user?.created_at?.substring(0, 10),
            style: TextStyle(
              fontSize: 13,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoWithIcon(message, icon, iconSize) {
    if (message == null || message.length == 0) {
      message = "目前什么都没有";
    }
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 5.0),
          child: Icon(
            icon,
            color: Colors.white70,
            size: iconSize,
          ),
        ),
        Expanded(
          child: Text(
            message ?? "目前什么都没有",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
