# Sleepy Glitch · Web del estudio

Web (Flutter Web) del estudio indie **Sleepy Glitch** para la actividad de marketing
y comunicación digital del curso de Desarrollo de Videojuegos y RV.

## Secciones
| Requisito | Dónde está |
|---|---|
| Menú, diseño coherente, logo y favicon | `lib/widgets/nav_bar.dart`, `lib/theme/app_theme.dart`, `web/favicon.png` |
| Galería + tráiler de YouTube | `lib/sections/gallery_section.dart`, `lib/sections/game_section.dart` |
| GDD, presupuesto y gráficos | `lib/sections/docs_section.dart` |
| Sobre nosotros | `lib/sections/about_section.dart` |
| Redes, formulario y Google Maps | `lib/sections/contact_section.dart` |
| Calendario de eventos | `lib/sections/events_section.dart` |

## Editar el contenido
Todo el texto, enlaces, equipo, presupuesto y eventos está en **`lib/data/content.dart`**.
Busca los `TODO`:
- `trailerYoutubeId` → ID del vídeo de YouTube del tráiler.
- `gddUrl` → enlace al GDD.
- `gallery` → cambia las imágenes de `assets/gallery/` por capturas reales.
- `team`, `socials`, `contactEmail`.

## Ejecutar
```bash
flutter pub get
flutter run -d chrome
```

## Publicar
```bash
flutter build web --release
```
El resultado queda en `build/web/` (se puede subir a GitHub Pages, Firebase Hosting o Netlify).
Para GitHub Pages: `flutter build web --release --base-href /SleepyGlitch/`.
