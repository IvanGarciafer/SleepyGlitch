import 'package:flutter/material.dart';

import '../data/content.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class DocsSection extends StatelessWidget {
  const DocsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionShell(
      kicker: 'documentación técnica',
      title: 'Así se está haciendo',
      subtitle: 'Todo el diseño del juego, recogido en nuestro Game Design '
          'Document.',
      child: _GddCard(),
    );
  }
}

class _GddCard extends StatelessWidget {
  const _GddCard();

  static const _chapters = [
    'Visión y pilares de diseño',
    'Historia, mundo y personajes',
    'Mecánicas de plataformas y combate',
    'Diseño de niveles',
    'Arte, audio y UI',
    'Público objetivo y monetización',
  ];

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 900;

    final intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: SG.ghost,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Icon(Icons.description_rounded,
              color: SG.purpleDark, size: 36),
        ),
        const SizedBox(height: 20),
        Text('Game Design Document',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontSize: 28)),
        const SizedBox(height: 12),
        const Text(
          'Narrativa, mecánicas, niveles, estilo artístico, público objetivo '
          'y plan de producción de $gameTitle, en un único documento.',
          style: TextStyle(height: 1.6, fontSize: 16, color: SG.ghost),
        ),
        const SizedBox(height: 24),
        PillButton(
          label: 'Abrir el GDD',
          icon: Icons.open_in_new_rounded,
          onPressed: () => openUrl(context, gddUrl),
        ),
      ],
    );

    final chapters = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CONTENIDO',
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w800,
            color: SG.teal,
          ),
        ),
        const SizedBox(height: 12),
        for (var i = 0; i < _chapters.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Text(
                  '${(i + 1).toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    fontFamily: SG.mono,
                    fontWeight: FontWeight.w700,
                    color: SG.blush,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(_chapters[i],
                      style: const TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
      ],
    );

    return SGCard(
      color: SG.purpleDark,
      borderColor: SG.purple,
      padding: EdgeInsets.all(mobile ? 24 : 40),
      child: mobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [intro, const SizedBox(height: 32), chapters],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 6, child: intro),
                const SizedBox(width: 48),
                Expanded(flex: 5, child: chapters),
              ],
            ),
    );
  }
}
