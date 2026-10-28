import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/content.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/web_embed.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 900;

    final right = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SocialCard(),
        const SizedBox(height: 20),
        SGCard(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 14),
                child: Row(
                  children: [
                    const Icon(Icons.place_rounded, color: SG.teal),
                    const SizedBox(width: 8),
                    Text('Dónde estamos',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontFamily: SG.mono, fontWeight: FontWeight.w700)),
                    const Spacer(),
                    const Flexible(
                      child: Text(studioAddress,
                          textAlign: TextAlign.right,
                          style: TextStyle(color: SG.textMuted, fontSize: 13)),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(21)),
                child: SizedBox(
                  height: 300,
                  child: WebEmbed(
                    url: 'https://www.google.com/maps?q='
                        '${Uri.encodeComponent(mapQuery)}&z=13&output=embed',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return SectionShell(
      alt: true,
      kicker: 'contacto y comunidad',
      title: '¿Hablamos?',
      subtitle:
          'Cuéntanos qué te parece el juego, apúntate a las pruebas o '
          'simplemente pasa a saludar.',
      child: mobile
          ? Column(children: [
              const _FeedbackForm(),
              const SizedBox(height: 20),
              right,
            ])
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: _FeedbackForm()),
                const SizedBox(width: 20),
                Expanded(child: right),
              ],
            ),
    );
  }
}

// ------------------------------------------------------------------ Redes
class _SocialCard extends StatelessWidget {
  const _SocialCard();

  @override
  Widget build(BuildContext context) {
    return SGCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Síguenos', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          const Text('Devlogs, capturas y avisos de nuevas demos.',
              style: TextStyle(color: SG.textMuted)),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [for (final s in socials) _SocialButton(s: s)],
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final SocialLink s;
  const _SocialButton({required this.s});

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.s.name,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => hover = true),
        onExit: (_) => setState(() => hover = false),
        child: GestureDetector(
          onTap: () => openUrl(context, widget.s.url),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 54,
            height: 54,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: hover ? SG.purple : SG.night,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: hover ? SG.blush : SG.surfaceHigh),
            ),
            child: widget.s.icon(22, hover ? SG.ghost : SG.blush),
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------------ Formulario
class _FeedbackForm extends StatefulWidget {
  const _FeedbackForm();

  @override
  State<_FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<_FeedbackForm> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _msg = TextEditingController();
  int _rating = 0;
  String _topic = 'Opinión sobre el juego';

  static const _topics = [
    'Opinión sobre el juego',
    'Quiero probar la demo',
    'Prensa / creadores de contenido',
    'Colaboración o trabajo',
  ];

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _msg.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (!(_form.currentState?.validate() ?? false)) return;
    final body = 'Nombre: ${_name.text}\n'
        'Email: ${_email.text}\n'
        'Valoración: ${_rating > 0 ? '$_rating/5' : 'sin valorar'}\n\n'
        '${_msg.text}';
    final uri = Uri.parse(
      'mailto:$contactEmail'
      '?subject=${Uri.encodeComponent('[Web] $_topic')}'
      '&body=${Uri.encodeComponent(body)}',
    );
    await launchUrl(uri);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('¡Gracias! Abriendo tu correo... 👻')),
    );
    _form.currentState?.reset();
    _name.clear();
    _email.clear();
    _msg.clear();
    setState(() => _rating = 0);
  }

  @override
  Widget build(BuildContext context) {
    return SGCard(
      child: Form(
        key: _form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Formulario de opinión',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Nombre'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Dinos tu nombre' : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (v) {
                final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                    .hasMatch(v?.trim() ?? '');
                return ok ? null : 'Introduce un email válido';
              },
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              value: _topic,
              dropdownColor: SG.surfaceHigh,
              borderRadius: BorderRadius.circular(14),
              decoration: const InputDecoration(labelText: 'Motivo'),
              items: [
                for (final t in _topics)
                  DropdownMenuItem(value: t, child: Text(t)),
              ],
              onChanged: (v) => setState(() => _topic = v ?? _topic),
            ),
            const SizedBox(height: 18),
            const Text('¿Qué te parece lo que has visto?',
                style: TextStyle(color: SG.textMuted)),
            const SizedBox(height: 6),
            Row(
              children: [
                for (var i = 1; i <= 5; i++)
                  IconButton(
                    tooltip: '$i/5',
                    onPressed: () => setState(() => _rating = i),
                    icon: Icon(
                      i <= _rating
                          ? Icons.nightlight_round
                          : Icons.nightlight_outlined,
                      color: i <= _rating ? SG.teal : SG.textMuted,
                      size: 30,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _msg,
              minLines: 4,
              maxLines: 7,
              decoration: const InputDecoration(
                labelText: 'Tu mensaje',
                alignLabelWithHint: true,
              ),
              validator: (v) => (v == null || v.trim().length < 5)
                  ? 'Escribe un poco más 🙂'
                  : null,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: PillButton(
                label: 'Enviar',
                icon: Icons.send_rounded,
                onPressed: _send,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
