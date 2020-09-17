import 'package:gitee_client_flutter/common/gitee_api.dart';

import '../index.dart';

///登录
class LoginRoute extends StatefulWidget {
  LoginRoute({Key key}) : super(key: key);

  @override
  _LoginRouteState createState() {
    return _LoginRouteState();
  }
}

class _LoginRouteState extends State<LoginRoute> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  bool pwdShow = false;
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _nameController.text = Global.profile.lastLogin;
    if (_nameController.text.isNotEmpty) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var gm = GmLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(gm.login),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: [
              TextFormField(
                autofocus: _nameAutoFocus,
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: gm.userName,
                  hintText: gm.userName,
                  prefixIcon: Icon(Icons.person),
                ),
                //校验用户名(不能为空)
                validator: (v) {
                  return v.trim().isNotEmpty ? null : gm.userNameRequired;
                },
              ),
              TextFormField(
                controller: _pwdController,
                autofocus: !_nameAutoFocus,
                decoration: InputDecoration(
                  labelText: gm.password,
                  hintText: gm.password,
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(pwdShow ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        pwdShow = !pwdShow;
                      });
                    },
                  ),
                ),
                //模糊文字
                obscureText: !pwdShow,
                //校验密码(不能为空)
                validator: (v) {
                  return v.trim().isNotEmpty ? null : gm.passwordRequired;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 50),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: _onLogin,
                    textColor: Colors.white,
                    child: Text(gm.login),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLogin() async {
    // 先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      showLoading(context);
      User user;
      try {
        await GiteeApi().login(_nameController.text, _pwdController.text);
        user = await GiteeApi().userInfo();
        // 因为登录页返回后，首页会build，所以我们传false，更新user后不触发更新
        Provider.of<UserModel>(context, listen: false).user = user;
      } catch (e) {
        print(e?.toString());
        //登录失败则提示
        showToast(e.toString());
      } finally {
        // 隐藏Loading框
        Navigator.of(context).pop();
      }
      if (user != null) {
        Navigator.of(context).pop();
      }
    }
  }
}
