<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

require '../src/vendor/autoload.php';
$app = new \Slim\App;

$servername = "localhost";
$dbusername = "root";
$dbpassword = "";
$dbname = "dy-library";

function generateToken($userid) {
    $key = 'server_hack';
    $iat = time();
    $payload = [
        'iss' => 'http://library.org',
        'aud' => 'http://library.com',
        'iat' => $iat,
        'exp' => $iat + 3600,
        "data" => array("userid" => $userid)
    ];

    return JWT::encode($payload, $key, 'HS256');
}

$app->post('/user/register', function (Request $request, Response $response) use ($servername, $dbusername, $dbpassword, $dbname) {
    $data = json_decode($request->getBody());
    $usr = $data->username;
    $pass = $data->password;

    try {
        $conn = new PDO("mysql:host=$servername;dbname=$dbname", $dbusername, $dbpassword);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $sql = "INSERT INTO users (username, password) VALUES (:usr, :pass)";
        $stmt = $conn->prepare($sql);
        $stmt->execute(['usr' => $usr, 'pass' => password_hash($pass, PASSWORD_DEFAULT)]);
        
        $response->getBody()->write(json_encode(["status" => "success", "data" => null]));
    } catch (PDOException $e) {
        $response->getBody()->write(json_encode(["status" => "fail", "data" => ["title" => $e->getMessage()]]));
    }
    $conn = null;

    return $response;
});

$app->post('/user/authenticate', function (Request $request, Response $response) use ($servername, $dbusername, $dbpassword, $dbname) {
    $data = json_decode($request->getBody());
    $usr = $data->username;
    $pass = $data->password;

    try {
        $conn = new PDO("mysql:host=$servername;dbname=$dbname", $dbusername, $dbpassword);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $sql = "SELECT * FROM users WHERE username=:usr";
        $stmt = $conn->prepare($sql);
        $stmt->execute(['usr' => $usr]);
        $stmt->setFetchMode(PDO::FETCH_ASSOC);
        $data = $stmt->fetch();

        if ($data && password_verify($pass, $data['password'])) {
            $userid = $data['userid'];
            $jwt = generateToken($userid);
            $sqlToken = "INSERT INTO user_tokens (userid, token) VALUES (:userid, :token)";
            $stmtToken = $conn->prepare($sqlToken);
            $stmtToken->execute(['userid' => $userid, 'token' => $jwt]);
            
            $response->getBody()->write(json_encode(["status" => "success", "token" => $jwt, "data" => null]));
        } else {
            $response->getBody()->write(json_encode(["status" => "fail", "data" => ["title" => "Authentication Failed"]]));
        }
    } catch (PDOException $e) {
        $response->getBody()->write(json_encode(["status" => "fail", "data" => ["title" => $e->getMessage()]]));
    }

    return $response;
});

$app->post('/book-author/insert', function (Request $request, Response $response) use ($servername, $dbusername, $dbpassword, $dbname) {
    $data = json_decode($request->getBody());
    $bookTitle = $data->bookTitle;
    $authorName = $data->authorName;
    $token = str_replace('Bearer ', '', $request->getHeader('Authorization')[0] ?? '');

    try {
        $conn = new PDO("mysql:host=$servername;dbname=$dbname", $dbusername, $dbpassword);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $sqlCheckToken = "SELECT userid FROM user_tokens WHERE token = :token";
        $stmtCheckToken = $conn->prepare($sqlCheckToken);
        $stmtCheckToken->execute(['token' => $token]);

        if ($stmtCheckToken->rowCount() === 0) {
            return $response->withStatus(401)->write(json_encode(["status" => "fail", "data" => ["title" => "Token is invalid or has been revoked."]]));
        }

        $decoded = JWT::decode($token, new Key('server_hack', 'HS256'));
        $userid = $decoded->data->userid;

        $sqlBook = "INSERT INTO books (title) VALUES (:title)";
        $stmtBook = $conn->prepare($sqlBook);
        $stmtBook->execute(['title' => $bookTitle]);

        $sqlAuthor = "INSERT INTO authors (name) VALUES (:name)";
        $stmtAuthor = $conn->prepare($sqlAuthor);
        $stmtAuthor->execute(['name' => $authorName]);

        $sqlDeleteToken = "DELETE FROM user_tokens WHERE userid = :userid AND token = :token";
        $stmtDeleteToken = $conn->prepare($sqlDeleteToken);
        $stmtDeleteToken->execute(['userid' => $userid, 'token' => $token]);

        $newToken = generateToken($userid);
        $sqlInsertNewToken = "INSERT INTO user_tokens (userid, token) VALUES (:userid, :token)";
        $stmtInsertNewToken = $conn->prepare($sqlInsertNewToken);
        $stmtInsertNewToken->execute(['userid' => $userid, 'token' => $newToken]);

        $response->getBody()->write(json_encode(["status" => "success", "newToken" => $newToken]));
    } catch (Exception $e) {
        $response->getBody()->write(json_encode(["status" => "fail", "data" => ["title" => $e->getMessage()]]));
    }

    return $response;
});

