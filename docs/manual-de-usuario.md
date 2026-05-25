# Manual de Usuario — AcademixOS

Manual de uso de AcademixOS, una distribución de Linux basada en NixOS orientada a entornos académicos. Está dirigido a usuarios sin experiencia previa en Linux.

---

## Índice

1. [Qué es AcademixOS](#1-qué-es-academixos)
2. [Primer arranque e inicio de sesión](#2-primer-arranque-e-inicio-de-sesión)
3. [El escritorio (KDE Plasma)](#3-el-escritorio-kde-plasma)
4. [La terminal](#4-la-terminal)
5. [Herramientas incluidas](#5-herramientas-incluidas)
6. [Instalar y quitar programas](#6-instalar-y-quitar-programas)
7. [Actualizar el sistema](#7-actualizar-el-sistema)
8. [Opciones y gestión de usuarios](#8-opciones-y-gestión-de-usuarios)
9. [Tareas comunes](#9-tareas-comunes)
10. [Solución de problemas](#10-solución-de-problemas)
11. [Glosario](#11-glosario)

---

## 1. Qué es AcademixOS

AcademixOS es un sistema operativo libre basado en Linux, construido sobre NixOS. Su característica principal es que todo el sistema se configura desde archivos de texto. Esto permite reproducir la configuración en otros equipos y revertir cambios a un estado anterior si una modificación falla.

Características:

- Escritorio KDE Plasma 6.
- Herramientas de programación preinstaladas: Python, Java, C++, bases de datos y más.
- Programas de oficina y diseño: LibreOffice, GIMP, Inkscape, navegador web.
- Actualizaciones reversibles: si una actualización falla, se puede volver a la versión anterior.

---

## 2. Primer arranque e inicio de sesión

Al encender el equipo aparece la pantalla de inicio de sesión (SDDM), donde se elige el usuario y se escribe la contraseña.

### Versión Live (desde USB, sin instalar)

- Usuario: `liveuser`
- Contraseña: `liveuser`

El modo Live permite probar el sistema sin modificar el equipo. Para una instalación permanente, ejecuta el instalador (Calamares) disponible en el escritorio y sigue los pasos; durante el proceso se crea el usuario y la contraseña definitivos.

### Sistema ya instalado

Usa el usuario y la contraseña creados durante la instalación.

---

## 3. El escritorio (KDE Plasma)

La disposición es similar a la de Windows:

| Elemento | Ubicación | Función |
|----------|-----------|---------|
| Menú de aplicaciones | Esquina inferior izquierda | Buscar y abrir programas. |
| Barra de tareas | Parte inferior | Ventanas abiertas. |
| Bandeja del sistema | Inferior derecha | Sonido, red, batería, reloj. |

Programas básicos incluidos:

- Dolphin: explorador de archivos.
- Konsole: terminal (ver sección 4).
- Kate: editor de texto.
- Okular: lector de PDF.
- Gwenview: visor de imágenes.
- Ark: gestor de archivos comprimidos (.zip, .tar, etc.).
- KCalc: calculadora.
- KFind: búsqueda de archivos.

Para abrir un programa, pulsa la tecla Super (⊞) o abre el menú de aplicaciones y escribe el nombre.

---

## 4. La terminal

Muchas tareas en Linux se realizan mediante comandos en la terminal. En AcademixOS la terminal es Konsole (menú de aplicaciones → "Konsole").

Comandos básicos:

```bash
ls            # Listar archivos de la carpeta actual
cd Documentos # Entrar a la carpeta "Documentos"
cd ..         # Subir a la carpeta anterior
pwd           # Mostrar la carpeta actual
mkdir tareas  # Crear una carpeta llamada "tareas"
clear         # Limpiar la pantalla
```

Los comandos que modifican el sistema requieren permisos de administrador. En esos casos se escriben con `sudo` al inicio y se solicita la contraseña.

Para ver información del sistema y del equipo:

```bash
fastfetch
```

---

## 5. Herramientas incluidas

AcademixOS incluye preinstaladas las siguientes herramientas.

### Python
- Python 3.14, `pip`, `virtualenv`, Poetry, `pytest`
- Ciencia de datos: NumPy, Pandas, SciPy, Matplotlib
- Frameworks web: Django y Flask
- `pypy3`

### Java
- JDK 21 y JDK 17
- Maven y Gradle

### C / C++
- Compiladores GCC y Clang
- CMake, Ninja, `pkg-config`
- Depuradores GDB y LLDB, analizador Valgrind
- Librerías: Boost, GLFW, GLM

### Bases de datos
- PostgreSQL (15) y SQLite

El servicio de PostgreSQL está desactivado por defecto. Para usarlo como servidor debe activarse (ver sección 9).

### Contenedores
- Docker y Docker Compose
- Podman y Podman Compose

Los servicios de Docker y Podman están desactivados por defecto en la imagen.

### Editores de código
- Visual Studio Code
- Cursor
- Vim, Neovim y Nano

### Oficina, diseño y navegación
- LibreOffice: documentos, hojas de cálculo y presentaciones.
- LibreWolf: navegador web orientado a la privacidad.
- GIMP: edición de imágenes.
- Inkscape: diseño vectorial.
- Blender: modelado y animación 3D.

### Utilidades del sistema
- `git`, `curl`, `wget`, `htop`, `fastfetch`
- GParted y Utilidad de Discos de GNOME: administración de discos y particiones.

---

## 6. Instalar y quitar programas

La gestión de programas en NixOS difiere de otros sistemas. Hay dos formas.

### Instalación temporal

Para usar un programa de forma puntual sin instalarlo de forma permanente:

```bash
nix-shell -p nombre-del-programa
```

Ejemplo:

```bash
nix-shell -p cmus
```

Al cerrar esa terminal, el programa deja de estar disponible.

### Instalación permanente

Los programas permanentes se declaran en el archivo de configuración del sistema:

```
/etc/nixos/configuration.nix
```

1. Abre el archivo con permisos de administrador:
   ```bash
   sudo nano /etc/nixos/configuration.nix
   ```
2. En la sección `environment.systemPackages`, agrega los programas:
   ```nix
   environment.systemPackages = with pkgs; [
     firefox
     vlc
   ];
   ```
3. Guarda (en `nano`: `Ctrl + O`, Enter, `Ctrl + X`) y aplica los cambios:
   ```bash
   sudo nixos-rebuild switch
   ```

Para conocer el nombre exacto de un paquete, consulta el catálogo oficial: https://search.nixos.org/packages

### Quitar un programa permanente

Elimina su línea de `configuration.nix` y ejecuta de nuevo `sudo nixos-rebuild switch`.

Este método mantiene todo el sistema descrito en un archivo, lo que permite reproducirlo en otro equipo y revertir cambios (ver sección 7).

---

## 7. Actualizar el sistema

La actualización se realiza en dos pasos:

```bash
# 1. Actualizar la lista de programas (canales)
sudo nix-channel --update

# 2. Aplicar las actualizaciones
sudo nixos-rebuild switch
```

### Reversión (rollback)

Cada cambio o actualización genera una "generación" del sistema. Las generaciones anteriores quedan disponibles en el menú de arranque, lo que permite volver a un estado anterior si una actualización causa problemas.

Para revertir a la generación anterior desde la terminal:

```bash
sudo nixos-rebuild switch --rollback
```

Para listar las generaciones guardadas:

```bash
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
```

### Liberar espacio en disco

Para eliminar generaciones antiguas y recuperar espacio:

```bash
sudo nix-collect-garbage -d
```

---

## 8. Opciones y gestión de usuarios

### Cambiar la contraseña

```bash
passwd
```

### Crear o eliminar usuarios

Los usuarios se declaran en `/etc/nixos/configuration.nix`. Para crear uno:

```nix
users.users.maria = {
  isNormalUser = true;
  description = "Maria Estudiante";
  extraGroups = [ "wheel" ];   # "wheel" otorga permisos de administrador (sudo)
  initialPassword = "cambiar123";
};
```

Aplica los cambios:

```bash
sudo nixos-rebuild switch
```

El grupo `wheel` otorga permisos de administrador. Asígnalo únicamente a usuarios que deban administrar el equipo.

### Ajustes del escritorio

Para fondo de pantalla, tema, idioma, teclado, pantalla, sonido, red y Bluetooth, usa la aplicación gráfica:

Menú de aplicaciones → "Preferencias del sistema" (System Settings).

---

## 9. Tareas comunes

### Conexión a Internet
Haz clic en el icono de red en la bandeja del sistema y selecciona la red Wi-Fi.

### Memorias USB y discos externos
El dispositivo aparece en Dolphin, en la barra lateral. Para retirarlo con seguridad, usa el botón de expulsar junto a su nombre.

### Activar PostgreSQL como servidor
En `/etc/nixos/configuration.nix` agrega:

```nix
services.postgresql.enable = true;
```
y ejecuta `sudo nixos-rebuild switch`.

### Activar Docker
En `/etc/nixos/configuration.nix` agrega:

```nix
virtualisation.docker.enable = true;
users.users.TU_USUARIO.extraGroups = [ "docker" ];
```
y ejecuta `sudo nixos-rebuild switch`. Cierra sesión y vuelve a iniciarla para que el usuario quede en el grupo `docker`.

### Apagar o reiniciar
Desde el menú de aplicaciones (botón de encendido) o desde la terminal:

```bash
systemctl poweroff     # Apagar
systemctl reboot       # Reiniciar
```

---

## 10. Solución de problemas

| Problema | Acción |
|----------|--------|
| Una actualización causó fallos | Reinicia y elige una generación anterior en el menú de arranque (sección 7). |
| Contraseña olvidada | Inicia en modo recuperación desde el menú de arranque. |
| Un programa no abre | Ciérralo y vuelve a abrirlo; si persiste, reinicia. |
| `permission denied` | El comando requiere `sudo`. |
| `command not found` | El programa no está instalado. Pruébalo con `nix-shell -p` (sección 6). |
| Sin conexión a Internet | Revisa el icono de red y reconéctate al Wi-Fi. |
| Disco lleno | Ejecuta `sudo nix-collect-garbage -d` (sección 7). |

---

## 11. Glosario

| Término | Significado |
|---------|-------------|
| Terminal / Konsole | Ventana para escribir comandos. |
| `sudo` | Ejecuta un comando con permisos de administrador; solicita la contraseña. |
| Paquete | Programa o herramienta que se instala. |
| NixOS | Base de Linux de AcademixOS; se configura mediante archivos de texto. |
| `configuration.nix` | Archivo que describe el sistema completo: programas, usuarios y ajustes. |
| `nixos-rebuild switch` | Aplica los cambios de la configuración. |
| Generación | Estado guardado del sistema que permite revertir cambios. |
| Live / USB Live | Ejecución del sistema desde una USB sin instalarlo. |
| Calamares | Instalador gráfico de AcademixOS. |
| KDE Plasma | Entorno de escritorio del sistema. |
