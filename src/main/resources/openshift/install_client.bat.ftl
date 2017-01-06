<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->

IF EXIST "${container.ocHome}/oc.exe" (
    echo "OpenShift client already installed."
) ELSE (
    echo "Installing OpenShift client."
    ${container.wgetExecutable} --no-check-certificate -O oclient.zip ${container.ocUrl}
    ${container.wgetExecutable} --no-check-certificate -O 7zip.exe ${container.zipUrl}
    7zip.exe /S /D=C:\\Temp
    C:\Temp\7z.exe x oclient.zip -o${container.ocHome}
)
