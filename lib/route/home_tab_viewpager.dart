import 'package:flutter/material.dart';
import 'package:gitee_client_flutter/common/gitee_api.dart';

import '../index.dart';

///项目列表
class HomeListWidget extends StatefulWidget {
  HomeListWidget(this.tab, {Key key}) : super(key: ValueKey(tab.name));

  final TabTitleHome tab;

  @override
  _HomeListWidgetState createState() {
    return _HomeListWidgetState();
  }
}

class _HomeListWidgetState extends State<HomeListWidget> with AutomaticKeepAliveClientMixin {
  //导航栏切换时保持原有状态
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return InfiniteListView<RepoFeature>(
      onRetrieveData: (int page, List<RepoFeature> items, bool refresh) async {
        var data = await GiteeApi(context).getRepoList(
          tab: widget.tab,
          refresh: refresh,
          queryParameters: {
            'page': page,
          },
        );
        // 把请求到的新数据添加到items中
        items.addAll(data);
        return data.length > 0 && data.length % 20 == 0;
      },
      emptyBuilder: (VoidCallback refresh, BuildContext context) {
        return _listNoDataView(refresh, context);
      },
      itemBuilder: (List list, int index, BuildContext ctx) {
        // 项目信息列表项
        return _RepoItemWidget(list[index]);
      },
    );
  }
}

Widget _listNoDataView(refresh, context) {
  return Material(
    child: InkWell(
      splashColor: Theme.of(context).secondaryHeaderColor,
      onTap: refresh,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.event_busy,
                color: Theme.of(context).primaryColor,
                size: 150,
              ),
              Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Text(
                    "没有数据",
                    style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18),
                  ))
            ],
          ),
        ),
      ),
    ),
  );
}

///项目列表 ItemView
class _RepoItemWidget extends StatefulWidget {
  _RepoItemWidget(this.repo) : super(key: ValueKey(repo.id));
  final RepoFeature repo;

  @override
  _RepoItemWidgetState createState() {
    return _RepoItemWidgetState();
  }
}

class _RepoItemWidgetState extends State<_RepoItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Material(
        color: Colors.white,
        shape: BorderDirectional(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: .5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                dense: true,
                leading: getAvatarRect(
                  //项目owner头像
                  widget.repo.owner.portrait_url,
                  width: 35.0,
                  fit: BoxFit.fill,
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
                    fontSize: 12,
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
