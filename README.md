Renz Ben Jeryk Dy

# Library System

---

This API enables users to register, authenticate, and manage books and authors in a database. It supports essential CRUD operations for books and authors.  

---

## Features  
- **User Registration and Authentication**: Securely register and authenticate users to access the system.  
- **Insert new books and authors**: Add new books and their respective authors to the database.  
- **Update book titles and author names**: Modify existing book titles or author names in the database.  
- **Delete books and authors**: Remove unwanted books or authors from the system.  

---

### Getting Started  

---

# Endpoint Payloads

--- 

### REGISTER


Method: POST

Endpoint:dy_library/public/user/register

```
{
    "username": "admin",
    "password": "admin123"
}
```

___

### AUTHENTICATE


Method: POST

Endpoint:dy_library/public/user/authenticate

```
{
    "username": "jeryk",
    "password": "123"
}
```

___

### INSERT


Method: POST

Endpoint:dy_library/public/book-author/insert

```
{
    "bookTitle": "Sentinels",
    "authorName": "valorant"
}
```

___

### BOOK UPDATE


Method: PUT

dy_library/public/book/update

```
{
    "bookid": 1,
    "newTitle": "Wuthering Waves"
}
```

___

### AUTHOR UPDATE


Method: PUT

Endpoint:dy_library/public/author/update

```
{
    "authorid": 5,
    "newName": "KuroKuro"
}
```

___

### AUTHOR DELETE


Method: DELETE

Endpoint:dy_library/public/author/delete

```
{
    "authorid": 10
}
```

___

### BOOK DELETE


Method: DELETE

Endpoint:dy_library/public/book/delete

```
{
    "bookid": 6
}
```

 

