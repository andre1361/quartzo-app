# Quartzo

App para Mac que junta seus projetos, os arquivos e os agentes de IA da **sua** conta (Claude Code e, se quiser,
Codex) numa janela só: chat, terminal, editor de Markdown e código, Git, lista de tarefas e navegador.

**Produzido por Rafael André.** Este repositório tem só o app pronto e as novidades de cada versão.

## Instalar

Abra o **Terminal** e cole:

```sh
curl -fsSL https://raw.githubusercontent.com/andre1361/quartzo-app/main/instalar.sh | bash
```

O instalador baixa a última versão, confere que o arquivo é o mesmo que foi publicado (SHA-256) e a assinatura,
coloca o Quartzo em Aplicativos e abre. Não precisa de conta no GitHub.

### Sem Terminal

1. Baixe o **[Quartzo.dmg](https://github.com/andre1361/quartzo-app/releases/latest/download/Quartzo.dmg)**, abra e
   arraste o Quartzo para a pasta Aplicativos.
2. Abra o Quartzo. Na primeira vez o macOS avisa que não conseguiu verificar o app (ele é assinado, mas ainda não
   passou pela notarização da Apple) e não abre.
3. Vá em **Ajustes do Sistema › Privacidade e Segurança**, role até o aviso sobre o Quartzo e clique em
   **Abrir Mesmo Assim**. Confirme com a senha do Mac. Isso só é pedido uma vez; as atualizações seguintes abrem
   direto.

**Precisa de:** Mac com Apple Silicon (M1 ou mais novo), macOS 14 ou mais novo e o
[Claude Code](https://claude.com/claude-code) com uma conta Claude Pro ou Max. Se o Claude Code ainda não estiver
instalado, o Quartzo mostra na primeira abertura um botão para instalar e entrar.

## Atualizações

O próprio Quartzo avisa quando sai uma versão nova e mostra o que mudou. É só tocar em **Atualizar e reiniciar**:
ele baixa, confere, troca o app e reabre, sem perder conversas nem terminais. Também dá para procurar no rodapé
da barra lateral (**Buscar atualização**). As novidades de cada versão ficam nas
[versões publicadas](https://github.com/andre1361/quartzo-app/releases).

## Seus dados

- O Quartzo usa o Claude Code **da sua conta**, logado no seu Mac. Ele não tem servidor próprio e não coleta nada.
- Conversas, projetos e ajustes ficam no seu Mac, em `~/Library/Application Support/Quartzo`.
- O que vai para a internet é o que o próprio Claude Code (ou o Codex) já envia para conversar, e a consulta de
  versão nova aqui no GitHub.

## Antes de usar

Por padrão os agentes trabalham **sem pedir permissão** (Skip Permissions): editam arquivos e rodam comandos nas
pastas que você abrir. É o modo mais rápido, e o Quartzo explica isso na primeira abertura e deixa trocar para
"Aceitar edições". Dá para mudar quando quiser em Ajustes › Claude Code › Permissões padrão.

## Desinstalar

Apague o Quartzo de Aplicativos. Para apagar também as conversas e ajustes, apague a pasta
`~/Library/Application Support/Quartzo`.

---
© 2026 Rafael André. Todos os direitos reservados. O Quartzo usa SwiftTerm (Miguel de Icaza) e MarkdownUI
(Guillermo Gonzalez), ambos com licença MIT.
