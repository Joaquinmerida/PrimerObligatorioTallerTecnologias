#! /bin/bash

inicio(){

    echo "Bienvenido!"
    echo " "
    echo "1)Opción 1. Ingresar Usuario y Contraseña."
    echo "2)Opción 2. Ingresar al sistema."
    echo "3)Opción 3. Salir del sistema."
    read inputUsuario

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
    usuario="$usuarioNombre/$userPassword" 
    echo $usuario >> usuarios.txt
}

ingresoAlSistema(){
    echo "Ingrese su usuario"
    read ingresoUsuario
    echo "Ingrese su contrasena"
    read ingresoContrasena
while read usuarioYContrasena; do
    for (( i=0; i<${#usuarioYContrasena}; i++ )); do
    if [ "${usuarioYContrasena:i:1}" = "/" ]; then
    echo "Se encontró el carácter '/' en la posición $i"
    usuario=$(echo $usuarioYContrasena | cut -d "/" -f 1)
    password=$(echo $usuarioYContrasena | cut -d "/" -f 2)
    #usuario="${usuarioYContrasena:$i}"
    #password="${usuarioYContrasena:$(($i+1))}"
    break
    fi
    done
echo "$usuario - $password"
done < usuarios.txt
}

#falta comparar los usuarios con los inputs del ingreso
#arreglar nombres de las variables


inicio
