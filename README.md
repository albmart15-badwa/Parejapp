# Parejapp ♡

Una web app privada, instalable desde móvil, para dos personas. Diseño negro, morado y rosa.

## Incluye

Contador de días juntos, nombres y fecha, mensajes, calendario, tareas, ahorros, lista de deseos, recuerdos (mediante URL de imagen), cápsulas del tiempo, preguntas, juegos, retos, dibujo compartido y mascota virtual.

## Publicar en GitHub Pages + Supabase

1. Crea una cuenta/proyecto gratuito en **supabase.com**.
2. En **Authentication > Providers > Email**, desactiva el registro público ("Allow new users to sign up" / opción equivalente). En **Authentication > Users**, crea o invita MANUALMENTE solo las dos cuentas. Usa dos emails reales y verifica las direcciones. Configura contraseñas seguras. También puedes crear cuentas con email confirmado desde el panel autorizado de Supabase. No actives registro desde la app.
3. En **SQL Editor**, abre `supabase.sql`, sustituye los DOS correos de ejemplo por los dos correos autorizados y ejecútalo. Comprueba que las políticas RLS queden activadas y que no existan otras políticas permisivas en esas tablas.
4. En **Project Settings > API** copia **Project URL** y la clave **anon/publicable (publishable)** a `config.js`. **NUNCA** uses la clave `service_role` o `secret` en el repositorio.
5. Crea un repositorio en GitHub. Si quieres ocultar el código, márcalo **privado**. Sube todos los archivos de esta carpeta a la raíz del repositorio.
6. Para publicar, la opción más sencilla es un repositorio público con **Settings > Pages > Deploy from a branch > main > /(root)**. Si prefieres **código privado**, consulta las condiciones de GitHub Pages según tu plan o despliega el repositorio privado en Vercel/Netlify. La **URL pública no es privada**, pero Supabase Auth + RLS protege los datos y bloquea usuarios no autorizados.
7. Abre la URL desde cada móvil, inicia sesión y usa la opción del navegador **Añadir a pantalla de inicio** para instalar la PWA.

## Notas de seguridad

- No subas nunca contraseñas al repositorio; no las guardes en `config.js`.
- Solo la clave pública es apta para el navegador; la seguridad real depende de **RLS** y de los dos correos autorizados.
- No hay botón de registro ni recuperación de contraseña en la app. Un administrador realiza el alta o cambios de acceso desde Supabase.
- El contenido está compartido como un único documento JSON. Cambios simultáneos exactos podrían sobrescribirse; es una primera versión privada. Las fotos se añaden por enlace en lugar de subir archivos privados; evita URLs de fotografías sensibles o públicas si deseas mayor privacidad.
- El dibujo se sincroniza al pulsar **Guardar dibujo**, no trazo por trazo.
- Las cartas futuras están ocultas en la interfaz antes de la fecha, **no cifradas contra el otro usuario autorizado**. No son adecuadas para secretos que deban permanecer inaccesibles hasta entonces.
- Antes de usar datos importantes, configura backups en Supabase o exporta una copia desde el panel.

## Vista previa local

En la carpeta ejecuta `python -m http.server 8080` y abre `http://localhost:8080`. No requiere npm ni compilación. Hasta configurar Supabase aparecerá la pantalla de configuración segura (no una demo abierta).
