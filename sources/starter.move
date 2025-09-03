module starter::practica_sui {
    use std::debug::print;
    use std::string::{String, utf8};


    public struct Usuario has drop{
        nombre : String,
        edad: u8,
        vivo: bool,
    }

    fun practica(usuario: Usuario) {
        if(usuario.edad > 18) {
            print(&utf8(b"Acceso Permitido"));
        }else if (usuario.edad == 18){
            print(&utf8(b"Felicidades!"));
        }else {
            print(&utf8(b"Acceso no permitido"));
        }
    }

    #[test]
    fun prueba() {
        let usuario = Usuario {
            nombre: utf8(b"Danya Gonzalez"),
            edad: 18,
            vivo: true,
        };

        practica(usuario);
    }
}