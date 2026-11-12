# T001 — Validação do piloto local (ERPNext)

Data do levantamento: 12/11/2026.

## Resumo

- **Base proposta: ERPNext v16 (Frappe Framework v16)**, em ambiente de desenvolvimento com Docker usando o repositório oficial `frappe/frappe_docker` (modo *devcontainer*).
- **Decisão técnica: aprovada com condição.** Os requisitos oficiais são compatíveis com um computador Windows 10/11 64 bits com WSL 2, Docker Desktop e 16 GB de RAM. Falta confirmar os números reais do computador do Bruno (seção 4). Nenhum impedimento concreto foi encontrado até aqui, então a comparação com Dolibarr não foi acionada.
- **Extensões próprias: suportadas nativamente.** O Frappe trabalha com *apps* separados (`bench new-app`), que adicionam DocTypes, campos, scripts, permissões e relatórios sem alterar o núcleo do ERPNext.
- **Nada foi instalado no computador do Bruno nesta tarefa.** Veja a seção 7 sobre onde cada verificação foi feita.

## 1. Versões selecionadas (fixas)

| Componente | Versão | Origem / evidência |
|---|---|---|
| ERPNext | `v16.55.0` (branch `version-16`, commit `8e10a348`) | `git ls-remote` em github.com/frappe/erpnext, 12/11/2026 |
| Frappe Framework | `v16.56.0` (branch `version-16`, commit `49789a17`) | `frappe/__init__.py` da branch `version-16` |
| Compatibilidade | ERPNext v16.55.0 exige `frappe >=16.55.0,<17` | `pyproject.toml` do ERPNext |
| Python | 3.14 (Frappe exige `>=3.14,<3.15`) | `pyproject.toml` do Frappe e Dockerfile `images/bench` |
| Node.js | 24 ou superior | `package.json` do Frappe (`engines.node >=24`) |
| Banco de dados | MariaDB 11.8 | `devcontainer-example/docker-compose.yml` |
| Cache e filas | Redis (imagem `redis:alpine`) | mesmo arquivo |
| frappe_docker | commit `85ad653` (12/11/2026) | clone do repositório oficial |
| Licença ERPNext | GNU GPL v3 | `license.txt` do ERPNext |
| Licença Frappe | MIT | `pyproject.toml` do Frappe |

Regra: Frappe e ERPNext devem estar sempre na mesma linha de versão (`version-16`). Após a instalação (T002), registrar a saída de `bench version` neste documento para travar os commits exatos usados.

## 2. Requisitos oficiais

**Docker Desktop no Windows (backend WSL 2, x86_64)**, conforme docs.docker.com:

- Windows 10 64 bits versão 22H2 (build 19045) ou Windows 11 64 bits 23H2 (build 22631) ou superior.
- WSL versão 2.1.5 ou superior.
- 8 GB de RAM no sistema (mínimo).
- Virtualização de hardware habilitada na BIOS/UEFI.
- Licença: uso gratuito para empresas com até 250 funcionários **e** até US$ 10 milhões de faturamento anual. Acima disso exige assinatura paga. A ConnectaOne se enquadra no uso gratuito; Bruno deve confirmar, e o computador não deve ser de uso corporativo de outra empresa que exija licença.

**frappe_docker (modo desenvolvimento):**

- Docker, Docker Compose e Git.
- Pelo menos 4 GB de RAM reservados ao Docker (documentação oficial). Relatos da comunidade para v16 indicam 8 GB para evitar erro 137 (falta de memória) no `bench build`.
- VS Code com a extensão Dev Containers.
- No Windows, usar o terminal Git Bash para os comandos de clone/cópia e manter os scripts com fim de linha LF.

**Recomendação para o piloto:** 16 GB de RAM no computador, 8 GB reservados ao Docker e pelo menos 40 GB livres em disco.

## 3. Arquitetura do ambiente local

```
Windows
└── Docker Desktop (WSL 2)
    ├── mariadb        (MariaDB 11.8, volume persistente mariadb-data)
    ├── redis-cache
    ├── redis-queue
    └── frappe         (imagem frappe/bench, Python 3.14 e Node 24)
        └── /workspace/development/frappe-bench
            ├── apps/frappe          (núcleo, não alterar)
            ├── apps/erpnext         (núcleo, não alterar)
            └── apps/connectaone     (extensão própria, criada no T002)
```

