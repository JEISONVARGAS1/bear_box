# Firebase Functions - BearBox WhatsApp

Este directorio contiene las Firebase Functions específicamente para WhatsApp de la aplicación BearBox.

## 🚀 Funciones Disponibles

### WhatsApp Functions

1. **sendWhatsAppCron** - Se ejecuta cada minuto para enviar "Hola mundo" al número +573173734269
2. **sendWhatsAppManual** - Envía un mensaje de WhatsApp manualmente (HTTP POST)
3. **getWhatsAppStatus** - Obtiene el estado de la configuración de WhatsApp (HTTP GET)
4. **sendHolaMundo** - Envía "Hola mundo" al número específico manualmente (HTTP GET/POST)

## Instalación

```bash
cd functions
npm install
```

## Desarrollo Local

Para ejecutar las funciones localmente:

```bash
npm run serve
```

Esto iniciará el emulador de Firebase Functions en `http://localhost:5001`.

## Despliegue

Para desplegar las funciones a Firebase:

```bash
npm run deploy
```

## Logs

Para ver los logs de las funciones:

```bash
npm run logs
```

## Estructura del Proyecto

```
functions/
├── index.js          # Archivo principal con funciones de WhatsApp
├── package.json      # Dependencias y scripts
├── .gitignore        # Archivos a ignorar
└── README.md         # Este archivo
```

## Configuración

Las funciones están configuradas para:
- Usar Node.js 18
- Manejar CORS automáticamente
- Enviar mensajes a WhatsApp Business API
- Ejecutarse cada minuto automáticamente

### Configuración de WhatsApp

Para usar las funciones de WhatsApp, necesitas configurar las variables de entorno:

1. **Crear archivo `.env` en el directorio `functions/`:**
   ```bash
   WHATSAPP_ACCESS_TOKEN=tu_access_token_aqui
   WHATSAPP_PHONE_NUMBER_ID=tu_phone_number_id_aqui
   ```

2. **Obtener credenciales de Meta:**
   - Ve a [Meta for Developers](https://developers.facebook.com/)
   - Crea una aplicación
   - Configura WhatsApp Business API
   - Obtén el Access Token y Phone Number ID

3. **Configurar variables en Firebase:**
   ```bash
   firebase functions:config:set whatsapp.access_token="tu_token"
   firebase functions:config:set whatsapp.phone_number_id="tu_phone_id"
   ```

## Notas Importantes

- Todas las funciones HTTP incluyen manejo de CORS
- Los errores se manejan de forma consistente
- **WhatsApp**: La función automática está comentada por seguridad. Descomenta cuando tengas las credenciales configuradas
- **Cron**: La función se ejecuta cada minuto. Puedes cambiar el intervalo modificando `'every 1 minutes'`
- **Número específico**: Configurado para +573173734269
- **Mensaje**: "Hola mundo" (puedes personalizarlo en el código) 