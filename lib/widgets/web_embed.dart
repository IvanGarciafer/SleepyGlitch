import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

/// Inserta un <iframe> (YouTube, Google Maps...) dentro de la web de Flutter.
class WebEmbed extends StatelessWidget {
  final String url;
  const WebEmbed({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return HtmlElementView.fromTagName(
      key: ValueKey(url),
      tagName: 'iframe',
      onElementCreated: (Object element) {
        final iframe = element as web.HTMLIFrameElement;
        iframe.src = url;
        iframe.allow =
            'accelerometer; autoplay; clipboard-write; encrypted-media; '
            'gyroscope; picture-in-picture; web-share';
        iframe.allowFullscreen = true;
        iframe.referrerPolicy = 'strict-origin-when-cross-origin';
        iframe.style
          ..border = 'none'
          ..width = '100%'
          ..height = '100%';
      },
    );
  }
}
