# 📊 Análise Exploratória de Dados — Expectativa de Vida (WHO)

Este repositório contém um projeto de **Análise Exploratória de Dados (EDA)** realizado a partir da base **Life Expectancy (WHO)**.  
O objetivo é investigar fatores associados à expectativa de vida em diferentes países utilizando **R**, combinando análise estatística, visualização de dados e um **dashboard interativo em Shiny**.

---

# 🎯 Objetivos do Projeto

Este trabalho busca:

- Explorar a distribuição das variáveis relacionadas à expectativa de vida
- Investigar relações entre indicadores socioeconômicos e de saúde
- Avaliar a **completude dos dados**
- Tratar valores faltantes utilizando **imputação múltipla (MICE)**
- Aplicar **testes estatísticos**
- Desenvolver um **dashboard interativo** para explorar os resultados

---

# 📁 Estrutura do Repositório

```
PD-analise-exploratoria
│
├── data/                               # Base de dados utilizada
├── app.R                               # Dashboard interativo em Shiny
├── pd_analise_exploratoria_dados.qmd   # Relatório em Quarto
├── pd_analise_exploratoria_dados.html  # Relatório renderizado
├── pd_analise_exploratoria_dados_files # Arquivos auxiliares do relatório
├── rsconnect/                          # Arquivos de deploy do Shiny
├── .gitignore
├── PD-Estatística.Rproj
└── README.md
```

---

# 📊 Análise Exploratória de Dados

A análise exploratória incluiu:

- Histogramas com curvas de densidade
- Q-Q plots para avaliação de normalidade
- Matriz de correlação
- Matriz de espalhamento (scatterplot matrix)

Essas técnicas permitiram identificar:

- formato das distribuições
- presença de assimetria
- relações lineares entre variáveis
- possíveis problemas de escala ou outliers

---

# 📉 Tratamento de Dados Faltantes

Foi realizada uma análise de **completude das variáveis**, verificando a proporção de valores disponíveis em cada coluna.

Mesmo apresentando níveis elevados de completude (acima de 90% na maioria das variáveis), algumas variáveis ainda continham valores faltantes.

Para tratar esse problema foi utilizado o pacote **MICE (Multivariate Imputation by Chained Equations)**.

### Método utilizado

- **Predictive Mean Matching (PMM)**

Esse método foi escolhido porque:

- preserva a distribuição original dos dados
- mantém a variabilidade observada
- gera valores imputados baseados em observações reais

Durante a aplicação inicial com todas as variáveis, foi identificado um problema de **singularidade computacional**, causado por **alta colinearidade entre variáveis**.

Para contornar esse problema, foi realizado um **ajuste no conjunto de variáveis utilizadas na imputação**, selecionando apenas aquelas com menor redundância.

---

# 📊 Testes Estatísticos

Após o tratamento dos dados, foram realizados três testes principais.

## Correlação de Pearson

Avaliação da relação linear entre **escolaridade** e **expectativa de vida**.

Resultado:

- correlação ≈ **0.76**
- relação **positiva forte**

Isso sugere que níveis mais elevados de escolaridade tendem a estar associados a maior expectativa de vida.

---

## Teste t de Welch

Comparação entre países **desenvolvidos** e **em desenvolvimento**.

Resultado:

- diferença média ≈ **11,8 anos**
- valor p **< 0.001**

Indica uma diferença estatisticamente significativa na expectativa de vida entre os dois grupos.

---

## ANOVA

Análise da expectativa de vida entre **três grupos de PIB**:

- baixo
- médio
- alto

Resultado:

- estatística F elevada
- valor p **< 0.001**

Isso indica que pelo menos um dos grupos apresenta média significativamente diferente.

---

# 📈 Dashboard Interativo (Shiny)

O projeto inclui um **dashboard interativo desenvolvido em Shiny**.

[Dashboard Online](https://alan-alonso.shinyapps.io/pd-estatstica/)

Funcionalidades:

- seleção de variáveis explicativas
- visualização de **scatterplots**
- cálculo de **correlação em tempo real**
- visualização dos resultados dos testes estatísticos

### Executar o dashboard localmente

No R:

```r
shiny::runApp("app.R")
```

---

# 🛠 Tecnologias Utilizadas

- **R**
- **Shiny**
- **Quarto**
- **ggplot2**
- **dplyr**
- **mice**

---

# 📚 Base de Dados

Dataset: **Life Expectancy (WHO)**

Contém indicadores relacionados a:

- mortalidade
- vacinação
- consumo de álcool
- PIB
- escolaridade
- composição de renda
- população

Essas variáveis permitem investigar fatores associados à expectativa de vida em nível global.

---

# 👨‍💻 Autor

**Alan Alonso**

Projeto desenvolvido para a disciplina de **Análise Exploratória de Dados**.
