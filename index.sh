#!/bin/bash

listaUsuarios="usuarios.txt"
diccionario="diccionario.txt"

primerMenu() {
    echo ~~~~~~~~~~~~~~~~~~~~~~~
    echo "Bienvenido!"
    echo "1) Opción 1. Ingresar Usuario y Contraseña"
    echo "2) Opción 2. Ingresar al sistema."
    echo "3) Salir del Sistema."
    echo ~~~~~~~~~~~~~~~~~~~~~~~
    echo -n "Ingrese una opción: "
}

segundoMenu() {
    echo ~~~~~~~~~~~~~~~~~~~~~~~
    echo "Bienvenido, $usuario!"
    echo "Último acceso: $ultimoAcceso"
    echo "1) Cambiar Contraseña."
    echo "2) Escoger una letra."
    echo "3) Buscar palabras en el diccionario que finalicen con la letra escogida."
    echo "4) Contar las palabras de la Opción 3."
    echo "5) Guardar las palabras en un archivo.txt, en conjunto con la fecha y hora de realizado el informe."
    echo "6) Volver al Menú Principal."
    echo ~~~~~~~~~~~~~~~~~~~~~~~
    echo -n "Ingrese una opción: "
}

opcion1() {
    echo ~~~~~~~~~~~~~~~~~~~~~~~
    echo "Ingrese el nombre de usuario: "
    read usuario
    echo "Ingrese la contraseña: "
    read contrasena
    echo ~~~~~~~~~~~~~~~~~~~~~~~

    fecha=$(date "+%d-%m-%Y")

    echo "$usuario:$contrasena:$fecha" >> "$listaUsuarios"
}

opcion2() {
    echo ~~~~~~~~~~~~~~~~~~~~~~~
    echo "Ingrese el nombre de usuario: " 
    read usuario
    echo "Ingrese la contraseña: " 
    read contrasena
    echo ~~~~~~~~~~~~~~~~~~~~~~~

    infoUsuario=$(grep "^${usuario}:" "$listaUsuarios")

    if [[ -n $infoUsuario ]]; then
        contrasenaGuardado=$(echo "$infoUsuario" | cut -d":" -f2)
        ultimoAcceso=$(echo "$infoUsuario" | cut -d":" -f3)

        if [[ $contrasena == $contrasenaGuardado ]]; then
            fecha=$(date "+%d-%m-%Y")
            letra="a"
            sed -i "s|^${usuario}:${contrasenaGuardado}:.*$|${usuario}:${contrasenaGuardado}:${fecha}|" "$listaUsuarios"
            
            echo

            while true; do
                segundoMenu
                read opcionElegida
                echo

                case $opcionElegida in
                    1)                     
                        echo "Ingrese la nueva contraseña: " 
                        read contrasenaNueva
                        echo
                        
                        sed -i "s|^${usuario}:${contrasenaGuardado}:.*$|${usuario}:${contrasenaNueva}:${ultimoAcceso}|" "$listaUsuarios"

                        echo "Contraseña cambiada.";;
                    2)
                        echo "Ingrese una letra: " 
                        read letra
                        echo

                        echo "Ha ingresado la letra: $letra";;
                    3)                        
                        palabras=()

                        while IFS= read -r palabra; do
                            if [[ "${palabra:0:1}" == "$letra" ]]; then
                                palabras+=("$palabra")
                            fi
                        done < "diccionario.txt";;
                    4)                  
                        cuentaPalabras="${#palabras[@]}"
                        echo "Palabras encontradas: $cuentaPalabras";;
                    5)          
                        nombreArchivo="informe_$(date "+%d%m%Y_%H%M%S").txt"

                        echo "Fecha y hora del informe: $(date)" > "$nombreArchivo"
                        echo "Palabras encontradas que comienzan con la letra $letra:" >> "$nombreArchivo"
                        for palabra in "${palabras[@]}"; do
                            echo "$palabra" >> "$nombreArchivo"
                        done;;
                    6)
                        break;;
                    *)
                        echo "Opción inválida. Por favor, intente nuevamente.";;
                esac

                echo
            done
        else
            echo "Contraseña incorrecta. Intente nuevamente."
        fi
    else
        echo "Usuario no encontrado. Intente nuevamente."
    fi
}

guardarVariable(){
    echo "Ingresa una letra para buscar"
    read letra
}

buscarPalabras(){
    if [[ "$letra" != "a" ]]; then 
    buscar=$(grep "^${letra}:" "$diccionario")
    else
    buscar=$(grep "^${"a"}:" "$diccionario")
    encontrados=0
    fi
    echo $buscar
}

while true; do
    primerMenu
    read opcionElegida
    echo

    case $opcionElegida in
        1)
            opcion1
            ;;
        2)
            opcion2
            ;;
        3)
            echo "Saliendo del Sistema."
            break
            ;;
        *)
            echo "Opción inválida. Por favor, intente nuevamente."
            ;;
    esac

    echo
done