$app->put('/book/update', function (Request $request, Response $response) use ($servername, $dbusername, $dbpassword, $dbname) {
    $data = json_decode($request->getBody());
    $id = $data->bookid;
    $newTitle = $data->newTitle;
    $token = str_replace('Bearer ', '', $request->getHeader('Authorization')[0] ?? '');

    try {
        $conn = new PDO("mysql:host=$servername;dbname=$dbname", $dbusername, $dbpassword);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $sqlCheckToken = "SELECT userid FROM user_tokens WHERE token = :token";
        $stmtCheckToken = $conn->prepare($sqlCheckToken);
        $stmtCheckToken->execute(['token' => $token]);

        if ($stmtCheckToken->rowCount() === 0) {
            return $response->withStatus(401)->write(json_encode(["status" => "fail", "data" => ["title" => "Token is invalid or has been revoked."]]));
        }

        $userid = $stmtCheckToken->fetch()['userid'];

        $sqlUpdate = "UPDATE books SET title = :newTitle WHERE bookid = :id";
        $stmtUpdate = $conn->prepare($sqlUpdate);
        $stmtUpdate->execute(['newTitle' => $newTitle, 'id' => $id]);

        $newToken = generateToken($userid);
        $sqlInsertNewToken = "INSERT INTO user_tokens (userid, token) VALUES (:userid, :token)";
        $stmtInsertNewToken = $conn->prepare($sqlInsertNewToken);
        $stmtInsertNewToken->execute(['userid' => $userid, 'token' => $newToken]);

        $response->getBody()->write(json_encode(["status" => "success", "newToken" => $newToken, "data" => "Book update successful"]));
    } catch (Exception $e) {
        $response->getBody()->write(json_encode(["status" => "fail", "data" => ["title" => $e->getMessage()]]));
    }

    return $response;
});

$app->put('/author/update', function (Request $request, Response $response) use ($servername, $dbusername, $dbpassword, $dbname) {
    $data = json_decode($request->getBody());
    $authorid = $data->authorid;
    $newName = $data->newName;
    $token = str_replace('Bearer ', '', $request->getHeader('Authorization')[0] ?? '');

    try {
        $conn = new PDO("mysql:host=$servername;dbname=$dbname", $dbusername, $dbpassword);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $sqlCheckToken = "SELECT userid FROM user_tokens WHERE token = :token";
        $stmtCheckToken = $conn->prepare($sqlCheckToken);
        $stmtCheckToken->execute(['token' => $token]);

        if ($stmtCheckToken->rowCount() === 0) {
            return $response->withStatus(401)->write(json_encode(["status" => "fail", "data" => ["title" => "Token is invalid or has been revoked."]]));
        }

        $userid = $stmtCheckToken->fetch()['userid'];

        $sqlUpdate = "UPDATE authors SET name = :newName WHERE authorid = :authorid";
        $stmtUpdate = $conn->prepare($sqlUpdate);
        $stmtUpdate->execute(['newName' => $newName, 'authorid' => $authorid]);

        $newToken = generateToken($userid);
        $sqlInsertNewToken = "INSERT INTO user_tokens (userid, token) VALUES (:userid, :token)";
        $stmtInsertNewToken = $conn->prepare($sqlInsertNewToken);
        $stmtInsertNewToken->execute(['userid' => $userid, 'token' => $newToken]);

        $response->getBody()->write(json_encode(["status" => "success", "newToken" => $newToken, "data" => "Author update successful"]));
    } catch (Exception $e) {
        $response->getBody()->write(json_encode(["status" => "fail", "data" => ["title" => $e->getMessage()]]));
    }

    return $response;
});

