const functions = require("firebase-functions");
const axios = require("axios");

const WHATSAPP_TOKEN = "EAAzZBoG81iM8BPFi0XFXzCoOZAVzudbfL9ZBq42Wcapbdk8YlnxP7txQffURJdGvydn3bReEQt11AIxeedYRVpAJ0upa2hWcNyGKVlUfvtE8HgL5cZCkmxUiqwNZBXKnawhHZBgbbkspPzhpS6YEcPuBNaNh87m1dTAuunznN4Y7YvxSUHTPwRaQQ1qNkVq2u6BHiCwTZCpb39pnYM51GL02BrBB8S3QUZCRzkGOWFWOIgZDZD";
const PHONE_NUMBER_ID = "703974576135362";
const TO_PHONE_NUMBER = "573173734269";

exports.sendWhatsappMessageEveryMinute = functions.pubsub
    .schedule("every 1 minutes")
    .onRun(async (context) => {
        const url = `https://graph.facebook.com/v17.0/${PHONE_NUMBER_ID}/messages`;

        const payload = {
            messaging_product: "whatsapp",
            to: TO_PHONE_NUMBER,
            type: "template",
            template: {
                name: "hello_world", // Asegúrate de tener esta plantilla activa
                language: {
                    code: "en_us",
                },
            },
        };

        try {
            const response = await axios.post(url, payload, {
                headers: {
                    Authorization: `Bearer ${WHATSAPP_TOKEN}`,
                    "Content-Type": "application/json",
                },
            });

            console.log("✅ Mensaje enviado:", response.data);
        } catch (error) {
            console.error("❌ Error al enviar el mensaje:", error.response?.data || error.message);
        }

        return null;
    });
