FROM microsoft/windowsservercore:ltsc2016

LABEL maintainer="Uilian Ries <uilianries@gmail.com>"

SHELL ["powershell.exe", "-ExecutionPolicy", "Bypass", "-Command"]

ENV chocolateyUseWindowsCompression=false \
    PYTHONIOENCODING=UTF-8

RUN iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')); \
    choco install --no-progress --yes git --version=2.19.0 --params '"/InstallDir:C:\tools\git"'; \
    choco install --no-progress --yes svn --version=1.8.17 --params '"/InstallDir:C:\tools\svn"'; \
    choco install --no-progress --yes cmake --version=3.12.2 --params '"/InstallDir:C:\tools\cmake"' --installargs 'ADD_CMAKE_TO_PATH=""System""'; \
    choco install --no-progress --yes python3 --version=3.7.0 --params '"/InstallDir:C:\tools\python3"'; \
    choco install --no-progress --yes visualstudio2017buildtools --version=15.8.2.0; \
    choco install --no-progress --yes visualstudio2017-workload-vctools --version=1.3.0; \
    choco install --no-progress --yes visualstudio2017-workload-manageddesktop --version=1.2.0; \
    RefreshEnv; \
    python -m pip install --upgrade pip; \
    pip install win-unicode-console --upgrade --force-reinstall --no-cache; \
    pip install conan --upgrade --force-reinstall --no-cache; \
    pip install conan_package_tools --upgrade --force-reinstall --no-cache; \
    pip install idna --upgrade --force-reinstall --no-cache

WORKDIR "C:/Users/ContainerAdministrator"
ENTRYPOINT ["cmd.exe", "C:\\Program Files (x86)\\Microsoft Visual C++ Build Tools\\vcbuildtools_msbuild.bat"]
