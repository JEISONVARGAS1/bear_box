# 📱 Configuración de WhatsApp API - BearBox

Esta guía te ayudará a configurar la integración de WhatsApp con tu aplicación BearBox.

## 🚀 Funciones Disponibles

### 1. **sendWhatsAppCron** - Mensajes Automáticos
- **Frecuencia**: Cada minuto
- **Función**: Envía mensajes personalizados a todos los usuarios
- **Estado**: Comentado por seguridad (requiere configuración)

### 2. **sendWhatsAppManual** - Envío Manual
- **Método**: POST
- **Endpoint**: `/sendWhatsAppManual`
- **Body**: `{ "phoneNumber": "1234567890", "message": "Hola!" }`

### 3. **getWhatsAppStatus** - Estado de la API
- **Método**: GET
- **Endpoint**: `/getWhatsAppStatus`
- **Función**: Verifica la configuración de WhatsApp

## 🔧 Configuración Paso a Paso

### Paso 1: Crear Aplicación en Meta

1. Ve a [Meta for Developers](https://developers.facebook.com/)
2. Crea una nueva aplicación
3. Selecciona "Business" como tipo
4. Completa la información básica

### Paso 2: Configurar WhatsApp Business API

1. En tu aplicación, ve a "Add Product"
2. Busca y agrega "WhatsApp"
3. Configura tu número de teléfono
4. Completa la verificación

### Paso 3: Obtener Credenciales

1. **Access Token**:
   - Ve a "WhatsApp" > "Getting Started"
   - Copia el "Temporary access token" o genera uno permanente

2. **Phone Number ID**:
   - Ve a "WhatsApp" > "Phone Numbers"
   - Copia el "Phone number ID"

### Paso 4: Configurar en BearBox

#### Opción A: Script Automático
```bash
./setup-whatsapp.sh
```

#### Opción B: Manual
```bash
# Configurar variables en Firebase
firebase functions:config:set whatsapp.access_token="tu_token"
firebase functions:config:set whatsapp.phone_number_id="tu_phone_id"

# Crear archivo .env
echo "WHATSAPP_ACCESS_TOKEN=tu_token" > functions/.env
echo "WHATSAPP_PHONE_NUMBER_ID=tu_phone_id" >> functions/.env
```

### Paso 5: Desplegar Funciones
```bash
./deploy-functions.sh
```

## 🧪 Pruebas

### 1. Verificar Estado
```bash
curl https://bearbox-d0112.cloudfunctions.net/getWhatsAppStatus
```

### 2. Enviar Mensaje Manual
```bash
curl -X POST https://bearbox-d0112.cloudfunctions.net/sendWhatsAppManual \
  -H "Content-Type: application/json" \
  -d '{
    "phoneNumber": "1234567890",
    "message": "¡Hola desde BearBox! 🐻"
  }'
```

### 3. Activar Mensajes Automáticos

1. Edita `functions/index.js`
2. Busca la línea comentada:
   ```javascript
   // await sendWhatsAppMessage(user.phone, message);
   ```
3. Descomenta la línea:
   ```javascript
   await sendWhatsAppMessage(user.phone, message);
   ```
4. Redespliega las funciones

## 📋 Formato de Mensajes

### Mensaje Automático
```
¡Hola {nombre}! 🐻

Este es tu recordatorio automático de BearBox.

📊 Tu información actual:
• Peso: {peso} kg
• Altura: {altura} m
• Género: {género}

💪 ¡Mantén tu rutina de ejercicios!

Saludos,
Equipo BearBox
```

### Personalización
Puedes modificar el mensaje en `functions/index.js` línea ~250.

## ⚠️ Consideraciones Importantes

### Seguridad
- **Nunca** subas credenciales a Git
- Usa variables de entorno
- El archivo `.env` está en `.gitignore`

### Límites de la API
- **Rate Limits**: 1000 mensajes por segundo
- **Formato**: Números de teléfono con código de país
- **Horarios**: Respeta horarios de tus usuarios

### Costos
- WhatsApp Business API tiene costos por mensaje
- Revisa la [página de precios de Meta](https://developers.facebook.com/docs/whatsapp/pricing)

## 🔍 Troubleshooting

### Error: "Invalid access token"
- Verifica que el token sea válido
- Asegúrate de que la aplicación tenga permisos de WhatsApp

### Error: "Invalid phone number"
- Usa formato internacional: +1234567890
- Verifica que el número esté verificado en WhatsApp

### Error: "Rate limit exceeded"
- Reduce la frecuencia de envío
- Implementa cola de mensajes

### Función no se ejecuta
- Verifica que esté desplegada correctamente
- Revisa los logs: `firebase functions:log`

## 📞 Soporte

Si tienes problemas:
1. Revisa los logs de Firebase
2. Verifica la documentación de Meta
3. Consulta el README de functions

---

**¡Listo para enviar mensajes automáticos! 🚀** 