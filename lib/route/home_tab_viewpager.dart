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
    return InfiniteListView<RepoV3>(
      onRetrieveData: (int page, List<RepoV3> items, bool refresh) async {
        var data = await GiteeApi().getRepoList(
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
        return listNoDataView(refresh, context);
      },
      itemBuilder: (List list, int index, BuildContext ctx) {
        // 项目信息列表项
        return RepoItemWidget(list[index]);
      },
    );
  }
}
