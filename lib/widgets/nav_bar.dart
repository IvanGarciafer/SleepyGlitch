import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'common.dart';

class NavItem {
  final String label;
  final GlobalKey key;
  const NavItem(this.label, this.key);
}

class SGNavBar extends StatelessWidget implements PreferredSizeWidget {
  final List<NavItem> items;
  final int active;
  final ValueChanged<int> onTap;
  final bool scrolled;

  const SGNavBar({
    super.key,
    required this.items,
    required this.active,
    required this.onTap,
    required this.scrolled,
  });

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 980;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 72,
      decoration: BoxDecoration(
        color: scrolled ? SG.night.withAlpha(240) : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: scrolled ? SG.surfaceHigh : Colors.transparent,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: mobile ? 12 : 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kMaxWidth + 64),
          child: Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => onTap(0),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    children: [
                      Image.asset('assets/images/ghost_head.png', height: 40),
                      const SizedBox(width: 10),
                      const Text(
                        'Sleepy Glitch',
                        style: TextStyle(
                          fontFamily: SG.mono,
                          fontWeight: FontWeight.w700,
                          fontSize: 19,
                          color: SG.ghost,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              if (mobile)
                Builder(
                  builder: (ctx) => IconButton(
                    tooltip: 'Menú',
                    icon: const Icon(Icons.menu_rounded, size: 30),
                    onPressed: () => Scaffold.of(ctx).openEndDrawer(),
                  ),
                )
              else
                for (var i = 1; i < items.length; i++)
                  _NavLink(
                    label: items[i].label,
                    selected: i == active,
                    onTap: () => onTap(i),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _NavLink({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final on = hover || widget.selected;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: on ? SG.ghost : SG.textMuted,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 3,
                width: widget.selected ? 22 : (hover ? 12 : 0),
                decoration: BoxDecoration(
                  color: SG.teal,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SGDrawer extends StatelessWidget {
  final List<NavItem> items;
  final int active;
  final ValueChanged<int> onTap;
  const SGDrawer({
    super.key,
    required this.items,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: SG.nightAlt,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Image.asset('assets/images/logo.png', height: 160),
            ),
            for (var i = 0; i < items.length; i++)
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                selected: i == active,
                selectedTileColor: SG.surface,
                selectedColor: SG.teal,
                title: Text(
                  items[i].label,
                  style: const TextStyle(
                    fontFamily: SG.mono,
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  onTap(i);
                },
              ),
          ],
        ),
      ),
    );
  }
}
