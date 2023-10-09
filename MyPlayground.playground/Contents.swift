import Foundation

//                   -- 1 --
//                   Library

class Book {
    static var lastBookID: Int = 1000
    let bookID: Int
    var title: String
    var author: String
    var isBorrowed: Bool

    init(title: String, author: String) {
        Book.lastBookID += 1
        self.bookID = Book.lastBookID
        self.title = title
        self.author = author
        self.isBorrowed = false
    }
    
    func markAsBorrowed(){
        isBorrowed = true
    }
    
    func markAsReturned(){
        isBorrowed = false
    }
    
}

class Owner {
    static var lastOwnerID: Int = 100
    let ownerID: Int
    var name: String
    var borrowedBooks: [Book]
    
    init(name: String) {
        Owner.lastOwnerID += 1
        self.ownerID = Owner.lastOwnerID
        self.name = name
        self.borrowedBooks = []
    }
    
    func borrowBook(_ book: Book) {
        if book.isBorrowed == false {
            borrowedBooks.append(book)
            book.markAsBorrowed()
        } else {
            print("The book \(book.title) by \(book.author) (\(book.bookID)) is already borrowed")
        }
    }
    
    func returnBook(_ book: Book) {
        if borrowedBooks.contains(where: { $0.bookID == book.bookID }){
            borrowedBooks.removeAll { $0.bookID == book.bookID }
            book.markAsReturned()
        }
    }
    
    func listBorrowed() {
            print("\(name)'s list of borrowed books:")
        for book in borrowedBooks {
            print("\(book.title) by \(book.author) (\(book.bookID))")
        }
    }
    
}

class Library {
    var booksArray: [Book]
    var ownersArray: [Owner]
    
    init() {
        self.booksArray = []
        self.ownersArray = []
    }
    
    func addBooks(_ book: Book){
        booksArray.append(book)
    }
    
    func addOwner(_ owner: Owner){
        ownersArray.append(owner)
    }
    
    func findAvailable() -> [Book] {
        print("Available books:")
        return booksArray.filter { !$0.isBorrowed }
    }
    
    func findBorrowed() -> [Book] {
        print("Borrowed books: ")
        return booksArray.filter { $0.isBorrowed }
    }
    
    func findOwner(_ ownerID: Int) {
        for i in ownersArray{
            if i.ownerID == ownerID {
                print("Found owner: \(i.name) with owner ID: \(ownerID)")
            } 
        }
        
    }
    
    func ownerBorrowedList(_ owner: Owner) {
        owner.listBorrowed()
    }
    
    func allowOwnerBorrowBook(_ owner: Owner, book: Book) {
        if book.isBorrowed == false {
            owner.borrowBook(book)
        } else {
            print(" You can't borrow the book \(book.title) by \(book.author) (\(book.bookID)). It's already borrowed. ")
        }
    }
    
}


let book1 = Book(title: "Berserk", author: "Kentaro Miura")
let book2 = Book(title: "Madame Bovary", author: "Gustave Flaubert")
let book3 = Book(title: "Nineteen Eighty-Four (1984)", author: "George Orwell")
let book4 = Book(title: "The Power of Geography", author: "Tim Marshall")
let book5 = Book(title: "Jujutsu Kaisen", author: "Gege Akutami")

let owner1 = Owner(name: "Guts")
let owner2 = Owner(name: "Roronoa zoro")
let owner3 = Owner(name: "Escanor")

let library = Library()

library.addBooks(book1)
library.addBooks(book2)
library.addBooks(book3)
library.addBooks(book4)
library.addBooks(book5)
print()
library.addOwner(owner1)
library.addOwner(owner2)
library.addOwner(owner3)
print()
owner1.borrowBook(book2)
owner1.borrowBook(book5)
owner2.borrowBook(book4)
owner3.borrowBook(book1)
owner3.borrowBook(book3)
print()
//If you know you know -> read following output
owner2.listBorrowed()

owner1.returnBook(book2)
owner3.returnBook(book3)
print()

let borrowedBooks = library.findBorrowed()
for book in borrowedBooks {
    print("\(book.title) by \(book.author) (\(book.bookID))")
}

print()

let availableBooks = library.findAvailable()
for book in availableBooks {
    print("\(book.title) by \(book.author) (\(book.bookID))")
}

print()

library.ownerBorrowedList(owner1)

print("\n")












//                   -- 2 --
//                  E-commerce

class Product {
    static var lastProductID = 10001
    var productID: Int
    var name: String
    var price: Double
    init(name: String, price: Double) {
        Product.lastProductID += 1
        self.productID = Product.lastProductID
        self.name = name
        self.price = price
    }
}

class Cart {
    static var lastCartID = 100
    var cartID: Int
    var items: [Product]
    init() {
        Cart.lastCartID += 1
        self.cartID = Cart.lastCartID
        self.items = []
    }
    
    func addToCart(_ product: Product) {
        items.append(product)
    }
    
    func removeFromCart(_ productID: Product) {
        items.removeAll { $0.productID == productID.productID }
    }
    
    func calculatePrice() -> Double {
        items.reduce(0) { $0 + $1.price }
    }
}

class User {
    static var lastUserId = 10001
    var userID: Int
    var userName: String
    var cart: Cart
    init(_ userName: String) {
        User.lastUserId += 1
        self.userID = User.lastUserId
        self.userName = userName
        self.cart = Cart()
    }
    
    func addProduct(_ product: Product) {
        cart.addToCart(product)
    }
    
    func removeProduct(_ productID: Product) {
        cart.removeFromCart(productID)
    }
    
    func checkout() {
        let totalPrice = cart.calculatePrice()
        print("Total price is: $\(totalPrice)")
        cart.items.removeAll()
    }
    
}

let product1 = Product(name: "Porsche 911", price: 110_768)
let product2 = Product(name: "Ferrari Enzo", price: 1_000_000_000)
let product3 = Product(name: "Joe Jackson's Baseball bat", price: 577_610)
let product4 = Product(name: "MARILYN MONROE’S “SUBWAY DRESS", price: 5_500_000)
let product5 = Product(name: "Marie Antoinette's Pendant", price: 36_000_000)
let product6 = Product(name: "Oppenheimer blue diamond", price: 57_600_000)

let user1 = User("Nami")
let user2 = User("Ban")

user1.addProduct(product2)
user1.addProduct(product6)
user1.addProduct(product5)
user1.addProduct(product4)
user2.addProduct(product1)
user2.addProduct(product3)

//აქ ზუსტად ვერ მივხვდი ყველას ჯამი გვჭირდება თუ სათითაოს ფასი ამიტომ ორივეს დავწერ:
print("Prices of items in \(user1.userName)'s cart:")
for item in user1.cart.items {
    print("\(item.name) (\(item.productID)): $\(item.price)")
}

print("\(user1.userName)'s items total price is: $ \(user1.cart.calculatePrice())")


print()

print("Prices of items in \(user2.userName)'s cart:")
for item in user2.cart.items {
    print("\(item.name) (\(item.productID)): $\(item.price)")
}
print("\(user2.userName)'s items total price is: $ \(user2.cart.calculatePrice())")

print()

user1.checkout()

user2.checkout()


