# Manual de Exportación del ISO de AcademixOS

Guía para construir (exportar) la imagen ISO de la distribución a partir del código del repositorio.

---

## Objetivo

AcademixOS está definido en archivos `.nix`. A partir de ellos se genera un archivo `.iso` que puede grabarse en una memoria USB e instalarse en un equipo.

El resultado final es un archivo con la forma:

```
result/iso/academixos-25.11-x86_64-linux.iso
```

---

## Requisitos

El ISO solo se construye desde Linux. El proyecto puede editarse en Windows, pero la construcción requiere herramientas de Linux. Opciones válidas:

- Un equipo con NixOS instalado.
- Una distribución Linux (Ubuntu, Debian, etc.) con Nix instalado.
- WSL2 en Windows.

Requisitos de recursos: conexión estable y al menos 15–20 GB de espacio libre en disco. La primera construcción descarga y compila muchos paquetes.

---

## Paso 1. Instalar Nix

Si ya usas NixOS, omite este paso.

En Ubuntu, Debian, WSL2 u otra distribución, instala Nix con el instalador oficial:

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

Cierra y vuelve a abrir la terminal, y verifica la instalación:

```bash
nix --version
```

---

## Paso 2. Activar flakes

El proyecto usa flakes. En NixOS suele estar activado; en otros sistemas se habilita una sola vez:

```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

Un flake es una definición reproducible del proyecto: a partir del mismo código se obtiene el mismo resultado.

---

## Paso 3. Obtener el proyecto

Clona el repositorio y entra a la carpeta:

```bash
git clone <URL-del-repositorio> Academix-OS
cd Academix-OS
```

Si ya tienes la carpeta, entra en ella con `cd`. Verifica que existe `flake.nix`:

```bash
ls flake.nix
```

---

## Paso 4. Construir el ISO

Desde la raíz del proyecto:

```bash
nix build .#iso
```

- `nix build`: construye un objetivo.
- `.#iso`: el `.` indica el proyecto actual e `iso` es el objetivo definido en `flake.nix`.

La primera construcción puede tardar bastante. Las siguientes son más rápidas porque Nix reutiliza lo ya descargado.

Para ver el detalle del proceso y registros de error completos:

```bash
nix build .#iso -L
```

---

## Paso 5. Localizar el ISO

Al terminar, Nix crea un enlace `result` que apunta al ISO:

```bash
ls -lh result/iso/
```

Como `result` es un enlace, copia el ISO a tu carpeta personal:

```bash
cp result/iso/*.iso ~/AcademixOS.iso
```

---

## Paso 6. Validar la configuración (opcional)

Para comprobar que la configuración no tiene errores sin esperar toda la construcción:

```bash
nix flake check
```

Útil tras modificar archivos `.nix`, antes de lanzar `nix build`.

---

## Paso 7. Probar en máquina virtual (opcional)

El proyecto incluye una configuración de prueba en `configuration.nix` que arranca en una máquina virtual:

```bash
nix-build '<nixpkgs/nixos>' -A vm -I nixpkgs=channel:nixos-25.11 -I nixos-config=./configuration.nix
./result/bin/run-*-vm
```

Esta VM usa `configuration.nix`, que es distinta del ISO real. Sirve para pruebas rápidas, no es la imagen final.

---

## Paso 8. Grabar el ISO en una USB (opcional)

El proceso borra todo el contenido de la USB. Verifica el dispositivo correcto antes de continuar.

Desde Linux (reemplaza `/dev/sdX` por tu dispositivo; confírmalo con `lsblk`):

```bash
lsblk
sudo dd if=~/AcademixOS.iso of=/dev/sdX bs=4M status=progress conv=fsync
```

Desde Windows o con interfaz gráfica: usa balenaEtcher o Ventoy.

---

## Problemas comunes

| Problema | Solución |
|----------|----------|
| `error: experimental Nix feature 'nix-command' is disabled` | No se activaron los flakes. Revisa el Paso 2. |
| `command not found: nix` | Nix no quedó instalado o no se reinició la terminal. Repite el Paso 1. |
| Proceso prolongado descargando o compilando | Es normal en la primera construcción. No lo canceles. |
| `No space left on device` | Falta espacio en disco. Libera al menos 15–20 GB. |
| No funciona en Windows nativo | El ISO no se construye en Windows nativo. Usa WSL2 o un equipo Linux. |

Para liberar espacio de construcciones anteriores:

```bash
nix-collect-garbage -d
```

---

## Resumen de comandos

```bash
# 1. (Una sola vez) Activar flakes
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# 2. Entrar al proyecto
cd Academix-OS

# 3. (Opcional) Validar configuración
nix flake check

# 4. Construir el ISO
nix build .#iso

# 5. Copiar el resultado
cp result/iso/*.iso ~/AcademixOS.iso
```

Tras modificar los archivos `.nix` del proyecto, vuelve a ejecutar `nix build .#iso` para obtener un nuevo ISO con los cambios.
