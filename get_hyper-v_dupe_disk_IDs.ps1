# Import Hyper-V PowerShell module
Import-Module Hyper-V

# Get a list of all virtual machines
$VMs = Get-VM

# Loop through each virtual machine
foreach ($VM in $VMs) {

    # Get a list of all virtual hard disks attached to the virtual machine
    $VHDs = Get-VMHardDiskDrive -VMName $VM.Name

    # Create an array to hold the names of the virtual hard disks
    $VHDNames = @()

    # Loop through each virtual hard disk and add its name to the array
    foreach ($VHD in $VHDs) {
        $VHDNames += $VHD.Path
    }

    # Check for duplicate virtual hard disks by comparing the number of items in the array to the number of unique items in the array
    if ($VHDNames.Count -ne ($VHDNames | Select-Object -Unique).Count) {
        Write-Host "Duplicate virtual hard disks found on VM $($VM.Name)"
    }
}
