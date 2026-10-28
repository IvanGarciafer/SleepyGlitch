import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_theme.dart';

const kMaxWidth = 1120.0;

bool isMobile(BuildContext context) => MediaQuery.sizeOf(context).width < 820;

Future<void> openUrl(BuildContext context, String url) async {
  if (url.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Enlace pendiente de añadir 👻')),
    );
    return;
  }
  await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
}

/// Contenedor común de cada sección: ancho máximo, padding y cabecera.
class SectionShell extends StatelessWidget {
  final String kicker;
  final String title;
  final String? subtitle;
  final Widget child;
  final bool alt;

  const SectionShell({
    super.key,
    required this.kicker,
    required this.title,
    this.subtitle,
    required this.child,
    this.alt = false,
  });

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    return Container(
      width: double.infinity,
      color: alt ? SG.nightAlt : SG.night,
      padding: EdgeInsets.symmetric(
        horizontal: mobile ? 16 : 32,
        vertical: mobile ? 56 : 96,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kMaxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '// $kicker',
                style: const TextStyle(
                  fontFamily: SG.mono,
                  color: SG.teal,
                  fontSize: 14,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              GlitchText(
                title,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: mobile ? 30 : 42,
                      height: 1.1,
                    ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 14),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 680),
                  child: Text(
                    subtitle!,
                    style: const TextStyle(
                      color: SG.textMuted,
                      fontSize: 17,
                      height: 1.55,
                    ),
                  ),
                ),
              ],
              SizedBox(height: mobile ? 32 : 48),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

/// Texto con un ligero desplazamiento RGB, guiño al "glitch" del nombre.
class GlitchText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  const GlitchText(this.text, {super.key, required this.style, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: style.copyWith(
        shadows: [
          Shadow(color: SG.teal.withAlpha(170), offset: const Offset(-2, 0)),
          Shadow(color: SG.purple.withAlpha(200), offset: const Offset(2, 1)),
        ],
      ),
    );
  }
}

/// Tarjeta base con bordes redondeados (como las formas del logo).
class SGCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final Color? borderColor;
  const SGCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.color,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? SG.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: borderColor ?? SG.surfaceHigh, width: 1.5),
      ),
      child: child,
    );
  }
}

class PillButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool filled;
  const PillButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.filled = true,
  });

  @override
  Widget build(BuildContext context) {
    final style = ButtonStyle(
      padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 24, vertical: 18)),
      shape: const WidgetStatePropertyAll(StadiumBorder()),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(fontFamily: SG.mono, fontWeight: FontWeight.w700, fontSize: 15),
      ),
      backgroundColor: WidgetStatePropertyAll(filled ? SG.teal : Colors.transparent),
      foregroundColor: WidgetStatePropertyAll(filled ? SG.night : SG.ghost),
      side: WidgetStatePropertyAll(
        BorderSide(color: filled ? SG.teal : SG.ghost.withAlpha(120), width: 1.5),
      ),
      overlayColor: WidgetStatePropertyAll(SG.ghost.withAlpha(30)),
    );
    return icon == null
        ? TextButton(onPressed: onPressed, style: style, child: Text(label))
        : TextButton.icon(
            onPressed: onPressed,
            style: style,
            icon: Icon(icon, size: 18),
            label: Text(label),
          );
  }
}

/// Cielo estrellado de fondo (posiciones fijas, generadas con semilla).
class StarsPainter extends CustomPainter {
  final int count;
  final int seed;
  StarsPainter({this.count = 120, this.seed = 7});

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = Random(seed);
    final paint = Paint();
    for (var i = 0; i < count; i++) {
      final dx = rnd.nextDouble() * size.width;
      final dy = rnd.nextDouble() * size.height;
      final r = rnd.nextDouble() * 1.6 + .4;
      paint.color = SG.ghost.withAlpha(60 + rnd.nextInt(160));
      canvas.drawCircle(Offset(dx, dy), r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant StarsPainter old) => false;
}

/// Reparte hijos en columnas según el ancho disponible.
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double minItemWidth;
  final double spacing;
  const ResponsiveGrid({
    super.key,
    required this.children,
    this.minItemWidth = 300,
    this.spacing = 20,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final cols = max(1, (c.maxWidth + spacing) ~/ (minItemWidth + spacing));
      final w = (c.maxWidth - spacing * (cols - 1)) / cols;
      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: [for (final ch in children) SizedBox(width: w, child: ch)],
      );
    });
  }
}
