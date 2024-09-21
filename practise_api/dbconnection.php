<?php

function dbconnection()
{
    $con = mysqli_connect("localhost","root","","practise");
    return $con;    

}

?>
