import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'reusableCard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _bmp = 40;
  int _step = -1;
  Timer? timer;
  bool _isRunning = false;
  bool _isIcon = false;
  late AnimationController controller;
  int _beats = 4;
  int _counter = 0;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }
  }

  void setStep() {
    setState(() {
      _step++;
    });
  }

  void PlaySound(int number) {
    final assetAudio = AudioPlayer();
    assetAudio.play(AssetSource("sound$number.mp3"));
  }

  void _toglleisRunning() {
    if (_isRunning) {
      timer?.cancel();
    } else {
      runTimer();
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  Future<void>? _playAudio() {
    int nextStep = _step + 1;
    if (_counter == _beats) {
      _counter = 0;
    }
    if (nextStep % 4 == 0 && _counter == 0) {
      PlaySound(1);
    } else {
      PlaySound(2);
    }
    _counter++;
  }

  void runTimer() {
    timer = Timer(Duration(milliseconds: ((60 / _bmp) * 1000).round()), () {
      _playAudio()?.then((value) => setStep());
      runTimer();
    });
  }

  void _inrement() {
    setState(() {
      if (_beats >= 12) {
        return;
      }
      setState(() {
        _beats++;
        _counter = 0;
      });
    });
  }

  void _derement() {
    setState(() {
      if (_beats <= 2) {
        return;
      }
      setState(() {
        _beats--;
        _counter = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Metronome'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
              child: Text(
            'Metronome',
            style: TextStyle(fontSize: 40),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Text(
                _bmp.toString(),
                style: TextStyle(fontSize: 20),
              ),
              Text("bmp"),
            ],
          ),
          Slider(
            value: _bmp.toDouble(),
            min: 40,
            max: 210,
            activeColor: Colors.black,
            inactiveColor: Colors.greenAccent,
            onChanged: (double newValue) {
              setState(() {
                _bmp = newValue.round();
              });
            },
          ),
          FlatButton(
              onPressed: () {},
              child: Expanded(
                child: Container(
                  child: IconButton(
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.play_pause,
                      progress: controller,
                    ),
                    onPressed: () {
                      _toglleisRunning();
                      setState(() {
                        _isIcon = !_isIcon;
                        _isIcon ? controller.forward() : controller.reverse();
                      });
                    },
                  ),
                ),
              )),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        _derement();
                      },
                      child: Icon(
                        FontAwesomeIcons.subtract,
                        size: 20,
                      ),
                    ),
                    Text(_beats.toString()),
                    FlatButton(
                      onPressed: () {
                        _inrement();
                      },
                      child: Icon(
                        FontAwesomeIcons.plus,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                Text('BEATS PER MEASURE')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
