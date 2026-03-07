# 📘 Manual Básico de Commits con Git

> **Objetivo:** Aprender a guardar y subir cambios en un repositorio usando la terminal de Git, dominando los comandos esenciales `git add`, `git commit` y `git push`.

---

## 📋 Tabla de Contenidos

1. [¿Qué es Git?](#qué-es-git)
2. [Configuración inicial](#configuración-inicial)
3. [Flujo de trabajo básico](#flujo-de-trabajo-básico)
4. [git add — Preparar cambios](#git-add--preparar-cambios)
5. [git commit — Guardar cambios](#git-commit--guardar-cambios)
6. [git push — Subir cambios a GitHub](#git-push--subir-cambios-a-github)
7. [Flujo completo: ejemplo práctico](#flujo-completo-ejemplo-práctico)
8. [Comandos de apoyo útiles](#comandos-de-apoyo-útiles)
9. [Buenas prácticas](#buenas-prácticas)

---

## ¿Qué es Git?

**Git** es un sistema de control de versiones que permite registrar el historial de cambios de un proyecto. Con Git puedes:

- Guardar "fotografías" del estado de tu código en cualquier momento.
- Colaborar con otros desarrolladores sin sobrescribir su trabajo.
- Revertir errores volviendo a versiones anteriores.

**GitHub** es la plataforma en la nube donde se almacenan los repositorios Git de forma remota.

---

## Configuración Inicial

Antes de realizar tu primer commit, configura tu identidad en Git. Esto solo se hace **una vez** por equipo.

```bash
# Configurar nombre de usuario
git config --global user.name "Tu Nombre"

# Configurar correo electrónico (el mismo de tu cuenta GitHub)
git config --global user.email "tu@email.com"
```

Para verificar que quedó guardado:

```bash
git config --list
```

---

## Flujo de Trabajo Básico

El proceso para guardar cambios en Git sigue siempre estos tres pasos:

```
Área de trabajo  →  git add  →  Staging Area  →  git commit  →  Repositorio local  →  git push  →  GitHub
  (tus archivos)                (cambios listos)               (historial guardado)               (nube)
```

---

## `git add` — Preparar Cambios

### ¿Qué hace?

`git add` mueve los archivos modificados al **área de preparación (staging area)**, indicándole a Git cuáles cambios quieres incluir en el próximo commit.

### Sintaxis

```bash
git add <nombre-del-archivo>
```

### Ejemplos

```bash
# Agregar un archivo específico
git add index.php

# Agregar múltiples archivos
git add index.php styles.css

# Agregar todos los archivos modificados del proyecto
git add .

# Agregar todos los archivos de una carpeta específica
git add app/Controllers/
```

> ⚠️ **Nota:** El punto (`.`) agrega **todos** los archivos nuevos y modificados. Úsalo con cuidado para no incluir archivos que no deseas subir (como `.env` con credenciales).

---

## `git commit` — Guardar Cambios

### ¿Qué hace?

`git commit` toma los archivos del área de preparación y los guarda como un **punto en el historial** del proyecto. Cada commit lleva un mensaje que describe qué se cambió.

### Sintaxis

```bash
git commit -m "Mensaje descriptivo del cambio"
```

### Ejemplos

```bash
# Commit básico con mensaje
git commit -m "Agrega formulario de registro de pacientes"

# Commit que corrige un error
git commit -m "Corrige error en el cálculo de dosis"

# Commit de mejora
git commit -m "Mejora el rendimiento en la consulta de historial clínico"
```

### Estructura de un buen mensaje de commit

```
<tipo>: <descripción corta en presente>

Ejemplos:
feat: agrega módulo de citas médicas
fix: corrige validación en formulario de paciente
docs: actualiza el README con instrucciones de instalación
style: aplica formato al controlador de usuarios
refactor: reorganiza la lógica del servicio de reportes
```

---

## `git push` — Subir Cambios a GitHub

### ¿Qué hace?

`git push` envía los commits guardados en tu repositorio **local** al repositorio **remoto** en GitHub, actualizando el proyecto en la nube.

### Sintaxis

```bash
git push <remoto> <rama>
```

### Ejemplos

```bash
# Subir cambios a la rama principal (main)
git push origin main

# Subir cambios a la rama principal (master)
git push origin master

# Subir una rama nueva por primera vez
git push -u origin nombre-de-la-rama

# Subir cambios a una rama de funcionalidad
git push origin feature/modulo-historias-clinicas
```

> 💡 **Tip:** La primera vez que subes una rama nueva, usa `-u` para establecer el seguimiento automático. Las siguientes veces bastará con `git push`.

---

## Flujo Completo: Ejemplo Práctico

Supongamos que estás desarrollando tu **panel clínico en Laravel** y acabas de agregar una nueva funcionalidad para registrar pacientes.

### Paso 1 — Verificar el estado del repositorio

```bash
git status
```

Salida esperada:
```
On branch main
Changes not staged for commit:
  modified:   app/Http/Controllers/PacienteController.php
  modified:   resources/views/pacientes/create.blade.php

Untracked files:
  app/Models/Paciente.php
```

### Paso 2 — Agregar los archivos al staging

```bash
git add app/Http/Controllers/PacienteController.php
git add resources/views/pacientes/create.blade.php
git add app/Models/Paciente.php
```

O de forma más rápida:

```bash
git add .
```

Verificar que están listos:

```bash
git status
```

Salida esperada:
```
Changes to be committed:
  modified:   app/Http/Controllers/PacienteController.php
  modified:   resources/views/pacientes/create.blade.php
  new file:   app/Models/Paciente.php
```

### Paso 3 — Crear el commit

```bash
git commit -m "feat: agrega módulo de registro de pacientes"
```

Salida esperada:
```
[main a3f92bc] feat: agrega módulo de registro de pacientes
 3 files changed, 87 insertions(+), 4 deletions(-)
 create mode 100644 app/Models/Paciente.php
```

### Paso 4 — Subir los cambios a GitHub

```bash
git push origin main
```

Salida esperada:
```
Enumerating objects: 12, done.
Counting objects: 100% (12/12), done.
Writing objects: 100% (7/7), 1.24 KiB | 1.24 MiB/s, done.
To https://github.com/usuario/panel-clinico.git
   b1c2d3e..a3f92bc  main -> main
```

✅ ¡Listo! Tus cambios ya están en GitHub.

---

## Comandos de Apoyo Útiles

| Comando | Descripción |
|---|---|
| `git status` | Muestra el estado actual de los archivos |
| `git log --oneline` | Muestra el historial de commits de forma resumida |
| `git diff` | Muestra los cambios no preparados |
| `git pull origin main` | Descarga los cambios del repositorio remoto |
| `git branch` | Lista las ramas del proyecto |
| `git checkout -b nueva-rama` | Crea y cambia a una nueva rama |

---

## Buenas Prácticas

- ✅ **Haz commits pequeños y frecuentes:** Un commit por funcionalidad o corrección es más fácil de rastrear.
- ✅ **Escribe mensajes claros:** El mensaje debe explicar *qué* y *por qué*, no solo *qué archivos* cambiaron.
- ✅ **Usa ramas:** Trabaja en una rama separada para cada funcionalidad (`feature/`) o corrección (`fix/`).
- ✅ **Haz `git pull` antes de `git push`:** Sincroniza siempre con el remoto antes de subir para evitar conflictos.
- ❌ **Nunca subas archivos `.env`:** Asegúrate de que `.env` esté en tu `.gitignore`.
- ❌ **Evita commits con mensajes genéricos** como "cambios" o "arreglos".

---

## 📁 Ejemplo de `.gitignore` para Laravel

```
/vendor
/node_modules
.env
.env.backup
.phpunit.result.cache
storage/framework/cache/
storage/logs/
public/storage
```

---

> 📌 **Referencia rápida:**
> ```bash
> git add .
> git commit -m "descripción del cambio"
> git push origin main
> ```

---

*Manual elaborado para el curso de Gestión de Versiones con Git · 2025*
