# 🐻 BearBox

Sistema de gestión de usuarios y historiales médicos desarrollado con Flutter y Firebase.

## 🌟 Características

- 👥 **Gestión de Usuarios**: Crear, editar y listar usuarios
- 📊 **Historial Médico**: Registro detallado de información médica
- 🔍 **Filtros Avanzados**: Búsqueda por nombre/email y filtro de suscripciones vencidas
- 💰 **Gestión de Suscripciones**: Control de fechas y precios de suscripciones
- 📱 **Responsive Design**: Interfaz adaptativa para diferentes dispositivos
- 🔐 **Autenticación**: Sistema de login seguro con Firebase Auth

## 🚀 Despliegue

### URL de Producción
🌍 **https://bearbox-d0112.web.app**

### Despliegue Automático
```bash
./deploy.sh
```

### Despliegue de Functions
```bash
./deploy-functions.sh
```

### Configurar WhatsApp API
```bash
./setup-whatsapp.sh
```

### Probar WhatsApp "Hola Mundo"
```bash
./test-hola-mundo.sh
```

### Desarrollo Local
```bash
./dev.sh
```

### Desarrollo Local de Functions
```bash
cd functions
npm run serve
```

## 🛠️ Tecnologías

- **Frontend**: Flutter Web
- **Backend**: Firebase
- **Base de Datos**: Cloud Firestore
- **Autenticación**: Firebase Auth
- **Hosting**: Firebase Hosting
- **Almacenamiento**: Firebase Storage
- **Functions**: Firebase Functions (Node.js)
- **WhatsApp**: API de Meta para mensajes automáticos

## 📁 Estructura del Proyecto

```
lib/
├── core/                 # Funcionalidades core
│   ├── app/             # Configuración de la app
│   ├── base/            # Clases base
│   ├── errors/          # Manejo de errores
│   ├── extension/       # Extensiones
│   ├── model/           # Modelos de datos
│   ├── util/            # Utilidades
│   └── widgets/         # Widgets compartidos
├── feature/             # Características de la app
│   ├── create_user/     # Creación de usuarios
│   ├── home/            # Página principal
│   ├── login/           # Autenticación
│   ├── medical_page/    # Información médica
│   ├── update_user/     # Edición de usuarios
│   └── users/           # Lista de usuarios
└── main.dart            # Punto de entrada

functions/                # Firebase Functions
├── index.js             # Funciones principales
├── package.json         # Dependencias
└── README.md            # Documentación
```

## 🔧 Configuración

### Requisitos Previos
- Flutter SDK
- Firebase CLI
- Node.js

### Instalación
```bash
# Clonar el repositorio
git clone <repository-url>
cd bearbox

# Instalar dependencias
flutter pub get

# Configurar Firebase
firebase login
firebase use bearbox-d0112
```

## 📖 Documentación

Para más detalles sobre el despliegue, consulta [DEPLOYMENT.md](./DEPLOYMENT.md)

## 👨‍💻 Desarrollador

**Jeison Vargas** - Desarrollador Full Stack

---

**BearBox** - Sistema de gestión integral para gimnasios y centros de fitness
