import '../index.dart';

/// 私信,通知,@我
// 列出授权用户的所有通知
// https://gitee.com/api/v5/notifications/threads
// ?access_token=533d2c9e8efa969583515b90af7a0664&type=all&page=1&per_page=20&unread=true
class NotificationsRoute extends StatefulWidget {
  NotificationsRoute({Key key}) : super(key: key);

  @override
  _NotificationsRouteState createState() {
    return _NotificationsRouteState();
  }
}

class _NotificationsRouteState extends State<NotificationsRoute> with SingleTickerProviderStateMixin {
  ///TabBar和TabBarView正是通过同一个controller来实现菜单切换和滑动状态同步的
  TabController _tabController;
  List<String> _tabs = <String>["私信", "通知", "@我"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    //var themeColor=Theme.of(context).primaryColor;
    var themeColor = Colors.white;
    return Scaffold(
      appBar: AppBar(
        title: Text("通知"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: themeColor,
            child: TabBar(
              controller: _tabController,
              tabs: _tabs.map((e) => Tab(text: e)).toList(),
              isScrollable: false,
              //根据背景色亮度来确定Title颜色
              labelColor: themeColor.computeLuminance() < 0.5 ? Colors.white : Colors.black,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _tabs.map((e) {
                return NotificationListWidget(type:(_tabs.indexOf(e)));
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

///通知列表
class NotificationListWidget extends StatefulWidget {
  NotificationListWidget({Key key, this.type}) : super(key: key); //ValueKey("type${type.toString()}"

  final int type;

  @override
  _NotificationListWidgetState createState() {
    return _NotificationListWidgetState();
  }
}

class _NotificationListWidgetState extends State<NotificationListWidget> with AutomaticKeepAliveClientMixin {
  //导航栏切换时保持原有状态
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return InfiniteListView<Object>(
      onRetrieveData: (int page, List<Object> items, bool refresh) async {
        var data;
        print("type ==================> ${widget.type}");
        switch (widget.type) {
          case 0:
            data = await GiteeApi().messagesAll(false, queryParameters: {
              "page": page,
              "per_page": '20',
            });
            break;
          case 1:
            data = await GiteeApi().notificationsAll(true, queryParameters: {
              "page": page,
              "per_page": '20',
            });
            break;
          default:
            data = await GiteeApi().notificationsAll(true, queryParameters: {
              "page": page,
              "per_page": '20',
            });
            break;
        }

        // 把请求到的新数据添加到items中
        items.addAll(data);
        return data.length > 0 && data.length % 20 == 0;
      },
      emptyBuilder: (VoidCallback refresh, BuildContext context) {
        return listNoDataView(refresh, context);
      },
      itemBuilder: (List list, int index, BuildContext ctx) {
        switch (widget.type) {
          case 0:
            return _MessageItemWidget(list[index]);
          case 1:
            return _NotificationItemWidget(list[index]);
          default:
            break;
        }
        return _NotificationItemWidget(list[index]);
      },
      separatorBuilder: (List list, int index, BuildContext ctx) {
        return Container(
          color: Colors.grey[100],
          height: 5.0,
        );
      },
    );
  }
}

// 私信 ItemView
class _MessageItemWidget extends StatefulWidget {
  _MessageItemWidget(this.message) : super(key: ValueKey(message.id));
  final NotifyMessages message;

  @override
  _MessageItemWidgetState createState() {
    return _MessageItemWidgetState();
  }
}

class _MessageItemWidgetState extends State<_MessageItemWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.message?.sender?.name ?? ""}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16, color: colorNotifyTitle),
          ),
          SizedBox(height: 10.0),

          ///todo 2020-09-18 17:12:06 识别 content 中的 链接
          Text(
            "${widget.message?.content ?? ""}",
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    ));
  }
}

// 通知 ItemView
class _NotificationItemWidget extends StatefulWidget {
  _NotificationItemWidget(this.notification) : super(key: ValueKey(notification.id));
  final Notifications notification;

  @override
  _NotificationItemWidgetState createState() {
    return _NotificationItemWidgetState();
  }
}

class _NotificationItemWidgetState extends State<_NotificationItemWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.notification?.content ?? ""}",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 15, color: colorNotifyTitle),
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Text(
                "${widget.notification?.updated_at ?? ""}",
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(width: 15.0),
              Text(
                "${widget.notification?.repository?.full_name ?? ""}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    ));
  }
}

// @我 ItemView
