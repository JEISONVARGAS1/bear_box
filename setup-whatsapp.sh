#!/bin/bash

echo "📱 Configurando WhatsApp API para BearBox..."

# Verificar si Firebase CLI está instalado
if ! command -v firebase &> /dev/null; then
    echo "❌ Firebase CLI no está instalado. Instálalo con: npm install -g firebase-tools"
    exit 1
fi

# Solicitar credenciales
echo ""
echo "🔑 Ingresa las credenciales de WhatsApp API:"
echo ""

read -p "📞 Access Token: " access_token
read -p "📱 Phone Number ID: " phone_number_id

# Validar que no estén vacías
if [ -z "$access_token" ] || [ -z "$phone_number_id" ]; then
    echo "❌ Error: Las credenciales no pueden estar vacías"
    exit 1
fi

# Configurar variables en Firebase
echo ""
echo "⚙️ Configurando variables en Firebase..."
firebase functions:config:set whatsapp.access_token="$access_token"
firebase functions:config:set whatsapp.phone_number_id="$phone_number_id"

# Crear archivo .env local
echo ""
echo "📝 Creando archivo .env local..."
cat > functions/.env << EOF
WHATSAPP_ACCESS_TOKEN=$access_token
WHATSAPP_PHONE_NUMBER_ID=$phone_number_id
EOF

echo ""
echo "✅ ¡Configuración completada!"
echo ""
echo "📋 Próximos pasos:"
echo "1. Despliega las funciones: ./deploy-functions.sh"
echo "2. Prueba manualmente: curl -X POST https://tu-proyecto.cloudfunctions.net/sendWhatsAppManual"
echo "3. Verifica el estado: curl https://tu-proyecto.cloudfunctions.net/getWhatsAppStatus"
echo ""
echo "⚠️  Recuerda: Descomenta la línea de envío en sendWhatsAppCron cuando estés listo" 