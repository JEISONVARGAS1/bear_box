#!/bin/bash

# Script de despliegue para BearBox en Firebase Hosting
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

print_message "Iniciando despliegue de BearBox en Firebase Hosting..."
echo "📅 Fecha: $(date)"
echo ""

# Verificar que estamos en el directorio correcto
if [ ! -f "pubspec.yaml" ]; then
    print_error "No se encontró pubspec.yaml. Asegúrate de estar en el directorio raíz del proyecto."
    exit 1
fi

# Verificar que Flutter esté instalado
if ! command -v flutter &> /dev/null; then
    print_error "Flutter no está instalado o no está en el PATH."
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

print_success "Verificaciones completadas"
echo ""

# Mostrar información del proyecto
echo "📋 Información del proyecto:"
echo "   - Proyecto: $(grep 'name:' pubspec.yaml | cut -d' ' -f2)"
echo "   - Versión: $(grep 'version:' pubspec.yaml | cut -d' ' -f2)"
echo "   - Directorio: $(pwd)"
echo ""

# Limpiar build anterior
print_message "Limpiando build anterior..."
flutter clean
print_success "Limpieza completada"
echo ""

# Obtener dependencias
print_message "Obteniendo dependencias..."
flutter pub get
print_success "Dependencias obtenidas"
echo ""

# Verificar que no hay errores críticos (ignorando warnings de estilo)
print_message "Verificando código..."
flutter analyze --no-fatal-infos
if [ $? -ne 0 ]; then
    print_warning "Se encontraron problemas en el análisis del código, pero continuando..."
fi
echo ""

# Construir la aplicación para web
print_message "Construyendo aplicación para web..."
flutter build web --release
if [ $? -ne 0 ]; then
    print_error "Falló la construcción de la aplicación"
    exit 1
fi
print_success "Aplicación construida exitosamente"
echo ""

# Verificar que el build se creó correctamente
if [ ! -d "build/web" ]; then
    print_error "El directorio build/web no se creó correctamente"
    exit 1
fi

# Mostrar tamaño del build
BUILD_SIZE=$(du -sh build/web | cut -f1)
echo "📊 Tamaño del build: $BUILD_SIZE"
echo ""

# Desplegar en Firebase Hosting
print_message "Desplegando en Firebase Hosting..."
firebase deploy --only hosting
if [ $? -ne 0 ]; then
    print_error "Falló el despliegue en Firebase"
    exit 1
fi
print_success "Despliegue completado exitosamente"
echo ""

# Obtener la URL del proyecto
PROJECT_ID=$(firebase use --current 2>/dev/null | grep -o '\[.*\]' | tr -d '[]' || echo "bearbox-d0112")
echo "🎉 ¡BearBox ha sido desplegado exitosamente!"
echo "🌍 URL de la aplicación: https://$PROJECT_ID.web.app"
echo "📊 Consola de Firebase: https://console.firebase.google.com/project/$PROJECT_ID/overview"
echo ""
echo "✨ Despliegue completado en: $(date)" 