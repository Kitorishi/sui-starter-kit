//Comando para agregar una Tienda nueva

sui client call --package 0x07a7e9b34fe8b43cf30ad2fdf916fa94e2d8ea264868408fff884c69b2627e79 --module mi_proyecto --function create_Shop --args 

//Comando para agregar productos en una Tienda
sui client call --package 0x07a7e9b34fe8b43cf30ad2fdf916fa94e2d8ea264868408fff884c69b2627e79 --module mi_proyecto --function add_product --args [agregar id del objeto Tienda] [id del producto nuevo] [nombre del producto nuevo] [fecha de caducidad (meter como cantidad entera tipo 10102025] [cantidad a agregar]

//Comando para eliminar un producto
sui client call --package 0x07a7e9b34fe8b43cf30ad2fdf916fa94e2d8ea264868408fff884c69b2627e79 --module mi_proyecto --function delete_product --args [id del objeto Tienda] [id del objeto a liminar]

//Comando para aumentar cantidad de los productos
sui client call --package 0x07a7e9b34fe8b43cf30ad2fdf916fa94e2d8ea264868408fff884c69b2627e79 --module mi_proyecto --function increase_quantity --args [agregar id del objeto tienda] [id del producto a incrementar] [cantidad a aumentar]

//comando para restar cantidad de productos
sui client call --package 0x07a7e9b34fe8b43cf30ad2fdf916fa94e2d8ea264868408fff884c69b2627e79 --module mi_proyecto --function subtract_amount --args [agregar id del objeto tienda] [id del producto] [cantidad a restar]