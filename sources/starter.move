module starter/*Esto se puede cambiar por la direccion en Move.toml*/::biblioteca {
    use std::string::{String, utf8};
    use sui::vec_map::{VecMap, Self};

    #[error]
    const ID_YA_EXITSE: vector<u8> = b"El ID que se intento poner ya existe.";

    public struct Biblioteca has key{
        id: UID,
        nombre: String,
        libros: VecMap<u64, Libro>,
    }

    public struct Libro has store{      //has significa tiene y store sirve para almacenar
        titulo: String,
        autor: String,
        publicacion: u16,
        disponible: bool,
    }

    public fun crear_biblioteca(ctx: &mut TxContext) {     //Esta linea tambien es siempre esta
        let biblioteca = Biblioteca {
            id: object::new(ctx),        //Siempre tiene que ser asi
            nombre: utf8(b"Biblioteca Latinoamericana"),
            libros: vec_map::empty(),           //Es bueno identificar de donde estamos importando empty
        };

        //Esta linea siempre sera igual, objeto, tx_context::sender()
        transfer::transfer(biblioteca, tx_context::sender());       //tx_context es la informacion de la persona en modo SUI
        
    }

    //pedirle al usuario es:
    public fun agregar_libro(biblioteca: &mut Biblioteca, id: u64, titulo: String, autor: String, publicacion: u16) {
        assert!(!biblioteca.libros.contains(&id), ID_YA_EXITSE);       //Aqui estamos diciendo que si no se contiene arrojemos 0

        let libro = Libro{titulo, autor, publicacion, disponible: true};
        biblioteca.libros.insert(id, libro);
    }

}