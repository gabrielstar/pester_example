function B(){
    return "I am B"
}
function A(){
    $b=B
    return "I am A and $b"
}
Export-ModuleMember -function A