$app->delete('/book/delete', function (Request $request, Response $response) use ($servername, $dbusername, $dbpassword, $dbname) {
    $data = json_decode($request->getBody());
    $id = $data->bookid;
    $token = str_replace('Bearer ', '', $request->getHeader('Authorization')[0] ?? '');

    try {
        $conn = new PDO("mysql:host=$servername;dbname=$dbname", $dbusername, $dbpassword);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $sqlCheckToken = "SELECT userid FROM user_tokens WHERE token = :token";
        $stmtCheckToken = $conn->prepare($sqlCheckToken);
        $stmtCheckToken->execute(['token' => $token]);

        if ($stmtCheckToken->rowCount() === 0) {
            return $response->withStatus(401)->write(json_encode(["status" => "fail", "data" => ["title" => "Token is invalid or has been revoked."]]));
        }

        $userid = $stmtCheckToken->fetch()['userid'];

        $sqlDelete = "DELETE FROM books WHERE bookid = :id";
        $stmtDelete = $conn->prepare($sqlDelete);
        $stmtDelete->execute(['id' => $id]);

        $newToken = generateToken($userid);
        $sqlInsertNewToken = "INSERT INTO user_tokens (userid, token) VALUES (:userid, :token)";
        $stmtInsertNewToken = $conn->prepare($sqlInsertNewToken);
        $stmtInsertNewToken->execute(['userid' => $userid, 'token' => $newToken]);

        $response->getBody()->write(json_encode(["status" => "success", "newToken" => $newToken, "data" => "Book delete successful"]));
    } catch (Exception $e) {
        $response->getBody()->write(json_encode(["status" => "fail", "data" => ["title" => $e->getMessage()]]));
    }

    return $response;
});

$app->delete('/author/delete', function (Request $request, Response $response) use ($servername, $dbusername, $dbpassword, $dbname) {
    $data = json_decode($request->getBody());
    $id = $data->authorid;
    $token = str_replace('Bearer ', '', $request->getHeader('Authorization')[0] ?? '');

    try {
        $conn = new PDO("mysql:host=$servername;dbname=$dbname", $dbusername, $dbpassword);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $sqlCheckToken = "SELECT userid FROM user_tokens WHERE token = :token";
        $stmtCheckToken = $conn->prepare($sqlCheckToken);
        $stmtCheckToken->execute(['token' => $token]);

        if ($stmtCheckToken->rowCount() === 0) {
            return $response->withStatus(401)->write(json_encode(["status" => "fail", "data" => ["title" => "Token is invalid or has been revoked."]]));
        }

        $userid = $stmtCheckToken->fetch()['userid'];

        $sqlDelete = "DELETE FROM authors WHERE authorid = :id";
        $stmtDelete = $conn->prepare($sqlDelete);
        $stmtDelete->execute(['id' => $id]);

        $newToken = generateToken($userid);
        $sqlInsertNewToken = "INSERT INTO user_tokens (userid, token) VALUES (:userid, :token)";
        $stmtInsertNewToken = $conn->prepare($sqlInsertNewToken);
        $stmtInsertNewToken->execute(['userid' => $userid, 'token' => $newToken]);

        $response->getBody()->write(json_encode(["status" => "success", "newToken" => $newToken, "data" => "Author delete successful"]));
    } catch (Exception $e) {
        $response->getBody()->write(json_encode(["status" => "fail", "data" => ["title" => $e->getMessage()]]));
    }

    return $response;
});

$app->run();
