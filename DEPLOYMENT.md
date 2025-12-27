# 🚀 Guía de Despliegue - BearBox

Esta guía te ayudará a desplegar la aplicación BearBox en Firebase Hosting y Functions.

## 📋 Prerrequisitos

Antes de desplegar, asegúrate de tener instalado:

- **Flutter SDK** (versión 3.8.1 o superior)
- **Node.js** (versión 16 o superior)
- **npm** (viene con Node.js)
- **Firebase CLI** (`npm install -g firebase-tools`)

## 🔐 Configuración Inicial

1. **Inicia sesión en Firebase:**
   ```bash
   firebase login
   ```

2. **Configura el proyecto:**
   ```bash
   firebase use --add
   ```
   Selecciona tu proyecto de Firebase.

## 📁 Scripts Disponibles

### 1. `./deploy.sh` - Despliegue de la Aplicación Web
Despliega solo la aplicación web en Firebase Hosting.

```bash
./deploy.sh
```

**Características:**
- ✅ Verificaciones automáticas
- 🧹 Limpieza de builds anteriores
- 📦 Instalación de dependencias
- 🔍 Análisis de código
- 🔨 Construcción optimizada para web
- 🌐 Despliegue en Firebase Hosting

### 2. `./deploy-functions.sh` - Despliegue de Funciones
Despliega solo las funciones de Firebase.

```bash
./deploy-functions.sh
```

**Características:**
- ✅ Verificaciones de Node.js y npm
- 📦 Instalación de dependencias de funciones
- 🔧 Despliegue de funciones de Firebase

### 3. `./deploy-all.sh` - Despliegue Completo
Despliega tanto la aplicación web como las funciones.

```bash
./deploy-all.sh
```

**Opciones disponibles:**
1. Solo la aplicación web
2. Solo las funciones de Firebase
3. Todo (web + funciones)

### 4. `./dev.sh` - Desarrollo Local
Ejecuta la aplicación en modo desarrollo local.

```bash
./dev.sh
```

**Modos disponibles:**
1. **Debug** - Modo desarrollo con hot reload
2. **Release** - Modo producción local
3. **Profile** - Modo para análisis de rendimiento

## 🛠️ Comandos Manuales

Si prefieres ejecutar los comandos manualmente:

### Despliegue de Web
```bash
# Limpiar y obtener dependencias
flutter clean
flutter pub get

# Construir para web
flutter build web --release --web-renderer html

# Desplegar
firebase deploy --only hosting
```

### Despliegue de Funciones
```bash
# Navegar a functions
cd functions

# Instalar dependencias
npm install

# Volver al directorio raíz
cd ..

# Desplegar funciones
firebase deploy --only functions
```

### Despliegue Completo
```bash
firebase deploy
```

## 🌐 URLs de Acceso

Después del despliegue, tu aplicación estará disponible en:

- **Aplicación Web:** `https://[PROJECT_ID].web.app`
- **Consola Firebase:** `https://console.firebase.google.com/project/[PROJECT_ID]/overview`
- **Funciones:** `https://console.firebase.google.com/project/[PROJECT_ID]/functions`

## 🔧 Configuración de Firebase

El archivo `firebase.json` está configurado con:

```json
{
    "hosting": {
        "public": "build/web",
        "rewrites": [
            {
                "source": "**",
                "destination": "/index.html"
            }
        ]
    },
    "functions": {
        "source": "functions",
        "runtime": "nodejs18"
    }
}
```

## 🚨 Solución de Problemas

### Error: "Firebase CLI no está instalado"
```bash
npm install -g firebase-tools
```

### Error: "No estás logueado en Firebase"
```bash
firebase login
```

### Error: "Flutter no está instalado"
Instala Flutter desde [flutter.dev](https://flutter.dev/docs/get-started/install)

### Error: "Node.js no está instalado"
Instala Node.js desde [nodejs.org](https://nodejs.org/)

### Error de construcción
```bash
flutter clean
flutter pub get
flutter build web --release
```

## 📊 Monitoreo

Después del despliegue, puedes monitorear:

- **Hosting:** Estadísticas de tráfico y rendimiento
- **Functions:** Logs y métricas de ejecución
- **Analytics:** Datos de uso de la aplicación

## 🔄 Actualizaciones

Para actualizar la aplicación:

1. Haz los cambios en tu código
2. Ejecuta el script de despliegue correspondiente
3. Los cambios se reflejarán automáticamente

## 📝 Notas Importantes

- Los scripts incluyen verificaciones automáticas
- Se detienen si encuentran errores críticos
- Incluyen mensajes de colores para mejor legibilidad
- Muestran información detallada del proceso

## 🆘 Soporte

Si encuentras problemas:

1. Verifica que todos los prerrequisitos estén instalados
2. Revisa los logs de error en la consola
3. Consulta la documentación de Firebase
4. Verifica la configuración de tu proyecto

---

**¡Despliega con confianza! 🚀**