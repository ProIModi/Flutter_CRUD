<?php
include("dbconnection.php");
$con = dbconnection();

if(isset($_POST["id"]))
{
    $id = $_POST["id"];
}
else return;

$query = "DELETE FROM `user_tbl` WHERE uid='$id'";
$exe=mysqli_query($con,$query);
$arr=[];
if($exe)
{
    $arr["success"] = "true";
    $arr["message"] = "DB Connected..,Do you really want to delete ..?";
}
else
{
    $arr["success"] = "false";
    $arr["message"] = "DB Not Connected..";
}
// while($row=mysqli_fetch_array($exe))
// {
//     $arr[]=$row;
    
// }
print(json_encode($arr));
?>