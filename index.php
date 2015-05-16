$dbopts = parse_url(getenv('DATABASE_URL'));
$app->register(new Herrera\Pdo\PdoServiceProvider(),
  array(
    'pdo.dsn' => 'pgsql:dbname='.ltrim($dbopts["path"],'/').';host='.$dbopts["host"],
    'pdo.port' => $dbopts["port"],
    'pdo.username' => $dbopts["user"],
    'pdo.password' => $dbopts["pass"]
  )
);

<!DOCTYPE html>
<html>
<head>
<img src="Southern.png" style="Position:Absolute; left:30%; top:12%" >
<link href="pag(2)_estilos.css" rel="stylesheet" type="text/css" media="screen" />
<title>Login</title>
</head> 
<body>
<table cellspacing="0" cellpadding="0" style="Position:Absolute; left:45%; top:30%">
<tr>
<th align="center">Ingrese usuario y Clave </th>
</tr>
<tr>
<td>
<strong>Usuario:</strong><br>
<input type="text"  name="Usuario"/>
<br>
<strong>Clave:</strong><br>
<input name="Clave" type="password"/>
<br><br>
<button type="button">Ingresar</button>
</td>
</tr>
</table>
</body>
</html>