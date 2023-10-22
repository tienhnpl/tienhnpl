<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PHP</title>
</head>
<body>
    <?php
    // $z=5;//static biến
//   function static_variable(){
//     static $x=10;
//     $y=20;
//     $x++;
//     $y++;
//     echo"Static: ".$x."<br>";
//     echo"Non-Static: ".$y."<br>";
//     echo"global: ".$z."<br>";
//   }
//   static_variable();
//   static_variable();
//   echo"$z";
$num=[21,22,23,24,25,26];
foreach($num as $value){
    echo"value is $value <br>";
}
$num[0]="one";
$num[1]="two";
$num[2]=30;
foreach($num as $value){
    echo"value is $value <br>";
}
    ?>
</body>
</html>