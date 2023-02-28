import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'constants.dart';
import 'utils/rive_utils.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  // Need it only for demo
  late SMIBool searchTigger;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: backgroundColor2.withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                bottomNavs.length,
                (index) => GestureDetector(
                  onTap: () {
                    bottomNavs[index].input?.change(true);
                    Future.delayed(
                      const Duration(seconds: 1),
                      () {
                        bottomNavs[index].input?.change(false);
                      },
                    );
                  },
                  child: SizedBox(
                    height: 36,
                    width: 36,
                    child: RiveAnimation.asset(
                      bottomNavs.first.src,
                      artboard: bottomNavs[index].artboard,
                      onInit: (artboard) {
                        StateMachineController controller = RiveUtils.getRiveController(
                          artboard,
                          stateMachineName: bottomNavs[index].stateMachineName,
                        );
                        bottomNavs[index].input = controller.findSMI('active') as SMIBool;
                      },
                    ),
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

class RiveAsset {
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;

  RiveAsset({
    required this.src,
    required this.artboard,
    required this.stateMachineName,
    required this.title,
    this.input,
  });

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> bottomNavs = [
  RiveAsset(src: 'assets/RiveAssets/icons.riv', artboard: 'CHAT', stateMachineName: 'CHAT_Interactivity', title: 'Chat',),
  RiveAsset(src: 'assets/RiveAssets/icons.riv', artboard: 'SEARCH', stateMachineName: 'SEARCH_Interactivity', title: 'Search',),
  RiveAsset(src: 'assets/RiveAssets/icons.riv', artboard: 'TIMER', stateMachineName: 'TIMER_Interactivity', title: 'Timer',),
  RiveAsset(src: 'assets/RiveAssets/icons.riv', artboard: 'BELL', stateMachineName: 'BELL_Interactivity', title: 'Notification',),
  RiveAsset(src: 'assets/RiveAssets/icons.riv', artboard: 'USER', stateMachineName: 'USER_Interactivity', title: 'Profile',),
];