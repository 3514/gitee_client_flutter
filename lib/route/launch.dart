import '../index.dart';

class LaunchWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LaunchState();
  }
}

class _LaunchState extends State<LaunchWidget> {
  @override
  void initState() {
    OAuth().prepare().then((oauth) {
      Future.delayed(Duration(milliseconds: 100)).then((_) {
        // if ((oauth as OAuth).isAuthorized) {
        //   Navigator.of(context).pushReplacementNamed("/router/home");
        // } else {
        //   Navigator.of(context).pushReplacementNamed("/router/login");
        // }
        Navigator.of(context).pushReplacementNamed(page_home);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Scaffold(
        body: new Container(
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Text(
              '码云 Gitee',
              style: TextStyle(
                color: Colors.grey[50],
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
