import 'package:flutter/material.dart';

import '../data/content.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class EventsSection extends StatelessWidget {
  const EventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      kicker: 'planificación',
      title: 'Calendario de eventos',
      subtitle:
          'Festivales, ferias y jams donde queremos enseñar $gameTitle '
          'y conocer a la comunidad.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Wrap(
            spacing: 18,
            runSpacing: 8,
            children: [
              _StatusChip(status: EventStatus.confirmado),
              _StatusChip(status: EventStatus.solicitado),
              _StatusChip(status: EventStatus.previsto),
            ],
          ),
          const SizedBox(height: 24),
          for (var i = 0; i < events.length; i++)
            _EventTile(e: events[i], last: i == events.length - 1),
        ],
      ),
    );
  }
}

Color statusColor(EventStatus s) => switch (s) {
      EventStatus.confirmado => const Color(0xFF8FD694),
      EventStatus.solicitado => SG.teal,
      EventStatus.previsto => SG.blush,
    };

String statusLabel(EventStatus s) => switch (s) {
      EventStatus.confirmado => 'Confirmado',
      EventStatus.solicitado => 'Solicitado',
      EventStatus.previsto => 'Previsto',
    };

class _StatusChip extends StatelessWidget {
  final EventStatus status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final c = statusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: c.withAlpha(35),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: c.withAlpha(140)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: c, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(statusLabel(status),
              style: TextStyle(
                  color: c, fontWeight: FontWeight.w700, fontSize: 12)),
        ],
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  final StudioEvent e;
  final bool last;
  const _EventTile({required this.e, required this.last});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final c = statusColor(e.status);

    final dateBlock = Container(
      width: mobile ? 78 : 104,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        gradient: SG.hatGradient,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(e.month,
              style: const TextStyle(
                  fontFamily: SG.mono,
                  fontWeight: FontWeight.w700,
                  color: SG.teal,
                  letterSpacing: 2)),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(e.day,
                  style: TextStyle(
                      fontFamily: SG.mono,
                      fontWeight: FontWeight.w700,
                      fontSize: mobile ? 22 : 28)),
            ),
          ),
          Text(e.year,
              style: const TextStyle(fontSize: 12, color: SG.ghostDim)),
        ],
      ),
    );

    return Padding(
      padding: EdgeInsets.only(bottom: last ? 0 : 16),
      child: SGCard(
        padding: EdgeInsets.all(mobile ? 14 : 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dateBlock,
            SizedBox(width: mobile ? 14 : 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 10,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(e.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 19)),
                      _StatusChip(status: e.status),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.place_rounded, size: 16, color: c),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(e.place,
                            style: const TextStyle(color: SG.textMuted)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(e.why, style: const TextStyle(height: 1.5)),
                ],
              ),
            ),
            if (!mobile)
              IconButton(
                tooltip: 'Web del evento',
                onPressed: () => openUrl(context, e.url),
                icon: const Icon(Icons.open_in_new_rounded, color: SG.teal),
              ),
          ],
        ),
      ),
    );
  }
}
