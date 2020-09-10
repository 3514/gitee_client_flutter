import 'package:flutter/material.dart';
import 'package:gitee_client_flutter/common/gitee_api.dart';

import '../index.dart';

///类似Android中 TabLayout+ViewPager 效果
class HomeTabViewPagerWidget extends StatefulWidget {
  @override
  _HomeTabViewPagerWidgetState createState() => _HomeTabViewPagerWidgetState();
}

class _HomeTabViewPagerWidgetState extends State<HomeTabViewPagerWidget>
    with SingleTickerProviderStateMixin {
  ///TabBar和TabBarView正是通过同一个controller来实现菜单切换和滑动状态同步的
  TabController _tabController;
  List<TabTitleHome> _tabs = TabTitleHome.values;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ///TabBar
        TabBar(
          controller: _tabController,
          tabs: _tabs
              .map((e) => Tab(
                    text: e.title,
                  ))
              .toList(),
        ),

        ///TabBarView
        Expanded(
          child: TabBarView(
            controller: _tabController,
            //创建n个Tab页
            // children: _tabs.map((e) {
            // return   _HomeListWidget(e);
            // }).toList(),
            children: [
              Container(
                color: Theme.of(context).primaryColorLight.withOpacity(0.5),
                width: double.infinity,
              ),
              _HomeListWidget(TabTitleHome.Popular),
              _HomeListWidget(TabTitleHome.Recent),
            ],
          ),
        ),
      ],
    );
  }
}

///项目
class _HomeListWidget extends StatefulWidget {
  _HomeListWidget(this.tab, {Key key}) : super(key: ValueKey(tab.name));

  final TabTitleHome tab;

  @override
  _HomeListWidgetState createState() {
    return _HomeListWidgetState();
  }
}

class _HomeListWidgetState extends State<_HomeListWidget> with AutomaticKeepAliveClientMixin {

  //导航栏切换时保持原有状态
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print("_HomeListWidgetState initState ${widget.tab}");
  }

  @override
  void dispose() {
    super.dispose();print("_HomeListWidgetState dispose");
  }

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
      itemBuilder: (List list, int index, BuildContext ctx) {
        // 项目信息列表项
        return _RepoItemWidget(list[index]);
      },
    );
  }
}

///项目列表 ItemView
class _RepoItemWidget extends StatefulWidget {
  _RepoItemWidget(this.repo) : super(key: ValueKey(repo.id));
  final RepoFeature repo;

  @override
  __RepoItemWidgetState createState() {
    return __RepoItemWidgetState();
  }
}

class __RepoItemWidgetState extends State<_RepoItemWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                leading: gmAvatar(
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
                    color: Colors.black,
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
