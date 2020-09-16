import '../index.dart';

///drawer
class HomeDrawer extends StatelessWidget {
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
