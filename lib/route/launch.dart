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
      new Future.delayed(new Duration(milliseconds: 300)).then((_) {
        if ((oauth as OAuth).isAuthorized) {
          Navigator.of(context).pushReplacementNamed("/router/home");
        } else {
          Navigator.of(context).pushReplacementNamed("/router/login");
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Scaffold(
        body: new Container(
          color: Colors.white,
        ),
      ),
    );
  }
}