- Acesso somente em `http://development.localhost:8000` (portas encaminhadas pelo VS Code para `localhost`). MariaDB e Redis não expõem portas no Windows.
- Proibido nesta fase: túneis (ngrok, Cloudflare Tunnel etc.), abrir portas no roteador e mapear portas para `0.0.0.0`.
- As senhas padrão do ambiente de desenvolvimento (`123` do MariaDB e `admin` do Administrator) servem apenas para uso local. Nunca reutilizar em VPS ou produção.

## 4. Situação do computador de desenvolvimento

| Item | Resultado | Como foi verificado |
|---|---|---|
| Sistema operacional | Windows, 64 bits (x64) | Leitura remota pelo app Claude Desktop |
| Docker | Provavelmente **não instalado** (não existe a pasta `.docker` no perfil do usuário) | Lista de pastas do perfil. Indício, não confirmação |
| Versão e build do Windows | **Pendente** | Rodar `scripts/windows/verificar-ambiente.ps1` |
| RAM, disco livre, virtualização | **Pendente** | idem |
| WSL 2, Git, VS Code | **Pendente** | idem |

### Como verificar (somente leitura, não instala nada)

1. Baixe `scripts/windows/verificar-ambiente.ps1` desta branch.
2. Clique com o botão direito no menu Iniciar > **Terminal** (ou **Windows PowerShell**).
3. Rode, ajustando a pasta onde salvou o arquivo:

   ```powershell
   cd $HOME\Downloads
   powershell -ExecutionPolicy Bypass -File .\verificar-ambiente.ps1
   ```

4. O resultado fica em `connectaone-ambiente.txt` na Área de Trabalho. Cole o conteúdo na revisão do PR (não contém senhas).

Critério para seguir: todas as linhas `OK`, ou `ATENCAO` apenas em itens que serão instalados no roteiro (Docker, WSL, Git, VS Code, Dev Containers). Se a RAM for menor que 16 GB ou a virtualização não puder ser habilitada, registrar aqui e reavaliar (seção 6).

## 5. Roteiro local reproduzível

> Executar somente depois da verificação da seção 4. Os passos 1 e 2 instalam programas no Windows e precisam da autorização do Bruno.

**Passo 1. Pré-requisitos do Windows**

```powershell
# PowerShell como administrador
wsl --install          # instala/atualiza o WSL 2 (pode pedir reinício)
wsl --update
wsl --version          # confirmar 2.1.5 ou superior
```

Instalar, pelos sites oficiais: Docker Desktop (marcar "Use WSL 2"), Git for Windows e Visual Studio Code. Depois:

- Docker Desktop > Settings > Resources: garantir pelo menos 8 GB de memória para o Docker. No backend WSL 2, o limite é definido no arquivo `%UserProfile%\.wslconfig`:

  ```ini
  [wsl2]
  memory=8GB
  ```

- VS Code > Extensões (Ctrl+Shift+X) > instalar **Dev Containers** (`ms-vscode-remote.remote-containers`).

**Passo 2. Preparar o frappe_docker (Git Bash)**

```bash
git config --global core.autocrlf input
mkdir -p ~/dev && cd ~/dev
git clone https://github.com/frappe/frappe_docker.git
cd frappe_docker
git checkout 85ad653360e4670c2e885c4283d293e7b9efeda9   # versão validada no T001
cp -R devcontainer-example .devcontainer
cp -R development/vscode-example development/.vscode
code .
```

No VS Code: Ctrl+Shift+P > **Dev Containers: Reopen in Container**. A primeira abertura baixa as imagens e demora.

**Passo 3. Criar bench e site (terminal do VS Code, dentro do container, usuário `frappe`)**

```bash
cd /workspace/development
bench init --skip-redis-config-generation --frappe-branch version-16 frappe-bench
cd frappe-bench
bench set-config -g db_host mariadb
bench set-config -g redis_cache redis://redis-cache:6379
bench set-config -g redis_queue redis://redis-queue:6379
bench set-config -g redis_socketio redis://redis-queue:6379
bench set-config -g chromium_path /usr/lib/chromium/chromium-headless-shell
bench new-site --db-root-password 123 --admin-password admin \
  --mariadb-user-host-login-scope=% development.localhost
bench --site development.localhost set-config developer_mode 1
bench get-app --branch version-16 erpnext
bench --site development.localhost install-app erpnext
bench --site development.localhost clear-cache
bench version          # registrar a saída neste documento
bench start
```

