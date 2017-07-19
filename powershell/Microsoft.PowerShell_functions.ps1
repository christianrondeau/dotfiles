function which($name)
{
    Get-Command $name | Select-Object -ExpandProperty Definition
}
