Write-Output "If an error occurs,it is fine."
Write-Output "modify script as prompted otherwise there is not usable vaultwarden-windows.tar.gz"
# build exe
Set-Location .\vaultwarden\
cargo build --features sqlite --release
Set-Location ..
Remove-Item .\release\ -Recurse -Force
mkdir release\vaultwarden-windows\data
Copy-Item .\vaultwarden\target\release\vaultwarden.exe .\release\vaultwarden-windows\
# unzip web-vault
tar -xzvf .\bw_web.tar.gz -C .\release\vaultwarden-windows\
# pack files
Set-Location release
tar -czvf ..\vaultwarden-windows.tar.gz *
Set-Location ..