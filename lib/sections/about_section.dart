import 'package:flutter/material.dart';

import '../data/content.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 900;

    final vision = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          studioVision,
          style: TextStyle(fontSize: 18, height: 1.7),
        ),
        const SizedBox(height: 28),
        for (final (title, text) in studioValues)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: SG.teal.withAlpha(40),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.nightlight_round,
                      size: 18, color: SG.teal),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 16)),
                      Text(text, style: const TextStyle(color: SG.textMuted)),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );

    final mascot = SGCard(
      color: SG.ghost,
      borderColor: SG.blush,
      child: Column(
        children: [
          Image.asset('assets/images/logo.png', height: 260),
          const SizedBox(height: 12),
          const Text(
            'Nuestra mascota',
            style: TextStyle(
              fontFamily: SG.mono,
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: SG.purpleDark,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Un fantasma con gorro de dormir que se abraza a su almohada: '
            'así nos sentimos tras una noche arreglando bugs.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF4A3A55), height: 1.5),
          ),
        ],
      ),
    );

    return SectionShell(
      alt: true,
      kicker: 'sobre nosotros',
      title: 'El estudio',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          mobile
              ? Column(children: [vision, const SizedBox(height: 24), mascot])
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 7, child: vision),
                    const SizedBox(width: 40),
                    Expanded(flex: 4, child: mascot),
                  ],
                ),
          const SizedBox(height: 56),
          Text('El equipo',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontSize: 26)),
          const SizedBox(height: 24),
          ResponsiveGrid(
            minItemWidth: 300,
            children: [for (final m in team) _MemberCard(member: m)],
          ),
        ],
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  final TeamMember member;
  const _MemberCard({required this.member});

  String get initials {
    final parts = member.name.split(' ').where((p) => p.isNotEmpty).toList();
    return parts.take(2).map((p) => p[0].toUpperCase()).join();
  }

  @override
  Widget build(BuildContext context) {
    return SGCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: member.color,
                  shape: BoxShape.circle,
                  border: Border.all(color: SG.ghost, width: 3),
                ),
                child: Text(
                  initials,
                  style: const TextStyle(
                    fontFamily: SG.mono,
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: SG.night,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(member.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 18)),
                    const SizedBox(height: 2),
                    Text(member.role,
                        style: TextStyle(
                            color: member.color, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(member.bio,
              style: const TextStyle(color: SG.textMuted, height: 1.6)),
        ],
      ),
    );
  }
}
