library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(mice)

# =========================
# DADOS
# =========================
df <- read.csv("data/Life_expectancy_2025.csv")
names(df) <- make.names(names(df))

# Subconjunto usado na imputação
vars_mice <- df %>%
  select(
    Life.expectancy,
    Alcohol,
    BMI,
    GDP,
    Schooling
  )

# Imputação com MICE
imputed_data <- mice(
  vars_mice,
  m = 5,
  method = "pmm",
  seed = 500,
  printFlag = FALSE
)

vars_mice_imputed <- complete(imputed_data, 1)

# Juntando Status para o teste t
df_imputed <- df %>%
  select(Status) %>%
  bind_cols(vars_mice_imputed)

df_imputed$Status <- as.factor(df_imputed$Status)

# Criando grupos de PIB para ANOVA
df_imputed <- df_imputed %>%
  mutate(
    GDP_Group = cut(
      GDP,
      breaks = quantile(GDP, probs = c(0, 1/3, 2/3, 1), na.rm = TRUE),
      labels = c("Baixo", "Médio", "Alto"),
      include.lowest = TRUE
    )
  )

# =========================
# UI
# =========================
ui <- dashboardPage(
  dashboardHeader(title = "Expectativa de Vida - Exploração"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Análise", tabName = "analise", icon = icon("chart-scatter")),
      
      selectInput(
        inputId = "var_x",
        label = "Escolha a variável do eixo X:",
        choices = c(
          "Álcool" = "Alcohol",
          "IMC" = "BMI",
          "PIB" = "GDP",
          "Escolaridade" = "Schooling"
        ),
        selected = "Schooling"
      )
    )
  ),
  
  dashboardBody(
    fluidPage(
      fluidRow(
        box(
          title = "Scatter Plot",
          width = 12,
          status = "primary",
          solidHeader = TRUE,
          plotOutput("scatter_plot", height = "400px")
        )
      ),
      
      fluidRow(
        box(
          title = "Correlação de Pearson",
          width = 12,
          status = "info",
          solidHeader = TRUE,
          verbatimTextOutput("correlacao")
        )
      )
    )
  )
)

# =========================
# SERVER
# =========================
server <- function(input, output, session) {
  
  dados_filtrados <- reactive({
    df_imputed
  })
  
  # Scatter plot
  output$scatter_plot <- renderPlot({
    dados <- dados_filtrados()
    
    ggplot(dados, aes(
      x = .data[[input$var_x]],
      y = Life.expectancy
    )) +
      geom_point(alpha = 0.7) +
      geom_smooth(method = "lm", se = FALSE) +
      labs(
        title = "Relação entre Variável Escolhida e Expectativa de Vida",
        x = input$var_x,
        y = "Life.expectancy"
      ) +
      theme_minimal()
  })
  
  # Correlação de Pearson
  output$correlacao <- renderPrint({
    dados <- dados_filtrados()
    
    correlacao <- cor(
      dados[[input$var_x]],
      dados$Life.expectancy,
      use = "complete.obs",
      method = "pearson"
    )
    
    cat("Correlação de Pearson entre", input$var_x, "e Life.expectancy:\n\n")
    print(round(correlacao, 3))
  })

}

# =========================
# RUN APP
# =========================
shinyApp(ui, server)