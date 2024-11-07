import 'package:flutter/material.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:video_conference/ui/widgets/widgets.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String serverUrl;
  late bool audioMuted;
  late bool videoMuted;
  late String roomName;
  late String userDisplayName;

  @override
  void initState() {
    super.initState();
    serverUrl = "https://meet.jit.si";
    audioMuted = true;
    videoMuted = true;
    roomName = "";
    userDisplayName = "";
  }

  @override
  Widget build(BuildContext context) {
    final jitsiMeetPlugin = JitsiMeet();

    join() async {
      var options = JitsiMeetConferenceOptions(
        room: roomName,
        configOverrides: {
          "startWithAudioMuted": audioMuted,
          "startWithVideoMuted": videoMuted,
        },
        userInfo: JitsiMeetUserInfo(
          displayName: userDisplayName,
          avatar:
          "https://www.shutterstock.com/image-vector/blank-avatar-photo-place-holder-600nw-1114445501.jpg",
        ),
      );
      await jitsiMeetPlugin.join(options);
    }

    void onServerUrlChange(String value) {
      setState(() {
        serverUrl = value;
      });
    }

    void onRoomNameChange(String value) {
      setState(() {
        roomName = value;
      });
    }

    void onUserDisplayNameChange(String value) {
      setState(() {
        userDisplayName = value;
      });
    }

    void onAudioOnChange(bool value) {
      setState(() {
        audioMuted = value;
      });
    }

    void onVideoOnChange(bool value) {
      setState(() {
        videoMuted = value;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video conference with Jitsi Meet'),
      ),
      resizeToAvoidBottomInset:
      true, // This allows the screen to resize when the keyboard is shown
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Gap(20),
              const Text('Enter your details to join the room'),
              const Gap(20),
              TextFieldWidget(
                text: serverUrl,
                onTextChange: onServerUrlChange,
                hintText: 'Server URL',
              ),
              const Gap(20),
              TextFieldWidget(
                text: roomName,
                onTextChange: onRoomNameChange,
                hintText: 'Room name',
              ),
              const Gap(20),
              TextFieldWidget(
                text: userDisplayName,
                onTextChange: onUserDisplayNameChange,
                hintText: 'Display name',
              ),
              const Gap(20),
              CheckBoxWidget(
                icon: Icons.volume_up,
                label: 'Audio Muted',
                isChecked: audioMuted,
                onCheck: onAudioOnChange,
              ),
              const Gap(20),
              CheckBoxWidget(
                icon: Icons.videocam,
                label: 'Video Muted',
                isChecked: videoMuted,
                onCheck: onVideoOnChange,
              ),
              const Gap(20),
              ButtonWidget(
                text: 'Join',
                onPressed: join,
              ),
            ],
          ),
        ),
      ),
    );
  }
}