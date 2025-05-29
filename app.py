from flask import Flask, send_from_directory, jsonify
import subprocess

app = Flask(__name__, static_folder='site', template_folder='site')

@app.route('/')
def index():
    return send_from_directory('site', 'index.html')

@app.route('/<path:path>')
def static_files(path):
    return send_from_directory('site', path)

@app.route('/executar')
def executar():
    ps1 = r"D:\simulacao.ps1"  # Caminho para o script de simulação

    # Executar o script PowerShell em uma nova aba do terminal
    subprocess.Popen([
        "start", "powershell", "-NoExit", "-ExecutionPolicy", "Bypass", "-File", ps1
    ], shell=True)

    return jsonify({"status": "simulação iniciada"})

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5000)
