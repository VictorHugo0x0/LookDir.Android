# 📂 LookDir.Android

**LookDir** é um scanner de diretórios rápido e leve para aplicações web, desenvolvido com Flutter para Android. Ideal para bug bounty hunters, pentesters e profissionais de segurança que desejam mapear estruturas ocultas de diretórios em aplicações web diretamente do celular.

---

## 📱 Sobre o Projeto

🔎 LookDir permite que você escaneie e descubra diretórios ocultos e sensíveis em servidores web, facilitando a coleta de informações durante avaliações de segurança ofensiva.

### Principais Features:
- 🔥 Scanner rápido com execução assíncrona
- 📁 Suporte a wordlists customizadas
- 🌐 Configuração de cabeçalhos HTTP e User-Agent
- 📊 Resultados organizados e filtráveis
- 📲 Interface responsiva e mobile-friendly (Flutter)

---

## 🛠️ Tecnologias Utilizadas

- **Flutter** (Dart)
- **Dart:io** (para requisições e leitura de arquivos locais)
- **Isolates/Futures** (execução paralela)
- **Provider / Bloc** (gerenciamento de estado, opcional)
- **Material Design**

---

## 🚀 Instalação

### ✅ Requisitos
- Flutter instalado: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
- Emulador Android ou dispositivo físico
- Wordlist `.txt` com diretórios

### 📦 Clonando o Repositório
```bash
git clone https://github.com/SEU_USUARIO/LookDir.Android.git
cd LookDir.Android
