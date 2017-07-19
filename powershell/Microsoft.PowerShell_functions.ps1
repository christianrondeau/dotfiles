echo "fonctions!"
function which($name)
{
    Get-Command $name | Select-Object -ExpandProperty Definition
}
