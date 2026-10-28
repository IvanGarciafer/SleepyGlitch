import 'package:flutter/material.dart';

import '../data/content.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/nav_bar.dart';

class Footer extends StatelessWidget {
  final List<NavItem> items;
  final ValueChanged<int> onNavigate;
  const Footer({super.key, required this.items, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: SG.hatGradient,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: mobile ? 16 : 32, vertical: mobile ? 36 : 48),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kMaxWidth),
          child: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 24,
                runSpacing: 20,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/ghost_head.png', height: 52),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(studioName,
                              style: TextStyle(
                                  fontFamily: SG.mono,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20)),
                          Text('Hacemos juegos con sueño.',
                              style: TextStyle(color: SG.ghostDim)),
                        ],
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 4,
                    children: [
                      for (var i = 0; i < items.length; i++)
                        TextButton(
                          onPressed: () => onNavigate(i),
                          style: TextButton.styleFrom(
                              foregroundColor: SG.ghost),
                          child: Text(items[i].label),
                        ),
                    ],
                  ),
                  Wrap(
                    spacing: 4,
                    children: [
                      for (final s in socials)
                        IconButton(
                          tooltip: s.name,
                          onPressed: () => openUrl(context, s.url),
                          icon: s.icon(18, SG.ghost),
                        ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Divider(color: SG.ghost.withAlpha(50)),
              const SizedBox(height: 12),
              Text(
                '© 2026 $studioName · $contactEmail · '
                'Proyecto académico — Desarrollo de Videojuegos y RV',
                textAlign: TextAlign.center,
                style: TextStyle(color: SG.ghost.withAlpha(180), fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
