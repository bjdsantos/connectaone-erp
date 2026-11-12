# ConnectaOne ERP - T001
# Diagnostico SOMENTE LEITURA do computador de desenvolvimento (Windows).
# Nao instala, nao altera configuracoes e nao envia dados para a internet.
# Uso (PowerShell, sem precisar ser administrador):
#   powershell -ExecutionPolicy Bypass -File .\verificar-ambiente.ps1
# Resultado: arquivo connectaone-ambiente.txt na Area de Trabalho.

$ErrorActionPreference = 'SilentlyContinue'
$linhas = New-Object System.Collections.Generic.List[string]
function Add([string]$t) { $linhas.Add($t); Write-Host $t }
function Cmd([string]$nome) { return [bool](Get-Command $nome -ErrorAction SilentlyContinue) }
function Avalia([string]$item, [bool]$ok, [string]$detalhe) {
    $s = if ($ok) { 'OK      ' } else { 'ATENCAO ' }
    Add ("[{0}] {1}: {2}" -f $s, $item, $detalhe)
}

Add "ConnectaOne ERP - verificacao de ambiente (T001)"
Add ("Data: {0}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm'))
Add ""

# Sistema operacional
$os = Get-CimInstance Win32_OperatingSystem
$build = [int]$os.BuildNumber
$okBuild = ($build -ge 19045)
Avalia 'Windows' $okBuild ("{0} | versao {1} | build {2} | {3}" -f $os.Caption, $os.Version, $build, $os.OSArchitecture)

# Memoria
$ramGB = [math]::Round($os.TotalVisibleMemorySize / 1MB, 1)
$livreGB = [math]::Round($os.FreePhysicalMemory / 1MB, 1)
Avalia 'Memoria RAM' ($ramGB -ge 15) ("total {0} GB | livre agora {1} GB (minimo Docker: 8 GB; recomendado: 16 GB)" -f $ramGB, $livreGB)

# Processador e virtualizacao
$cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
$hv = (Get-CimInstance Win32_ComputerSystem).HypervisorPresent
$virt = $cpu.VirtualizationFirmwareEnabled
Add ("[INFO    ] Processador: {0} | {1} nucleos / {2} threads" -f $cpu.Name.Trim(), $cpu.NumberOfCores, $cpu.NumberOfLogicalProcessors)
Avalia 'Virtualizacao' ($hv -or $virt) ("habilitada no firmware: {0} | hypervisor ativo: {1}" -f $virt, $hv)

# Disco
Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" | ForEach-Object {
    $l = [math]::Round($_.FreeSpace / 1GB, 1); $t = [math]::Round($_.Size / 1GB, 1)
    Avalia ("Disco {0}" -f $_.DeviceID) ($l -ge 40) ("livre {0} GB de {1} GB (recomendado: 40 GB livres)" -f $l, $t)
}

# WSL
if (Cmd 'wsl') {
    $wv = (wsl.exe --version 2>$null | Out-String) -replace "`0", ''
    if ($wv.Trim()) {
        $linhaWsl = ($wv -split "`r?`n" | Where-Object { $_ -match '\d+\.\d+\.\d+' } | Select-Object -First 1)
        Avalia 'WSL' ([bool]$linhaWsl) ($(if ($linhaWsl) { $linhaWsl.Trim() } else { 'versao nao identificada (minimo 2.1.5)' }))
    } else { Avalia 'WSL' $false 'comando existe, mas o WSL 2 nao parece instalado/atualizado (minimo 2.1.5)' }
    # So lista distribuicoes se o WSL estiver instalado; sem ele, "wsl -l" abre um prompt de instalacao.
    $dist = if ($linhaWsl) { (wsl.exe -l -v 2>$null | Out-String) -replace "`0", '' } else { '' }
    if ($dist.Trim()) { Add "[INFO    ] Distribuicoes WSL:"; ($dist -split "`r?`n" | Where-Object { $_.Trim() }) | ForEach-Object { Add ("           {0}" -f $_) } }
} else { Avalia 'WSL' $false 'nao encontrado' }

# Docker
if (Cmd 'docker') {
    $dv = docker version --format '{{.Client.Version}} / servidor {{.Server.Version}}' 2>$null
    Avalia 'Docker' ([bool]$dv) ($(if ($dv) { $dv } else { 'instalado, mas o Docker Desktop nao esta em execucao' }))
    $dc = docker compose version --short 2>$null
    Avalia 'Docker Compose' ([bool]$dc) ($(if ($dc) { $dc } else { 'nao respondeu' }))
    $mem = docker info --format '{{.MemTotal}}' 2>$null
    if ($mem) { $m = [math]::Round([double]$mem / 1GB, 1); Avalia 'Memoria disponivel ao Docker' ($m -ge 7) ("{0} GB (recomendado: 8 GB ou mais)" -f $m) }
} else { Avalia 'Docker' $false 'nao instalado' }

# Ferramentas de desenvolvimento
if (Cmd 'git') { Avalia 'Git' $true ((git --version) -replace 'git version ', '') } else { Avalia 'Git' $false 'nao instalado' }
$cfgCrlf = git config --global core.autocrlf 2>$null
if (Cmd 'git') { Add ("[INFO    ] git core.autocrlf: {0}" -f $(if ($cfgCrlf) { $cfgCrlf } else { '(padrao)' })) }
if (Cmd 'code') { Avalia 'VS Code' $true ((code --version | Select-Object -First 1)) } else { Avalia 'VS Code' $false 'nao encontrado no PATH' }
if (Cmd 'code') {
    $ext = code --list-extensions 2>$null
    Avalia 'Extensao Dev Containers' ([bool]($ext -match 'ms-vscode-remote.remote-containers')) ($(if ($ext -match 'ms-vscode-remote.remote-containers') { 'instalada' } else { 'nao instalada' }))
}

# Portas usadas pelo piloto (somente localhost)
foreach ($p in 8000, 9000, 6787) {
    $uso = Get-NetTCPConnection -State Listen -LocalPort $p 2>$null
    Avalia ("Porta {0}" -f $p) (-not $uso) ($(if ($uso) { 'ja em uso por outro programa' } else { 'livre' }))
}

Add ""
Add "Fim. Nenhuma alteracao foi feita no computador."
$saida = Join-Path ([Environment]::GetFolderPath('Desktop')) 'connectaone-ambiente.txt'
$linhas | Out-File -FilePath $saida -Encoding utf8
Write-Host ""
Write-Host "Resultado salvo em: $saida"
