import 'package:flutter/material.dart';
import 'package:finmate/screens/home/screen_home.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      left: false,
      right: false,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: ValueListenableBuilder(
          valueListenable: ScreenHome.selectedIndexNotifier,
          builder: (context, value, child) {
            return PhysicalModel(
              color: Colors.transparent,
              elevation: 16,
              borderRadius: BorderRadius.circular(30),
              shadowColor: Colors.black.withOpacity(0.18),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Theme.of(context).colorScheme.primary,
                  unselectedItemColor: Colors.blueGrey,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  iconSize: 0, // No icons
                  selectedFontSize: 16,
                  unselectedFontSize: 15,
                  currentIndex: ScreenHome.selectedIndexNotifier.value,
                  onTap: (int index) {
                    ScreenHome.selectedIndexNotifier.value = index;
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: SizedBox.shrink(),
                      label: 'Transactions',
                    ),
                    BottomNavigationBarItem(
                      icon: SizedBox.shrink(),
                      label: 'Analytics',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavIcon({
    required IconData icon,
    required bool selected,
    required Color color,
  }) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.13) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(10),
        child: Icon(icon, color: selected ? color : Colors.blueGrey, size: 28),
      ),
    );
  }
}
