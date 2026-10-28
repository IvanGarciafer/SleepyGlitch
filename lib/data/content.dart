// =====================================================================
//  TODO EL CONTENIDO DE LA WEB ESTÁ AQUÍ.
//  Cambia textos, enlaces, equipo, presupuesto y eventos en este archivo
//  sin tocar el resto del código.
// =====================================================================

import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ---------------------------------------------------------------- Estudio
const studioName = 'Sleepy Glitch';
const studioTagline = 'Estudio indie · Jaén, Andalucía';
const studioPitch =
    'Estudio de videojuegos para público adolescente y adulto. Ponemos la '
    'narrativa en el centro y la llevamos a plataformas y acción, sin '
    'cerrarnos a explorar otros géneros cuando la historia lo pide.';
const contactEmail = 'contacto@sleepyglitch.es'; // TODO: pon el correo real

// ---------------------------------------------------------------- Juego
const gameTitle = studioName; // TODO: título del juego cuando lo tengas
const gameDescription =
    'Nuestro primer proyecto es un plataformas de acción con mucho peso '
    'narrativo: una historia madura, personajes con matices y decisiones '
    'que dejan huella. Combates ágiles, secciones de plataformas exigentes '
    'y un mundo que se "rompe" a propósito para contar su historia a '
    'través de los glitches.';

class GameFact {
  final String label;
  final String value;
  const GameFact(this.label, this.value);
}

const gameFacts = [
  GameFact('Género', 'Plataformas · Acción · Narrativo'),
  GameFact('Público', 'Adolescente y adulto'),
  GameFact('Motor', 'Unity 6'),
  GameFact('Plataformas', 'PC (Steam) · Consolas*'),
  GameFact('Jugadores', '1 jugador'),
  GameFact('PEGI', '16 (estimado)'),
];

/// ID del vídeo de YouTube del tráiler (lo que va después de `v=`).
/// Ejemplo: https://www.youtube.com/watch?v=ABC123 -> 'ABC123'
/// Mientras esté vacío se muestra un marcador "Tráiler próximamente".
const trailerYoutubeId = ''; // TODO

// ---------------------------------------------------------------- Galería
class GalleryImage {
  final String asset;
  final String caption;
  const GalleryImage(this.asset, this.caption);
}

// TODO: sustituye estas imágenes por capturas reales en assets/gallery/
const gallery = [
  GalleryImage('assets/gallery/captura_01.jpg', 'Bosque dormido'),
  GalleryImage('assets/gallery/captura_02.jpg', 'Torre del reloj'),
  GalleryImage('assets/gallery/captura_03.jpg', 'Ciudad de los sueños'),
  GalleryImage('assets/gallery/captura_04.jpg', 'Cueva de bugs'),
  GalleryImage('assets/gallery/captura_05.jpg', 'El gran pijama'),
  GalleryImage('assets/gallery/captura_06.jpg', 'Jefe final: Insomnio'),
];

// ---------------------------------------------------------------- Documentación
/// Enlace al GDD (Google Docs, PDF en Drive, Notion...).
const gddUrl = ''; // TODO

// ---------------------------------------------------------------- Equipo
const studioVision =
    'En Sleepy Glitch creemos que los videojuegos son una de las mejores '
    'formas de contar historias. Hacemos juegos para adolescentes y adultos '
    'donde la narrativa no es un adorno: guía el diseño, el ritmo y cada '
    'mecánica. Nuestro terreno natural son las plataformas y la acción, '
    'pero si una historia pide otro género, la seguimos.';

const studioValues = [
  ('La historia manda',
      'Diseñamos mecánicas al servicio de la narrativa, no al revés.'),
  ('Acción que se siente',
      'Controles precisos y combates con peso, pensados para jugadores exigentes.'),
  ('Sin miedo a cambiar de género',
      'Plataformas y acción son nuestra base, no nuestro límite.'),
];

class TeamMember {
  final String name;
  final String role;
  final String bio;
  final Color color;
  const TeamMember(this.name, this.role, this.bio, this.color);
}

