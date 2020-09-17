import '../index.dart';

//项目列表 ItemView
class RepoItemWidget extends StatefulWidget {
  RepoItemWidget(this.repo) : super(key: ValueKey(repo.id));
  final RepoV3 repo;

  @override
  _RepoItemWidgetState createState() {
    return _RepoItemWidgetState();
  }
}

class _RepoItemWidgetState extends State<RepoItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Material(
        color: Colors.white,
        shape: BorderDirectional(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: .5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                dense: true,
                leading: getAvatarRect(
                  //项目owner头像
                  widget.repo.owner.avatar_url ?? widget.repo.owner.portrait_url,
                  width: 35.0,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(50),
                ),
                title: Text(
                  widget.repo.name_with_namespace,
                  textScaleFactor: .9,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  widget.repo.description ?? "",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                trailing: Text(
                  widget.repo.language ?? "",
                  style: TextStyle(
                    color: Colors.deepOrange[700],
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
