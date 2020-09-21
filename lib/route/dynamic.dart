import 'package:flutter/material.dart';
import '../index.dart';

// 动态
class DynamicNavRoute extends StatefulWidget {
  @override
  _DynamicNavRouteState createState() {
    return _DynamicNavRouteState();
  }
}

class _DynamicNavRouteState extends State<DynamicNavRoute> {
  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: GiteeApi().receivedEvents(queryParameters: {
    //     "page": 1, //page
    //     "per_page": '20',
    //   }),
    //   builder: (BuildContext context, AsyncSnapshot<List<DynamicNews>> snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       print("result -> ${snapshot?.toString()}");
    //       // return Text(
    //       //   snapshot.data ?? "",
    //       //   style: _numberTextStyle(),
    //       // );
    //     }
    //     return Container(width: 0, height: 0);
    //   },
    // );

    return Scaffold(
      appBar: AppBar(title: Text('动态')),
      body: InfiniteListView<DynamicNews>(
        onRetrieveData: (int page, List<DynamicNews> items, bool refresh) async {
          var data = await GiteeApi().receivedEvents(
            queryParameters: {
              "page": page,
              "per_page": '20',
            },
          );
          items.addAll(data);
          return data.length > 0 && data.length % 20 == 0;
        },
        emptyBuilder: (VoidCallback refresh, BuildContext context) {
          return listNoDataView(refresh, context);
        },
        itemBuilder: (List<DynamicNews> list, int index, BuildContext ctx) {
          return _DynamicNewsItemWidget(list[index]);
        },
      ),
    );
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
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubTitle() {
    DynamicType type = DynamicType.INSTANCE.getPrefix(widget.news?.type);
    print("_buildSubTitle........ ${widget.news?.type}  $type");
    switch (type) {
      case DynamicType.MemberEvent:
        break;
      case DynamicType.IssueEvent:
      case DynamicType.IssueCommentEvent:
        return Text(
          "#${widget.news?.payload?.number}  ${widget.news?.payload?.title ?? ""}",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        );
      case DynamicType.PullRequestEvent:
      case DynamicType.PullRequestCommentEvent:
        break;
      case DynamicType.PushEvent:
        break;
      case DynamicType.ProjectCommentEvent:
        break;
      default: //DynamicType.UNKNOWN
        break;
    }
    return Text(
     "${ widget.news?.payload?.comment?.body ?? ""}  ${ widget.news?.payload?.comment?.created_at ?? ""}",
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
    );
  }
}
