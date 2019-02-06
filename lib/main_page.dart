import 'package:flutter/material.dart';
import 'package:volume/volume.dart';

class MainPage extends StatefulWidget {
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<DropdownMenuItem> list = [];
  int maxVol, currentVol;
  int selectedControl = 0;
  void initState() {
    super.initState();
    initList();
    updateVolumes();
  }

  updateVolumes() async {
    // get Max Volume
    maxVol = await Volume.getMaxVol;
    // get Current Volume
    currentVol = await Volume.getVol;
    setState(() {});
  }

  setVol(int i) async {
    await Volume.setVol(i);
  }

  initList() {
    list = [
      DropdownMenuItem(
        child: Center(
          child: ListTile(
            leading: Icon(Icons.volume_up),
            title: Text(
              "System Volume",
              textAlign: TextAlign.center,
            ),
            selected: selectedControl == 0,
          ),
        ),
        value: 0,
      ),
      DropdownMenuItem(
        child: Center(
          child: ListTile(
            leading: Icon(Icons.music_note),
            title: Text(
              "Media Volume",
              textAlign: TextAlign.center,
            ),
            selected: selectedControl == 4,
          ),
        ),
        value: 4,
      ),
      DropdownMenuItem(
        child: Center(
          child: ListTile(
            leading: Icon(Icons.notifications),
            title: Text(
              "Notifications Volume",
              textAlign: TextAlign.center,
            ),
            selected: selectedControl == 1,
          ),
        ),
        value: 1,
      ),
      DropdownMenuItem(
        child: Center(
          child: ListTile(
            leading: Icon(Icons.alarm),
            title: Text(
              "Alarm Volume",
              textAlign: TextAlign.center,
            ),
            selected: selectedControl == 5,
          ),
        ),
        value: 5,
      ),
      DropdownMenuItem(
        child: Center(
          child: ListTile(
            leading: Icon(Icons.ring_volume),
            title: Text(
              "Ring Volume",
              textAlign: TextAlign.center,
            ),
            selected: selectedControl == 2,
          ),
        ),
        value: 2,
      ),
      DropdownMenuItem(
        child: Center(
          child: ListTile(
            leading: Icon(Icons.call),
            title: Text(
              "InCall Volume",
              textAlign: TextAlign.center,
            ),
            selected: selectedControl == 3,
          ),
        ),
        value: 3,
      ),
    ];
  }

  onDropdownSelect(int i) {
    selectedControl = i;
    switch (i) {
      case 0:
        {
          Volume.controlVolume(AudioManager.STREAM_SYSTEM);
        }
        break;
      case 1:
        {
          Volume.controlVolume(AudioManager.STREAM_NOTIFICATION);
        }
        break;
      case 2:
        {
          Volume.controlVolume(AudioManager.STREAM_RING);
        }
        break;
      case 3:
        {
          Volume.controlVolume(AudioManager.STREAM_VOICE_CALL);
        }
        break;
      case 4:
        {
          Volume.controlVolume(AudioManager.STREAM_MUSIC);
        }
        break;
      case 5:
        {
          Volume.controlVolume(AudioManager.STREAM_ALARM);
        }
        break;
    }
    updateVolumes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Volume Controller"),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Icon(
                (selectedControl == 0)
                    ? Icons.volume_up
                    : (selectedControl == 1)
                        ? Icons.notifications
                        : (selectedControl == 4)
                            ? Icons.music_note
                            : (selectedControl == 5)
                                ? Icons.alarm
                                : (selectedControl == 2)
                                    ? Icons.ring_volume
                                    : Icons.call,
                size: 80.0,
                color: Colors.teal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DropdownButton(
                items: list,
                iconSize: 50.0,
                onChanged: (i) {
                  onDropdownSelect(i);
                  initList();
                  setState(() {});
                },
                value: selectedControl,
                isExpanded: true,
              ),
            ),
            (currentVol != null || maxVol != null)
                ? (currentVol <= maxVol)
                    ? Slider(
                        value: currentVol / 1.0,
                        divisions: maxVol,
                        max: maxVol / 1.0,
                        min: 0,
                        onChanged: (double d) {
                          setVol(d.toInt());
                          updateVolumes();
                        },
                        label: currentVol.toString(),
                      )
                    : Container()
                : Container(),
          ],
        ),
      ),
    );
  }
}
