import 'package:flutter/material.dart';

import '../data/content.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/web_embed.dart';

class GameSection extends StatelessWidget {
  const GameSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 900;

    final info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          gameDescription,
          style: TextStyle(fontSize: 17, height: 1.7, color: SG.ghost),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [for (final f in gameFacts) _FactChip(fact: f)],
        ),
        const SizedBox(height: 12),
        const Text(
          '* Plataforma objetivo, pendiente de acuerdo con distribuidora.',
          style: TextStyle(fontSize: 12, color: SG.textMuted),
        ),
      ],
    );

    final trailer = ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: SG.teal.withAlpha(120), width: 2),
          borderRadius: BorderRadius.circular(22),
          color: Colors.black,
        ),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: trailerYoutubeId.isEmpty
              ? const _TrailerPlaceholder()
              : const WebEmbed(
                  url: 'https://www.youtube-nocookie.com/embed/'
                      '$trailerYoutubeId?rel=0&modestbranding=1',
                ),
        ),
      ),
    );

    return SectionShell(
      kicker: 'el juego',
      title: 'Tráiler oficial',
      subtitle: 'Duerme, sueña... y aprovecha cada error del sistema.',
      child: mobile
          ? Column(children: [trailer, const SizedBox(height: 32), info])
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 7, child: trailer),
                const SizedBox(width: 40),
                Expanded(flex: 5, child: info),
              ],
            ),
    );
  }
}

class _FactChip extends StatelessWidget {
  final GameFact fact;
  const _FactChip({required this.fact});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: SG.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: SG.surfaceHigh),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            fact.label.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              letterSpacing: 1.2,
              color: SG.teal,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            fact.value,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class _TrailerPlaceholder extends StatelessWidget {
  const _TrailerPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/gallery/captura_03.jpg', fit: BoxFit.cover),
        Container(color: SG.night.withAlpha(170)),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: const BoxDecoration(
                color: SG.teal,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.play_arrow_rounded,
                  size: 48, color: SG.night),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tráiler próximamente',
              style: TextStyle(
                fontFamily: SG.mono,
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Añade el ID de YouTube en lib/data/content.dart',
              style: TextStyle(color: SG.textMuted, fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }
}
