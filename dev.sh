#!/bin/bash

# Script de desarrollo para BearBox
# Autor: Jeison Vargas
# Fecha: $(date)

set -e  # Salir si cualquier comando falla

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
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

print_info() {
    echo -e "${PURPLE}ℹ️  $1${NC}"
}

print_message "Iniciando entorno de desarrollo de BearBox..."
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
    print_warning "Se encontraron problemas en el análisis del código"
    echo ""
    read -p "¿Deseas continuar de todos modos? (y/N): " continue_choice
    if [[ ! $continue_choice =~ ^[Yy]$ ]]; then
        print_error "Desarrollo cancelado por problemas en el código"
        exit 1
    fi
fi
echo ""

# Preguntar qué modo de desarrollo usar
echo "¿En qué modo deseas ejecutar la aplicación?"
echo "1) Modo debug (desarrollo)"
echo "2) Modo release (producción local)"
echo "3) Modo profile (rendimiento)"
echo ""
read -p "Selecciona una opción (1-3): " mode_choice

case $mode_choice in
    1)
        print_info "Iniciando en modo debug..."
        echo ""
        print_message "Ejecutando aplicación en modo desarrollo..."
        flutter run -d web-server --web-port 3000
        ;;
        
    2)
        print_info "Iniciando en modo release..."
        echo ""
        print_message "Construyendo aplicación en modo release..."
        flutter build web --release --web-renderer html
        if [ $? -ne 0 ]; then
            print_error "Falló la construcción de la aplicación"
            exit 1
        fi
        print_success "Aplicación construida exitosamente"
        echo ""
        
        # Verificar si Python está disponible para servir archivos estáticos
        if command -v python3 &> /dev/null; then
            print_message "Sirviendo aplicación en http://localhost:3000"
            print_info "Presiona Ctrl+C para detener el servidor"
            echo ""
            cd build/web
            python3 -m http.server 3000
        elif command -v python &> /dev/null; then
            print_message "Sirviendo aplicación en http://localhost:3000"
            print_info "Presiona Ctrl+C para detener el servidor"
            echo ""
            cd build/web
            python -m SimpleHTTPServer 3000
        else
            print_warning "Python no está disponible. Puedes servir los archivos manualmente desde build/web"
            print_info "Usa cualquier servidor HTTP estático para servir el contenido de build/web"
        fi
        ;;
        
    3)
        print_info "Iniciando en modo profile..."
        echo ""
        print_message "Ejecutando aplicación en modo profile..."
        flutter run -d web-server --web-port 3000 --profile
        ;;
        
    *)
        print_error "Opción inválida. Saliendo..."
        exit 1
        ;;
esac