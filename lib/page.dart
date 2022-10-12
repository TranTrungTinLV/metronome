import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'indactor.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _bmp = 40;
  int _cq = -1;
  int _step = -1;
  Timer? timer;
  bool _isRunning = false;
  bool _isIcon = false;
  late AnimationController controller;
  int _beats = 2;
  int _counter = 0;

  bool timing = false;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }
  }

  void _setStep() {
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
      _playAudio()?.then((value) => _setStep());
      runTimer();
      setState(() {
        _cq++;
      });
    });
  }

  void _inrebmp() {
    setState(() {
      if (_bmp >= 210) {
        return;
      }
      setState(() {
        _bmp++;
      });
    });
  }

  void _derementbmp() {
    setState(() {
      if (_bmp <= 40) {
        return;
      }
      setState(() {
        _bmp--;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(200, 60),
        child: AppBar(
          backgroundColor: Color(0xFF303030),
          title: Center(
            child: Container(
                margin: const EdgeInsets.only(top: 27),
                height: 30,
                child: const Text(
                  'TEMPO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFFFFFFFF),
                  ),
                )),
          ),
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IndactorRow(_cq, _beats),
            Container(
              padding: const EdgeInsets.only(
                  bottom: 33, left: 37, right: 29, top: 30),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          _derementbmp();
                        });
                      },
                      child: const Icon(
                        FontAwesomeIcons.subtract,
                        size: 30,
                      ),
                    ),
                    Text(
                      _bmp.toString(),
                      style: const TextStyle(fontSize: 64),
                    ),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          _inrebmp();
                        });
                      },
                      child: const Icon(
                        FontAwesomeIcons.plus,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 3.0,
                  ),
                  child: Container(
                    child: Slider(
                      value: _bmp.toDouble(),
                      min: 40,
                      max: 210,
                      activeColor: const Color(0xFFFAFAFA),
                      inactiveColor: const Color(0xFFD6D6D6),
                      onChanged: (double newValue) {
                        setState(() {
                          _bmp = newValue.round();
                        });
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  setState(() {
                                    if (_beats >= 4) {
                                      return;
                                    }
                                    _beats = _beats + 3;
                                    _cq = _step;
                                    _counter = 0;
                                  });

                                  setState(() {
                                    if (_beats <= 2) {
                                      return;
                                    }
                                    _beats = _beats - 2;
                                    _cq = _step;
                                    _counter = 0;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    _beats.toString() + '/4',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                          onPressed: () {},
                          child: Expanded(
                            child: Center(
                              child: Container(
                                // margin: EdgeInsets.only(right: 20),
                                padding: const EdgeInsets.only(right: 20),
                                child: IconButton(
                                  icon: AnimatedIcon(
                                    size: 50,
                                    icon: AnimatedIcons.play_pause,
                                    progress: controller,
                                  ),
                                  onPressed: () {
                                    _toglleisRunning();
                                    setState(() {
                                      _isIcon = !_isIcon;
                                      _isIcon
                                          ? controller.forward()
                                          : controller.reverse();
                                    });
                                  },
                                ),
                              ),
                            ),
                          )),
                    ),
                    Expanded(child: Container())
                  ],
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