const team = [
  TeamMember(
    'Iván García',
    'Fundador · Dirección, programación y diseño',
    'Técnico Superior y desarrollador con experiencia en Flutter y Firebase. '
        'Cursa la especialización en Desarrollo de Videojuegos y Realidad '
        'Virtual. Diseñó la mascota del estudio y dirige su primer proyecto.',
    Color(0xFF9D4EA0),
  ),
];

// ---------------------------------------------------------------- Eventos
enum EventStatus { confirmado, solicitado, previsto }

class StudioEvent {
  final String day; // '23-25' o '—'
  final String month; // 'ENE'
  final String year;
  final String name;
  final String place;
  final String why;
  final EventStatus status;
  final String url;
  const StudioEvent({
    required this.day,
    required this.month,
    required this.year,
    required this.name,
    required this.place,
    required this.why,
    required this.status,
    required this.url,
  });
}

const events = [
  StudioEvent(
    day: '23-25',
    month: 'ENE',
    year: '2027',
    name: 'Global Game Jam 2027',
    place: 'Sede local · Jaén / online',
    why: 'Probar mecánicas nuevas de glitch en 48 horas.',
    status: EventStatus.previsto,
    url: 'https://globalgamejam.org',
  ),
  StudioEvent(
    day: '22',
    month: 'FEB',
    year: '2027',
    name: 'Steam Next Fest (febrero)',
    place: 'Online · 22 feb – 1 mar',
    why: 'Primera prueba de la página de Steam y listas de deseados.',
    status: EventStatus.previsto,
    url: 'https://store.steampowered.com',
  ),
  StudioEvent(
    day: '14-21',
    month: 'JUN',
    year: '2027',
    name: 'Steam Next Fest (junio)',
    place: 'Online',
    why: 'Lanzamiento de la demo pública de $gameTitle.',
    status: EventStatus.solicitado,
    url: 'https://store.steampowered.com',
  ),
  StudioEvent(
    day: '—',
    month: 'AGO',
    year: '2027',
    name: 'gamescom',
    place: 'Colonia, Alemania · fecha por confirmar',
    why: 'Reuniones con distribuidoras (publishers) en el área de negocio.',
    status: EventStatus.previsto,
    url: 'https://www.gamescom.global',
  ),
  StudioEvent(
    day: '—',
    month: 'OTO',
    year: '2027',
    name: 'SAGA Barcelona Game Fest',
    place: 'Barcelona · fecha por anunciar',
    why: 'Nuevo festival que une Indie Dev Day, SAGA y RetroBarcelona.',
    status: EventStatus.previsto,
    url: 'https://www.indiedevday.es',
  ),
];

// ---------------------------------------------------------------- Contacto
class SocialLink {
  final String name;
  final String url;

  /// Dibuja el icono de la red con el tamaño y color indicados.
  final Widget Function(double size, Color color) icon;
  const SocialLink(this.name, this.url, this.icon);
}

Widget Function(double, Color) _fa(dynamic data) =>
    (size, color) => FaIcon(data, size: size, color: color);

// TODO: cambia por los perfiles reales del estudio.
final socials = [
  SocialLink('Instagram', 'https://instagram.com/sleepyglitch',
      _fa(FontAwesomeIcons.instagram)),
  SocialLink('X', 'https://x.com/sleepyglitch', _fa(FontAwesomeIcons.xTwitter)),
  SocialLink('YouTube', 'https://youtube.com/@sleepyglitch',
      _fa(FontAwesomeIcons.youtube)),
  SocialLink('Discord', 'https://discord.gg/', _fa(FontAwesomeIcons.discord)),
  SocialLink('itch.io', 'https://itch.io', _fa(FontAwesomeIcons.itchIo)),
  SocialLink('GitHub', 'https://github.com/IvanGarciafer/SleepyGlitch',
      _fa(FontAwesomeIcons.github)),
];

/// Lugar que se muestra en el mapa de Google Maps.
const mapQuery = 'Jaén, España';
const studioAddress = 'Jaén, Andalucía (España)';
