import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class bottomNavigationBar extends StatefulWidget {
  final ontop;
  final selected;
  const bottomNavigationBar({Key? key, this.ontop, this.selected})
      : super(key: key);

  @override
  State<bottomNavigationBar> createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar>
    with TickerProviderStateMixin {
  late AnimationController idleAnimation;
  late AnimationController onSelectedAnimation;
  Duration animationDuration = const Duration(milliseconds: 1300);
  @override
  void initState() {
    super.initState();
    idleAnimation = AnimationController(vsync: this);
    onSelectedAnimation =
        AnimationController(vsync: this, duration: animationDuration);
  }

  @override
  void dispose() {
    super.dispose();
    idleAnimation.dispose();
    onSelectedAnimation.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      child: BottomNavigationBar(
        elevation: 15,
        selectedItemColor: Colors.black87,
        currentIndex: widget.selected,
        onTap: (index) {
          onSelectedAnimation.reset();
          onSelectedAnimation.forward();
          widget.ontop(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Lottie.asset("img/search.json",
                height: 40,
                controller:
                    widget.selected == 0 ? onSelectedAnimation : idleAnimation),
            label: "بحث",
          ),
          BottomNavigationBarItem(
            icon: Lottie.asset("img/home-icon.json",
                height: 40,
                controller:
                    widget.selected == 1 ? onSelectedAnimation : idleAnimation),
            label: "الرئيسية",
          ),
          BottomNavigationBarItem(
            icon: Lottie.asset("img/heart.json",
                height: 40,
                controller:
                    widget.selected == 2 ? onSelectedAnimation : idleAnimation),
            label: "المفضلة",
          ),
          BottomNavigationBarItem(
            icon: Lottie.asset("img/userIcon.json",
                height: 30,
                controller:
                    widget.selected == 3 ? onSelectedAnimation : idleAnimation),
            label: "الملف الشخصي",
          ),
        ],
      ),
    );
  }
}
