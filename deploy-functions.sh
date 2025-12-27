#!/bin/bash

# Script de despliegue para las funciones de Firebase de BearBox
# Autor: Jeison Vargas
# Fecha: $(date)

set -e  # Salir si cualquier comando falla

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para imprimir mensajes con colores
print_message() {
    echo -e "${BLUE}🚀 $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_message "Iniciando despliegue de funciones de Firebase para BearBox..."
echo "📅 Fecha: $(date)"
echo ""

# Verificar que estamos en el directorio correcto
if [ ! -f "firebase.json" ]; then
    print_error "No se encontró firebase.json. Asegúrate de estar en el directorio raíz del proyecto."
    exit 1
fi

# Verificar que Firebase CLI esté instalado
if ! command -v firebase &> /dev/null; then
    print_error "Firebase CLI no está instalado. Instálalo con: npm install -g firebase-tools"
    exit 1
fi

# Verificar que esté logueado en Firebase
if ! firebase projects:list &> /dev/null; then
    print_error "No estás logueado en Firebase. Ejecuta: firebase login"
    exit 1
fi

# Verificar que Node.js esté instalado
if ! command -v node &> /dev/null; then
    print_error "Node.js no está instalado."
    exit 1
fi

# Verificar que npm esté instalado
if ! command -v npm &> /dev/null; then
    print_error "npm no está instalado."
    exit 1
fi

print_success "Verificaciones completadas"
echo ""

# Verificar que existe el directorio de funciones
if [ ! -d "functions" ]; then
    print_error "No se encontró el directorio 'functions'."
    exit 1
fi

# Navegar al directorio de funciones
cd functions

# Verificar que existe package.json
if [ ! -f "package.json" ]; then
    print_error "No se encontró package.json en el directorio functions."
    exit 1
fi

print_message "Instalando dependencias de las funciones..."
npm install
if [ $? -ne 0 ]; then
    print_error "Falló la instalación de dependencias"
    exit 1
fi
print_success "Dependencias instaladas"
echo ""

# Volver al directorio raíz
cd ..

# Desplegar las funciones
print_message "Desplegando funciones de Firebase..."
firebase deploy --only functions
if [ $? -ne 0 ]; then
    print_error "Falló el despliegue de las funciones"
    exit 1
fi
print_success "Funciones desplegadas exitosamente"
echo ""

# Obtener la URL del proyecto
PROJECT_ID=$(firebase use --current 2>/dev/null | grep -o '\[.*\]' | tr -d '[]' || echo "bearbox-d0112")
echo "🎉 ¡Funciones de BearBox han sido desplegadas exitosamente!"
echo "🔧 Consola de Firebase Functions: https://console.firebase.google.com/project/$PROJECT_ID/functions"
echo "📊 Consola de Firebase: https://console.firebase.google.com/project/$PROJECT_ID/overview"
echo ""
echo "✨ Despliegue de funciones completado en: $(date)"