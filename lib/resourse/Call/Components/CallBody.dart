import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:astrology/reponsitory/booking_.dart';
import 'package:astrology/resourse/Home/home.dart';
import 'package:astrology/resourse/app_router.dart';
import 'package:flutter/material.dart';
import 'package:astrology/resourse/Call/Components/setting.dart';

class BodyCall extends StatefulWidget {
  final String? chanelName;
  final ClientRole? role;
  final String? token;
  final int? bookingId;

  const BodyCall(
      {Key? key, this.chanelName, this.role, this.token, this.bookingId})
      : super(key: key);

  @override
  State<BodyCall> createState() => _BodyCallState();
}

class _BodyCallState extends State<BodyCall> {
  TextEditingController? feedback = TextEditingController();
  TextEditingController? rate = TextEditingController();
  final _reasonKey = GlobalKey<FormState>();
  final _user = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool viewPanel = false;
  bool banChat = false;
  late RtcEngine _engine;
  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _user.clear();
    _engine.leaveChannel();
    _engine.destroy();
  }

  Future<void> initialize() async {
    if (appId.isEmpty) {
      setState(() {
        _infoStrings.add("AppId is missing, plz input your AppId");
        _infoStrings.add("Agora engine is not star");
      });
      return;
    }
    // initAgoraRTC engine
    _engine = await RtcEngine.create(appId);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(widget.role!);
    // addAdoraEventhandler
    _addAgoraEventHandlers();
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = VideoDimensions(width: 1928, height: 1080);
    await _engine.setVideoEncoderConfiguration(configuration);
    await _engine.joinChannel(widget.token!, widget.chanelName!, null, 0);
  }

  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(
      error: (code) {
        setState(() {
          final info = 'Error' + '$code';
          _infoStrings.add(info);
        });
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        setState(() {
          final info = 'Join chanelName: $channel, Uid: $uid';
          _infoStrings.add(info);
        });
      },
      leaveChannel: (stats) {
        setState(() {
          _infoStrings.add("Leave chanel");
          _user.clear();
        });
      },
      userJoined: (uid, elapsed) {
        setState(() {
          _infoStrings.add("User Join: $uid");
          _user.add(uid);
        });
      },
      userOffline: (uid, reason) {
        setState(() {
          _infoStrings.add("User Out: $uid");
          _user.remove(uid);
        });
      },
      firstRemoteVideoFrame: (uid, width, height, elapsed) {
        _infoStrings.add("First Remote video: $uid ${width}x$height");
      },
    ));
  }

  Widget _viewRows() {
    final List<StatefulWidget> list = [];
    if (widget.role == ClientRole.Broadcaster) {
      list.add(const rtc_local_view.SurfaceView());
    }
    for (var uid in _user) {
      list.add(rtc_remote_view.SurfaceView(
        uid: uid,
        channelId: widget.chanelName!,
      ));
    }
    final views = list;
    return Column(
      children: List.generate(
        views.length,
        (index) => Expanded(
          child: views[index],
        ),
      ),
    );
  }

  Widget _toolbar() {
    if (widget.role == ClientRole.Audience)
      return Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RawMaterialButton(
              onPressed: () => Navigator.pop(context),
              child: const Icon(
                Icons.call_end,
                color: Colors.white,
                size: 35.0,
              ),
              shape: const CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.redAccent,
              padding: const EdgeInsets.all(15.0),
            ),
          ],
        ),
      );
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () {
              setState(() {
                muted = !muted;
              });
              _engine.muteLocalAudioStream(muted);
            },
            child: Icon(muted ? Icons.mic_off : Icons.mic,
                color: muted ? Colors.white : Colors.blueAccent, size: 20.0),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12),
          ),
          RawMaterialButton(
            onPressed: () {
              // => Navigator.pop(context),
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('Thông báo'),
                        content: Text('Vui Lòng đánh giá cuộc hẹn này'),
                        actions: <Widget>[
                          Form(
                            key: _reasonKey,
                            child: TextFormField(
                              controller: feedback,
                              decoration: InputDecoration(
                                  hintText: 'Nhập cảm nhận của bạn...'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập cảm nhận...';
                                }
                                return null;
                              },
                            ),
                          ),
                          TextFormField(
                            controller: rate,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'Nhập rating của bạn...'),
                            validator: (value) {
                              if (int.parse(value!) < 6 ||
                                  int.parse(value!) > 0) {
                                return 'Vui lòng nhập rating...';
                              }
                              return null;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 3),
                                child: ElevatedButton(
                                    onPressed: () {
                                      FeedBack(widget.bookingId!, feedback!,
                                          int.parse(rate!.text));

                                      Navigator.pop(context, 'Xác nhận');
                                    },
                                    child: const Text('Xác nhận')),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 3),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context, 'Hủy');
                                    },
                                    child: const Text('Hủy')),
                              ),
                            ],
                          ),
                        ],
                      ));
              // Navigator.pop(context);
            },
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: () {
              _engine.switchCamera();
            },
            child: const Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12),
          ),
          // RawMaterialButton(
          //   onPressed: () {},
          //   child: Icon(
          //     banChat ? Icons.message_sharp : Icons.messenger,
          //     color: banChat ? Colors.blueAccent : Colors.white,
          //   ),
          // )
        ],
      ),
    );
  }

  Widget _panel() {
    return Visibility(
      visible: viewPanel,
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: FractionallySizedBox(
          heightFactor: 0.5,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: ListView.builder(itemBuilder: (BuildContext context, index) {
              if (_infoStrings.isEmpty) {
                return const Text("Null");
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        _infoStrings[index],
                      ),
                    ))
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Call"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                viewPanel = !viewPanel;
              });
            },
            icon: const Icon(Icons.info_outline),
          )
        ],
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            _viewRows(),
            _panel(),
            _toolbar(),
          ],
        ),
      ),
    );
  }

  // Future<void> Onjoin(
  //   String chanelName,
  //   ClientRole? role,
  //   String? token,
  // ) async {
  //   await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => BodyCall(
  //           chanelName: chanelName,
  //           role: role,
  //           token: token,
  //         ),
  //       ));
  // }
}
