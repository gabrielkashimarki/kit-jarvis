# Kit Jarvis

Os arquivos que fazem uns 20 agentes de IA trabalharem ao mesmo tempo na BDR Digital e na Smarten
sem esquecer o que fizeram e sem pisar um no trabalho do outro.

Funciona no [Claude Code](https://claude.com/claude-code). São os arquivos que a gente usa hoje,
sem senha e sem nome de cliente.

## O problema

No começo, cada agente era um estagiário sem mesa, sem crachá e sem caderno.

- Esquecia tudo de uma sessão para outra.
- Dois mexiam no mesmo arquivo e um apagava o trabalho do outro.
- Quando o contexto enchia, o trabalho parava no meio e ninguém sabia onde.
- Credencial aparecia colada no chat.

## O que tem no kit

| Peça | Arquivo | Problema que resolve |
|---|---|---|
| Regras | `CLAUDE.md` | Todo agente lê antes de começar: como falar, o que fazer sozinho, quando perguntar, git, credenciais |
| Memória | `memoria/` | Fato que importa fica numa pasta fora do chat, com um índice curto que entra em toda sessão |
| Passagem de bastão | `skills/handoff/` | Quando a sessão enche, o agente escreve onde parou e a próxima continua dali |
| Sessões paralelas | `regras/sessoes-paralelas.md` | Um condutor por trabalho, worktree por sessão, releitura antes de escrever |

```
kit-jarvis/
  CLAUDE.md                     regras globais (vai para ~/.claude/CLAUDE.md)
  memoria/
    MEMORY.md                   índice da memória, carregado em toda sessão
    COMO-USAR.md                formato de um fato e regras de manutenção
    fatos/                      dois exemplos de fato
  skills/handoff/
    SKILL.md                    a skill de passagem de bastão
    MODELO.md                   o modelo do documento de handoff
  regras/sessoes-paralelas.md   regras para vários agentes ao mesmo tempo
  instalar.sh                   copia tudo para ~/.claude sem sobrescrever nada
```

## Requisitos

- Claude Code instalado (`claude --version`).
- macOS ou Linux. No Windows, use o WSL ou copie os arquivos à mão (passo a passo abaixo).
- Opcional: um gerenciador de senhas com CLI. O kit usa o 1Password (`op`) como exemplo.

## Instalação

### Com o script (2 minutos)

```bash
git clone https://github.com/gabrielkashimarki/kit-jarvis.git
cd kit-jarvis
./instalar.sh
```

O script cria as pastas em `~/.claude` e copia os arquivos. **Ele nunca sobrescreve nada.**
Se você já tem um `~/.claude/CLAUDE.md`, o do kit fica em `~/.claude/CLAUDE.jarvis.md` para você juntar à mão.

### À mão

```bash
mkdir -p ~/.claude/memoria/fatos ~/.claude/regras ~/.claude/skills/handoff ~/.claude/handoffs
cp CLAUDE.md ~/.claude/CLAUDE.md                     # só se você ainda não tiver um
cp memoria/MEMORY.md memoria/COMO-USAR.md ~/.claude/memoria/
cp memoria/fatos/*.md ~/.claude/memoria/fatos/
cp regras/sessoes-paralelas.md ~/.claude/regras/
cp skills/handoff/*.md ~/.claude/skills/handoff/
cp skills/handoff/MODELO.md ~/.claude/handoffs/
```

### Já tenho um CLAUDE.md

Não troque o seu pelo do kit. Abra os dois lado a lado e:

1. Copie as duas linhas `@~/.claude/...` do topo do `CLAUDE.jarvis.md` para o topo do seu.
   São elas que carregam a memória e as regras de sessões paralelas em toda sessão.
2. Copie as seções que você ainda não tem (Credenciais, Memória, Registro de sessão, Passagem de bastão).
3. Apague o `CLAUDE.jarvis.md`.

## Configuração (10 minutos)

1. **`~/.claude/CLAUDE.md`**: troque o que está entre `<>` (nome, empresas, pasta de notas).
   Apague a seção que não serve para você. Se não usa 1Password, troque o exemplo do `op`
   pelo CLI do seu gerenciador, ou apague a seção e mantenha só a regra "credencial nunca passa pelo chat".
2. **`~/.claude/memoria/MEMORY.md`**: apague os exemplos e deixe o índice vazio. Ele enche sozinho com o uso.
3. **`~/.claude/memoria/fatos/`**: os dois arquivos são exemplo de formato. Leia e apague.
4. **Pasta de notas**: escolha onde o agente vai registrar as sessões (uma pasta do Obsidian funciona bem)
   e coloque o caminho na seção "Registro de sessão" do `CLAUDE.md`.

### Conferir se funcionou

Abra uma sessão nova do Claude Code em qualquer pasta e rode `/memory`. O `~/.claude/CLAUDE.md`
tem que aparecer na lista. Depois pergunte:

```
O que você sabe sobre como deve tratar credenciais e sobre sessões em paralelo?
```

Se ele responder com as regras do kit, está carregado.

## Uso no dia a dia

### Memória

Você não precisa fazer nada de especial. Quando aparecer um fato que vale guardar, peça:

```
Guarda isso na memória: o deploy de produção só funciona com o .env gerado pelo op inject.
```

O agente cria `~/.claude/memoria/fatos/<slug>.md` e uma linha no índice. Na próxima sessão,
o índice já entra no contexto e ele abre o fato quando o assunto aparecer.

Uma vez por mês, peça uma faxina: `Revisa a memória: junta duplicado, apaga o que ficou errado, enxuga o índice.`

### Passagem de bastão

Quando a sessão estiver pesada, ou no fim do dia:

```
/handoff
```

O agente escreve `~/.claude/handoffs/AAAA-MM-DD-HHMM-<assunto>.md`, registra a sessão na pasta de notas
e te dá um prompt assim:

```
Leia /Users/voce/.claude/handoffs/2026-10-11-1642-deploy-crm.md e continue o trabalho descrito ali.
```

Abra uma sessão nova, cole e pronto. A sessão nova começa sabendo o que foi feito, o que falta
e o que não deve ser tentado de novo.

### Sessões em paralelo

Antes de abrir uma segunda sessão no mesmo projeto, diga o que cada uma conduz:

```
Você cuida do deploy. A outra sessão cuida da revisão de código. Não mexa no branch dela.
```

Em código, cada sessão trabalha no próprio worktree:

```bash
git worktree add -b correcao-login ../meu-projeto-login origin/main
```

As regras completas estão em `regras/sessoes-paralelas.md` e são carregadas em toda sessão.

## Perguntas frequentes

**Funciona com outro agente além do Claude Code?**
As regras são texto. O Codex lê `AGENTS.md` e o Gemini CLI lê `GEMINI.md`: copie o conteúdo do
`CLAUDE.md` para o arquivo que o seu agente lê. As linhas `@~/...` são do Claude Code; nos outros,
cole o conteúdo dos arquivos no lugar delas.

**A memória não fica grande demais?**
Só o índice entra em toda sessão, e ele tem teto de 5 KB. O fato completo só é lido quando o assunto aparece.

**Posso usar em equipe?**
Sim. Coloque o `CLAUDE.md` do projeto na raiz do repositório (regras do projeto) e deixe o
`~/.claude/CLAUDE.md` com as regras pessoais de cada um.

**E o meu CLAUDE.md antigo?**
O script não toca nele. Veja "Já tenho um CLAUDE.md".

## Licença

MIT. Use, mude e distribua à vontade.

Feito por Gabriel Kashimarki, BDR Digital e Smarten.
