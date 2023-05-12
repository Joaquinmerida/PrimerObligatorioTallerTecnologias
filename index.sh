#! /bin/bash

menu(){
    echo "Bienvenido!"
    echo " "
    echo "1)Opción 1. Ingresar Usuario y Contraseña."
    echo "2)Opción 2. Ingresar al sistema."
    echo "3)Opción 3. Salir del sistema."
    read inputUsuario

}

inicio(){
    menu
    while [ $inputUsuario -ne 3 ]
    do
    if [ $inputUsuario -eq 1 ];
    then
        ingresoUsuario
    elif [ $inputUsuario -eq 2 ]
    then
        ingresoAlSistema
    elif [ $inputUsuario -eq 3 ];
    then
        exit
    else
    echo "no es una opción valida"
    fi
    read inputUsuario
    done
}

ingresoUsuario(){
    echo "Bienvenido a la creacion de usuario:"
    echo "Ingrese su usuario"
    read usuarioNombre
    echo "Ingrese su contraseña"
    read userPassword
    echo "usuario creado: nombre:$usuarioNombre contraseña:$userPassword"
    fechaCreacion="$(date +"%Y-%m-%d")"
    usuario="$usuarioNombre:$userPassword:$fechaCreacion" 
    echo $usuario >> usuarios.txt
    inicio
}

ingresoAlSistema(){
echo "Ingrese su usuario:"
read nombre_usuario
echo "Ingrese su contraseña:"
read contrasena

encontrado=0
fecha="$(date +"%Y-%m-%d")"
while IFS= read linea; 
do
    usuario=$(echo "$linea" | cut -d ":" -f 1)
    echo "$usuario"
    password=$(echo "$linea" | cut -d ":" -f 2)
    echo "$password"
    fechaIngreso=$(echo "$linea" | cut -d ":" -f 3)
    echo "$fechaIngreso"

    if [ "$usuario" = "$nombre_usuario" ] && [ "$password" = "$contrasena" ]; then
        encontrado=1
        if [ $fechaIngreso == $fecha ]; then
            echo "Bienvenido, $nombre_usuario"
            echo "su ultimo ingreso fue $fechaIngreso"
            break
        elif [ $fechaIngreso != $fecha ]; then
            echo "Bienvenido, $nombre_usuario"
            echo "Usted ingresó por última vez el $fechaIngreso"
            sed -i -r "s/(^$usuario.*):(.*)/\1:$fecha/" usuarios.txt
            break
        fi
        break
    fi
    if [ "$usuario" != "$nombre_usuario" ] || [ "$password" != "$contrasena" ]; then
        echo "usuario o contraseña incorrectos"
        break
    fi
done < usuarios.txt
}


inicio
