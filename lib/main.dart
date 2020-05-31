import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo();
  RewardedVideoAd myAd = RewardedVideoAd.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rewarded Apps',
        ),
      ),
      body: Center(
        child: RaisedButton(
          child: Text(
            'Get ad',
          ),
          onPressed: () async {
            myAd.load(
              adUnitId: RewardedVideoAd.testAdUnitId,
              targetingInfo: targetingInfo,
            );
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      backgroundColor: Colors.pink,
                      strokeWidth: 8,
                    ),
                  ],
                );
              },
            );
            myAd.listener = (
              RewardedVideoAdEvent event, {
              String rewardType,
              int rewardAmount,
            }) {
              if (event == RewardedVideoAdEvent.loaded) {
                Navigator.pop(context);
                myAd.show();
              }
              if (event == RewardedVideoAdEvent.rewarded ||
                  event == RewardedVideoAdEvent.failedToLoad) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Rew(),
                  ),
                );
              }
              if (event == RewardedVideoAdEvent.failedToLoad) {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Rew(),
                  ),
                );
              }
            };
          },
        ),
      ),
    );
  }
}

class Rew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Rewarded'),
      ),
    );
  }
}
