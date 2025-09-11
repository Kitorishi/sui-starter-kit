module starter::mi_proyecto {
     use std::string::{String};
    use sui::vec_map::{VecMap, Self};

    #[error]
    const EXISTING_ID: vector<u8> = b"The ID you are trying to add already exists.";
    #[error]
    const NOT_FOUND_ID: vector<u8> = b"The product does not exist.";
    #[error]
    const PRODUCT_NOT_AVAIBLE: vector<u8> = b"You cannot subtract a product that is not available.";
    #[error]
    const LARGER_QUANTITY: vector<u8> = b"The quantity entered exceeds the quantity of product available";

    //Estructura de Tienda con vector map
    public struct Shop has key{
        id: UID,
        name: String,
        products: VecMap<u64, Product>,
    }

    //Estructura de producto
    public struct Product has store, drop{
        name: String,
        expiration: u64,
        amount: u16,
        available: bool,
    }

    //Crear Tienda
    public fun create_Shop(name: String, ctx: &mut TxContext) {
        let shop = Shop {
            id: object::new(ctx),
            name,
            products: vec_map::empty(),
        };

        transfer::transfer(shop, tx_context::sender(ctx));
    }

    //Agregar Producto
    public fun add_product(shop: &mut Shop, id: u64, name: String, expiration: u64, amount: u16) {
        assert!(!shop.products.contains(&id), EXISTING_ID);
        let product = Product{name, expiration, amount, available: true};
        shop.products.insert(id, product);
    }

    //Eliminar Producto
    public fun delete_product(shop: &mut Shop, id: u64) {
        assert!(shop.products.contains(&id), NOT_FOUND_ID);
        shop.products.remove(&id);
    }

    //Funcion para modificar la cantidad aumentada de los productos
    public fun increase_quantity(shop: &mut Shop, id: u64, increase: u16){
        assert!(shop.products.contains(&id), NOT_FOUND_ID);
        
        let product = shop.products.get_mut(&id);
        let current_amount = product.amount;
        product.amount = current_amount + increase;
    }

    //Funcion para modificar la cantidad y restar los productos
    public fun subtract_amount(shop: &mut Shop, id: u64, subtract: u16){
        assert!(shop.products.contains(&id), NOT_FOUND_ID);

        let product = shop.products.get_mut(&id);
        assert!(product.available, PRODUCT_NOT_AVAIBLE);
        assert!(product.amount >= subtract, LARGER_QUANTITY);
        product.amount = product.amount - subtract;
        if (product.amount == 0){
            product.available = false;
        }
    }
}