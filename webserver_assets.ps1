# PowerShell script to copy webserver assets to remote server via SSH
# This script copies everything from local webserver\assets to remote ~/monorepo/vinamed/webserver/assets

param(
    [string]$Username = "dngo",
    [string]$ServerIP = "192.168.0.4",
    [string]$RemotePath = "~/monorepo/vinamed/webserver/assets"
)

# Make sure you check the remote folder path before running the script
# This command will copy the assets directory to the specified remote path
scp -r webserver/assets "${Username}@${ServerIP}:${RemotePath}"