import '../index.dart';

//项目列表 ItemView v3
class RepoListItemWidgetV3 extends StatefulWidget {
  RepoListItemWidgetV3(this.repo) : super(key: ValueKey(repo.id));
  final RepoV3 repo;

  @override
  _RepoListItemWidgetV3State createState() => _RepoListItemWidgetV3State();
}

class _RepoListItemWidgetV3State extends State<RepoListItemWidgetV3> {
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

// 项目列表
class RepoListWidget extends StatefulWidget {
  RepoListWidget(this.tab, {Key key}) : super(key: ValueKey(tab));
  final int tab;

  @override
  _RepoListWidgetState createState() => _RepoListWidgetState();
}

class _RepoListWidgetState extends State<RepoListWidget> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; //导航栏切换时保持原有状态

  @override
  Widget build(BuildContext context) {
    return InfiniteListView<Repo>(
      onRetrieveData: (int page, List<Repo> items, bool refresh) async {
        var data;
        if (widget.tab == 0) {
          data = await GiteeApi().getRepoList(page);
        } else if (widget.tab == 1) {
          data = await GiteeApi().getRepoStarList(page: page);
        }
        items.addAll(data); // 把请求到的新数据添加到items中
        return data.length > 0 && data.length % 20 == 0;
      },
      emptyBuilder: (VoidCallback refresh, BuildContext context) => listNoDataView(refresh, context),
      itemBuilder: (List<Repo> list, int index, BuildContext ctx) => RepoListItemWidget(list[index]), // 项目信息列表项
    );
  }
}

//项目列表 ItemView
class RepoListItemWidget extends StatefulWidget {
  RepoListItemWidget(this.repo) : super(key: ValueKey(repo.id));
  final Repo repo;

  @override
  _RepoItemWidgetState createState() => _RepoItemWidgetState();
}

class _RepoItemWidgetState extends State<RepoListItemWidget> {
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
                  widget.repo?.owner?.avatar_url ?? widget.repo.owner.portrait_url,
                  width: 35.0,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(50),
                ),
                title: Text(
                  widget.repo?.full_name ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  widget.repo?.description ?? "",
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
