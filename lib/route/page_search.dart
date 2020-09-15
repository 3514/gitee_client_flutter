import 'package:gitee_client_flutter/route/search/search_page_repos.dart';

import '../index.dart';

class SearchPageRoute extends StatefulWidget {
  SearchPageRoute({Key key}) : super(key: key);

  @override
  _SearchPageRouteState createState() {
    return _SearchPageRouteState();
  }
}

class _SearchPageRouteState extends State<SearchPageRoute>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  String searchWords;
  var statusBarHeight; //状态栏高度
  TabController tabController;
  Color backColor; //当前页面的主题色，为默认主题色
  TextEditingController _editController = TextEditingController();
  List<String> historyData = new List<String>();

  //
  var mTabs = <String>['仓库', "用户"];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    statusBarHeight = getStatusBarHeight();
    tabController = TabController(length: 2, vsync: this);
    var shareData = Global.prefs.getStringList(PREFS_SEARCH_HISTORY);
    if (shareData != null && shareData.length > 0) {
      historyData.addAll(shareData);
    }
  }

  @override
  void dispose() {
    super.dispose();
    Global.prefs.setStringList(PREFS_SEARCH_HISTORY, historyData);
  }

  @override
  Widget build(BuildContext context) {
    backColor = getThemeColor(context);

    // return  Hero(
    //   tag: hero_tag_search,
    //   child: Icon(
    //     Icons.search,
    //     color: Colors.grey,
    //   ),
    //   ),
    // );
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            //搜索框，一个状态栏大小的背景
            SliverPersistentHeader(
              pinned: true,
              delegate: MySliverPersistentHeaderDelegate(
                minHeight: statusBarHeight + 57,
                maxHeight: statusBarHeight + 57,
                child: Container(
                  padding: EdgeInsets.only(top: statusBarHeight),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: backColor,
                            size: 20,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: TextField(
                            controller: _editController,
                            autofocus: false,
                            maxLines: 1,
                            style: TextStyle(fontSize: 14),
                            cursorColor: backColor,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (val) {
                              _beginSearch();
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              //密集排布
                              prefixIcon: InkWell(
                                child: Hero(
                                  tag: hero_tag_search,
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                ),
                                onTap: () {
                                  _beginSearch();
                                },
                              ),
                              suffixIcon: InkWell(
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.grey,
                                ),
                                onTap: () {
                                  _editController.clear();
                                },
                              ),
                              hintText: '搜索或者跳转到...',
                              hintStyle: TextStyle(fontSize: 14),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: backColor,
                                    width: .5,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: backColor,
                                    width: .5,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                          child: Padding(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            child: Text(
                              "搜索",
                              style: TextStyle(fontSize: 17, color: backColor),
                            ),
                          ),
                          onTap: () {
                            _beginSearch();
                          }),
                    ],
                  ),
                ),
              ),
            ),

            //搜索历史记录
            SliverPersistentHeader(
              pinned: false,
              delegate: MySliverPersistentHeaderDelegate(
                minHeight: 80,
                maxHeight: 110,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          top: BorderSide(color: Color(0xffececec), width: 5),
                          bottom: BorderSide(color: Color(0xffececec), width: 5))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                '搜索历史',
                                style: TextStyle(
                                  color: backColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: InkWell(
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                onTap: () {
                                  _showClearHistoryDialog();
                                },
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          height: 40,
                          width: double.infinity,
                          child: _buildHistory(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //状态栏
            SliverPersistentHeader(
              pinned: true,
              delegate: MySliverPersistentHeaderDelegate(
                minHeight: 45,
                maxHeight: 45,
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: TabBar(
                      labelColor: backColor,
                      labelStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: backColor,
                      indicatorSize: TabBarIndicatorSize.label,
                      controller: tabController,
                      tabs: mTabs
                          .map((String label) => Tab(
                                text: label,
                              ))
                          .toList(),
                    )),
              ),
            ),
          ];
        },
        body: _buildBody(),
      ),
    );
  }

  _beginSearch() async {
    if (_editController.text == null || _editController.text.length <= 0) {
      showToast("搜索内容不能为空");
    } else {
      if (searchWords != null) {
        eventBus.fire(SearchEvent(searchWords: _editController.text));
      }
      setState(() {
        searchWords = _editController.text;
      });
      //如果搜索的字段不在历史记录中，添加到历史记录
      if (!historyData.contains(searchWords)) {
        setState(() {
          historyData.add(searchWords);
        });
      }
      //搜索完成收起软键盘
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  Widget _buildHistory() {
    if (historyData == null || historyData.length == 0) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Center(
          child: Text(
            '暂时没有搜索记录',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: historyData.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: EdgeInsets.only(right: 10),
            color: Color(0xffececec),
            child: Center(
              child: Text(
                historyData[index],
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          onTap: () {
            _editController.text = historyData[index];
            _beginSearch();
          },
        );
      },
    );
  }

  //清空历史记录
  Future<bool> _showClearHistoryDialog() {
    if (historyData != null && historyData.length > 0) {
      return showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("确定要清空所有搜索历史记录吗？"),
              actions: <Widget>[
                FlatButton(
                  child: Text('取消'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                FlatButton(
                    child: Text('确定'),
                    onPressed: () {
                      setState(() {
                        historyData.clear();
                      });
                      Navigator.of(context).pop();
                    })
              ],
            );
          });
    } else {
      showToast('暂时没有搜索记录');
    }
  }

  _buildBody() {
    if (searchWords == null || searchWords.length <= 0) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
                size: 150,
              ),
              Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Text(
                    "哥们，搜点啥",
                    style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 25),
                  ))
            ],
          ),
        ),
      );
    } else {
      return TabBarView(
        controller: tabController,
        children: <Widget>[
          SearchPageRepos(
            searchWords: searchWords,
          ),
          SearchPageRepos(
            searchWords: searchWords,
          )
        ],
      );
    }
  }
}
