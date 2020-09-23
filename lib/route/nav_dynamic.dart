import '../index.dart';

// 动态
class DynamicRoute extends StatefulWidget {
  @override
  _DynamicRouteState createState() => _DynamicRouteState();
}

class _DynamicRouteState extends State<DynamicRoute> {
  @override
  Widget build(BuildContext context) {
    final UserModel userModel = Provider.of<UserModel>(context);
    return Scaffold(appBar: AppBar(title: Text('动态')), body: _buildDynamicBody(userModel));
  }

  Widget _buildDynamicBody(UserModel userModel) {
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
      return InfiniteListView<DynamicNews>(
        onRetrieveData: (int page, List<DynamicNews> items, bool refresh) async {
          var data = await GiteeApi().receivedEvents(queryParameters: {"page": page, "per_page": '20'});
          items.addAll(data);
          return data.length > 0 && data.length % 20 == 0;
        },
        emptyBuilder: (VoidCallback refresh, BuildContext context) {
          return listNoDataView(refresh, context);
        },
        itemBuilder: (List<DynamicNews> list, int index, BuildContext ctx) {
          return _DynamicNewsItemWidget(list[index]);
        },
      );
    }
  }
}

//动态列表 ItemView
class _DynamicNewsItemWidget extends StatefulWidget {
  _DynamicNewsItemWidget(this.news) : super(key: ValueKey(news.id));
  final DynamicNews news;

  @override
  _RepoDynamicNewsItemWidgetState createState() {
    return _RepoDynamicNewsItemWidgetState();
  }
}

class _RepoDynamicNewsItemWidgetState extends State<_DynamicNewsItemWidget> {
  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        color: Colors.white,
        shape: BorderDirectional(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: .5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.all(15),
              dense: true,
              leading: getAvatarRect(
                //项目owner头像
                widget.news?.actor?.avatar_url ?? "",
                width: 35.0,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(50),
              ),
              title: Text(
                widget.news?.actor?.name ?? "",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              subtitle: _buildSubTitle(),
              trailing: Text(
                (widget.news?.type ?? "").replaceAll("Event", ""),
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 10,
                ),
              ),
              onTap: () {
                //todo 2020年9月23日 跳转
                //navToWeb(context: context, url: widget.news?.repo?.namespace?.html_url ?? "");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubTitle() {
    DynamicType type = DynamicType.INSTANCE.getPrefix(widget.news?.type);
    //print("_buildSubTitle........ ${widget.news?.type}  $type");
    switch (type) {
      case DynamicType.MemberEvent:
        return Text(
          "${widget.news?.repo?.full_name}  ${widget.news?.repo?.human_name}",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        );
        break;
      case DynamicType.IssueEvent:
      case DynamicType.PullRequestEvent:
        return Text(
          "#${widget.news?.payload?.number}  ${widget.news?.payload?.title ?? ""}",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        );
      case DynamicType.IssueCommentEvent:
        break;
      case DynamicType.PullRequestCommentEvent:
        return Text(
          "${widget.news?.payload?.pull_request?.title}  ",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        );
        break;
      case DynamicType.PushEvent:
        return Text(
          "${widget.news?.payload?.commits[0]?.message}  ",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        );
        break;
      case DynamicType.ProjectCommentEvent:
        break;
      default: //DynamicType.UNKNOWN
        break;
    }
    return Text(
      "${widget.news?.payload?.comment?.body ?? ""}  ${widget.news?.payload?.comment?.created_at ?? ""}",
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
    );
  }
}
