import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:soundy/constants/mycolors.dart';

class PlayScreen extends StatefulWidget {
  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  bool isPlaying = true;
  int playerID;
  AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  Duration _position = Duration(seconds: 0);
  Duration totalDuration;

  Widget _playPauseButton(double h , double w) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isPlaying = !isPlaying;
        });
        _assetsAudioPlayer.playOrPause();
      },
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: AppColors.magnettaColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.magnettaColorLight,
              spreadRadius: 3.0,
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
          size: 32,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _previousButton(double h , double w) {
    return GestureDetector(
      child: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          color: AppColors.magnettaColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.magnettaColor,
              spreadRadius: 3.0,
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Icon(
          Icons.skip_previous,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _nextButton(double h , double w) {
    return GestureDetector(
      child: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          color: AppColors.magnettaColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.magnettaColor,
              spreadRadius: 3.0,
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Icon(
          Icons.skip_next,
          color: Colors.white,
        ),
      ),
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return duration.inHours == 0 ? "$twoDigitMinutes:$twoDigitSeconds" : "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void initState() {
    _assetsAudioPlayer.open(
      Audio("assets/audio/courage.mp3"),
      autoStart: true,
      showNotification: true,
    );
    _assetsAudioPlayer.current.listen((event) {
      setState(() {
        totalDuration = event.audio.duration;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _assetsAudioPlayer.stop();
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: AppColors.magnettaColor,
            onPressed: () => Navigator.pop(context),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.equalizer),
              color: AppColors.magnettaColor,
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: screenHeight*0.07,),
              Container(
                width: screenWidth*0.6,
                height: screenWidth*0.6,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/albumart/album2.png'),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.magnettaColor,
                        blurRadius: 40.0,
                        spreadRadius: 10.0,
                      ),
                    ]),
              ),
              SizedBox(
                height: screenHeight * 0.07,
              ),
              Text(
                "Courage by Bishop T.D.",
                style: TextStyle(color: Colors.white, fontSize: 17.0),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              StreamBuilder(
                stream: _assetsAudioPlayer.currentPosition,
                builder: (context, snapshot){
                  return Text(
                    "${_printDuration(snapshot.data)} / ${_printDuration(totalDuration)}",
                    style:
                    TextStyle(color: AppColors.magnettaColor, fontSize: 17.0),
                  );
                },
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: StreamBuilder(
                    stream: _assetsAudioPlayer.currentPosition,
                    builder: (context, snapshot){
                      return FlutterSlider(
                        values: [double.parse(snapshot.data.inSeconds.toString())],
                        max: double.parse(totalDuration.inSeconds.toString()),
                        tooltip: FlutterSliderTooltip(disabled: true),
                        trackBar: FlutterSliderTrackBar(
                          inactiveTrackBar: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.magnettaColor.withOpacity(0.5),
                          ),
                          activeTrackBar: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColors.magnettaColor),
                        ),
                        handler: FlutterSliderHandler(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.magnettaColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        handlerHeight: 25.0,
                        min: 0,
                        onDragging: (handlerIndex, lowerValue, upperValue) {
                          setState(() {
                            _position = Duration(seconds: lowerValue.round());
                            _assetsAudioPlayer.seek(_position);
                          });
                        },
                      );
                    },
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _previousButton(screenHeight * 0.15, screenWidth * 0.15),
                  SizedBox(
                    width: screenWidth * 0.11,
                  ),
                  _playPauseButton(screenHeight * 0.2, screenWidth * 0.2),
                  SizedBox(
                    width: screenWidth * 0.11,
                  ),
                  _nextButton(screenHeight * 0.15, screenWidth * 0.15)
                ],
              ),
            ],
          ),
        ));
  }
}
