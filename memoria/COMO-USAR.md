# Como a memória funciona

O chat esquece tudo quando a sessão acaba. A memória fica numa pasta, fora do chat,
e o índice entra em toda sessão nova pelo `CLAUDE.md`.

## Estrutura

```
~/.claude/memoria/
  MEMORY.md        índice, uma linha por fato, carregado em toda sessão (teto de 5 KB)
  COMO-USAR.md     este arquivo
  fatos/
    <slug>.md      um fato por arquivo
```

Só o `MEMORY.md` entra no contexto. O agente abre o arquivo do fato quando o assunto aparece.
Por isso o índice tem que ser curto e o fato tem que estar no arquivo, não no índice.

## Formato de um fato

```markdown
---
name: <slug-em-kebab-case>
description: <uma linha, é o que o agente lê para decidir se o fato importa agora>
type: user | feedback | project | reference
---

<o fato>

**Por quê:** <o motivo, quando for feedback ou projeto>
**Como aplicar:** <o que fazer diferente por causa disso>

Relacionados: [[outro-slug]]
```

Tipos:
- `user`: quem você é, como prefere trabalhar.
- `feedback`: correção que você deu ao agente, com o motivo.
- `project`: trabalho em andamento, prazo, restrição que não está no código.
- `reference`: ponteiro para coisa externa (URL, painel, servidor).

## Regras
- Um fato por arquivo. Antes de criar, procure se já existe um que cubra o assunto.
- Data sempre absoluta ("15/10/2026"), nunca "semana que vem".
- Não guarde o que o repositório já guarda (estrutura de código, histórico do git).
- Memória que cita arquivo, função ou flag se confere antes de recomendar.
- Fato que ficou errado se apaga, não se acumula.
- Credencial nunca entra aqui. Só a referência do gerenciador de senhas.

## Linha no índice

```
- **<Assunto>**: <gancho de uma linha>: `<slug>`, `<outro-slug>`
```

Agrupe por cliente, interno e infraestrutura. Quando o índice passar de 5 KB,
junte linhas do mesmo assunto em vez de cortar fatos.
