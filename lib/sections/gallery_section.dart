import 'package:flutter/material.dart';

import '../data/content.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      alt: true,
      kicker: 'galería',
      title: 'Capturas del juego',
      subtitle: 'Haz clic en cualquier imagen para verla a pantalla completa.',
      child: ResponsiveGrid(
        minItemWidth: 320,
        children: [
          for (var i = 0; i < gallery.length; i++)
            _Thumb(index: i, onTap: () => _openViewer(context, i)),
        ],
      ),
    );
  }

  void _openViewer(BuildContext context, int start) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withAlpha(220),
      builder: (_) => _Viewer(start: start),
    );
  }
}

class _Thumb extends StatefulWidget {
  final int index;
  final VoidCallback onTap;
  const _Thumb({required this.index, required this.onTap});

  @override
  State<_Thumb> createState() => _ThumbState();
}

class _ThumbState extends State<_Thumb> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final img = gallery[widget.index];
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: hover ? 1.02 : 1,
          duration: const Duration(milliseconds: 200),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: hover ? SG.teal : SG.surfaceHigh,
                width: 2,
              ),
              boxShadow: [
                if (hover)
                  BoxShadow(color: SG.teal.withAlpha(60), blurRadius: 24),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(img.asset, fit: BoxFit.cover),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(16, 30, 16, 12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, SG.night.withAlpha(230)],
                          ),
                        ),
                        child: Text(
                          img.caption,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Viewer extends StatefulWidget {
  final int start;
  const _Viewer({required this.start});

  @override
  State<_Viewer> createState() => _ViewerState();
}

class _ViewerState extends State<_Viewer> {
  late int i = widget.start;

  void _move(int d) =>
      setState(() => i = (i + d + gallery.length) % gallery.length);

  @override
  Widget build(BuildContext context) {
    final img = gallery[i];
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(img.asset, fit: BoxFit.contain),
              ),
              const SizedBox(height: 12),
              Text(
                '${img.caption}  ·  ${i + 1}/${gallery.length}',
                style: const TextStyle(fontFamily: SG.mono),
              ),
            ],
          ),
          Positioned(left: 4, child: _arrow(Icons.chevron_left_rounded, -1)),
          Positioned(right: 4, child: _arrow(Icons.chevron_right_rounded, 1)),
          Positioned(
            top: 4,
            right: 4,
            child: IconButton.filled(
              style: IconButton.styleFrom(backgroundColor: SG.night),
              tooltip: 'Cerrar',
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close_rounded),
            ),
          ),
        ],
      ),
    );
  }

  Widget _arrow(IconData icon, int d) => IconButton.filled(
        style: IconButton.styleFrom(
          backgroundColor: SG.night.withAlpha(200),
          foregroundColor: SG.ghost,
        ),
        iconSize: 32,
        onPressed: () => _move(d),
        icon: Icon(icon),
      );
}
