import 'dart:math';

import 'package:flutter/material.dart';

import '../data/content.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onTrailer;
  final VoidCallback onDocs;
  const HeroSection({super.key, required this.onTrailer, required this.onDocs});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final mobile = size.width < 900;

    final text = Column(
      crossAxisAlignment:
          mobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: SG.teal.withAlpha(30),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: SG.teal.withAlpha(120)),
          ),
          child: const Text(
            studioTagline,
            style: TextStyle(
              color: SG.teal,
              fontWeight: FontWeight.w700,
              letterSpacing: .5,
            ),
          ),
        ),
        const SizedBox(height: 22),
        Text(
          'Estudio de videojuegos',
          style: TextStyle(
            fontFamily: SG.mono,
            color: SG.blush,
            fontSize: mobile ? 18 : 22,
          ),
        ),
        GlitchText(
          studioName,
          textAlign: mobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontFamily: SG.mono,
            fontWeight: FontWeight.w700,
            fontSize: mobile ? 46 : 76,
            height: 1.05,
            color: SG.ghost,
          ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            studioPitch,
            textAlign: mobile ? TextAlign.center : TextAlign.start,
            style: const TextStyle(fontSize: 18, height: 1.6, color: SG.textMuted),
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          alignment: mobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            PillButton(
              label: 'Ver tráiler',
              icon: Icons.play_arrow_rounded,
              onPressed: onTrailer,
            ),
            PillButton(
              label: 'Leer el GDD',
              icon: Icons.menu_book_rounded,
              filled: false,
              onPressed: onDocs,
            ),
          ],
        ),
      ],
    );

    final logo = _FloatingLogo(size: mobile ? 300 : 440);

    return SizedBox(
      width: double.infinity,
      child: ClipPath(
        clipper: _GhostTailClipper(),
        child: Container(
          constraints: BoxConstraints(minHeight: max(680.0, size.height * .92)),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF120A1E), Color(0xFF2A1440), Color(0xFF3D1B48)],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(child: CustomPaint(painter: StarsPainter(count: 160))),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    mobile ? 16 : 32, 110, mobile ? 16 : 32, mobile ? 90 : 110),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: kMaxWidth),
                    child: mobile
                        ? Column(children: [logo, const SizedBox(height: 24), text])
                        : Row(
                            children: [
                              Expanded(flex: 6, child: text),
                              Expanded(flex: 5, child: Center(child: logo)),
                            ],
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

/// El logo flota suavemente delante de una luna, como si estuviera soñando.
class _FloatingLogo extends StatefulWidget {
  final double size;
  const _FloatingLogo({required this.size});

  @override
  State<_FloatingLogo> createState() => _FloatingLogoState();
}

class _FloatingLogoState extends State<_FloatingLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.size;
    return SizedBox(
      width: s,
      height: s * 1.08,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Halo + luna
          Container(
            width: s,
            height: s,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                colors: [SG.ghost, Color(0xFFE6DCEF), Color(0xFFD7C6E6)],
                stops: [0, .7, 1],
              ),
              boxShadow: [
                BoxShadow(
                  color: SG.blush.withAlpha(90),
                  blurRadius: 80,
                  spreadRadius: 10,
                ),
              ],
            ),
          ),
          // "Zzz" flotantes
          AnimatedBuilder(
            animation: _c,
            builder: (_, __) => Positioned(
              top: s * .02 - _c.value * 10,
              right: s * .02,
              child: Opacity(
                opacity: .55 + _c.value * .45,
                child: Text(
                  'z Z',
                  style: TextStyle(
                    fontFamily: SG.mono,
                    fontWeight: FontWeight.w700,
                    fontSize: s * .09,
                    color: SG.teal,
                  ),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _c,
            builder: (_, child) {
              final t = Curves.easeInOut.transform(_c.value);
              return Transform.translate(
                offset: Offset(0, -12 + t * 24),
                child: Transform.rotate(angle: (t - .5) * .04, child: child),
              );
            },
            child: Image.asset(
              'assets/images/logo.png',
              height: s * .9,
              semanticLabel: 'Logo de Sleepy Glitch',
            ),
          ),
        ],
      ),
    );
  }
}

/// Borde inferior ondulado, igual que la "cola" del fantasma del logo.
class _GhostTailClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const amp = 18.0;
    final p = Path()..lineTo(0, size.height - amp * 2);
    final waves = max(3, (size.width / 260).round());
    final w = size.width / waves;
    for (var i = 0; i < waves; i++) {
      final x0 = i * w;
      p.quadraticBezierTo(
          x0 + w * .25, size.height, x0 + w * .5, size.height - amp);
      p.quadraticBezierTo(
          x0 + w * .75, size.height - amp * 3, x0 + w, size.height - amp * 2);
    }
    p
      ..lineTo(size.width, 0)
      ..close();
    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