Abrir `http://development.localhost:8000` e entrar com `Administrator`.

Alternativa automatizada oficial: `python installer.py` (dentro de `/workspace/development`), que usa `apps-example.json` com ERPNext `version-16`.

**Passo 4. Validar suporte a extensão própria (prova mínima)**

```bash
bench new-app connectaone            # app próprio, licença a definir por Bruno
bench --site development.localhost install-app connectaone
bench --site development.localhost list-apps   # deve listar frappe, erpnext, connectaone
```

O código de `apps/connectaone` deve ser versionado neste repositório (ou em repositório próprio) no T002. Nada dentro de `apps/frappe` ou `apps/erpnext` deve ser alterado.

**Passo 5. Parar, iniciar e persistência**

- Parar: Ctrl+C no `bench start` e fechar o VS Code (o container para junto, `shutdownAction: stopCompose`).
- Iniciar: abrir a pasta `frappe_docker` no VS Code > Reopen in Container > `cd frappe-bench && bench start`.
- O banco fica no volume Docker `mariadb-data` e o código em `frappe_docker/development` (pasta ignorada pelo Git do frappe_docker). Backup e restauração serão documentados e testados no T002.

## 6. Riscos e limitações

- **Requisitos do computador ainda não confirmados.** A decisão final depende do resultado da seção 4.
- **Windows exige cuidado com fim de linha.** Usar `core.autocrlf input` e Git Bash para evitar scripts com CRLF quebrando containers.
- **Imagem `frappe/bench:latest` não é fixa.** O frappe_docker oficial usa a tag `latest`. Fixar por digest no T002, depois da primeira instalação que funcionar.
- **Desempenho:** arquivos montados do Windows no container são mais lentos. Se o `bench build` ficar lento demais, clonar o frappe_docker dentro do WSL (`\\wsl$\Ubuntu\home\...`) em vez de `C:\`.
- **Licença GPL v3 do ERPNext:** uso interno não obriga publicar código. Se no futuro o sistema for distribuído a terceiros, rever as obrigações da GPL.
- **Gatilho para comparar Dolibarr:** só se aparecer impedimento concreto (por exemplo, RAM insuficiente sem possibilidade de upgrade, virtualização indisponível, falha recorrente de instalação ou limitação do modelo de dados do ESCOPO). Nenhum desses casos ocorreu até agora.

## 7. Onde as verificações foram executadas

| Ação | Onde |
|---|---|
| Leitura do repositório, consulta de versões e requisitos (`git clone`, `git ls-remote`, leitura de `pyproject.toml`, `package.json`, Dockerfile e documentação do frappe_docker) | Ambiente remoto do Claude (nuvem, Linux) |
| Sistema operacional, arquitetura e pastas do perfil do usuário | Computador do Bruno, via app Claude Desktop (somente leitura) |
| Script `verificar-ambiente.ps1` | **Não executado ainda.** Escrito em ASCII; sintaxe não testada porque o ambiente remoto não tem PowerShell |
| Instalação de WSL, Docker, ERPNext | **Não executada** (aguarda autorização e T002) |

## 8. Próxima ação

1. Bruno roda o script da seção 4 e anexa o resultado ao PR.
2. Com tudo `OK`, Bruno autoriza a instalação dos pré-requisitos (passo 1).
3. Seguir para o T002 com este roteiro como base.

## Fontes

- frappe/frappe_docker, `docs/05-development/01-development.md`, `devcontainer-example/`, `images/bench/Dockerfile`, `development/installer.py` (commit `85ad653`).
- frappe/frappe e frappe/erpnext, branch `version-16` (`pyproject.toml`, `package.json`, `__init__.py`, `license.txt`).
- Docker Docs, "Install Docker Desktop on Windows": https://docs.docker.com/desktop/setup/install/windows-install/
- Fórum Frappe, "ERPNext v16 – Local Docker Setup for Development": https://discuss.frappe.io/t/tutorial-erpnext-v16-local-docker-setup-for-development/159165
