# Crie um vetor de pacotes para instalar
pacotes <- c("ggplot2", "dplyr")

# Função para instalar e carregar pacotes
instalar_carregar_pacotes <- function(pacotes) {
  for(pkg in pacotes){
    # Verifique se o pacote está instalado
    if (!require(pkg, character.only = TRUE)) {
      # Tente instalar o pacote
      install.packages(pkg, dependencies = TRUE)
      # Tente carregar o pacote novamente
      if(!require(pkg, character.only = TRUE)) {
        print(paste("Falha ao carregar o pacote:", pkg))
      } else {
        print(paste("Carregado com sucesso:", pkg))
      }
    } else {
      print(paste("Pacote já carregado:", pkg))
    }
  }
}

# Chame a função com o vetor de pacotes
instalar_carregar_pacotes(pacotes)

#Carregando pacotes necessários para importar as bases

pacotes <- c("readr", "readxl")

instalar_carregar_pacotes(pacotes)

# Carregando Pacotes

# Ler arquivos CSV
bd_candidatos_enem <- readr::read_delim("BD_CANDIDATOS_ENEM.csv", delim = ";", locale = readr::locale(encoding = "ISO-8859-1"))
bd_ibge_municipios <- readr::read_delim("BD_IBGE_Municipios_Latitude_Longitude.csv", locale = readr::locale(encoding = "ISO-8859-1"))
bd_unidade_federacao <- readr::read_delim("BD_Unidade_Federacao.csv", locale = readr::locale(encoding = "ISO-8859-1"))
municipio_enem_pib <- readr::read_csv("Municipio_Enem_2019_PIB_2019.csv", locale = readr::locale(encoding = "ISO-8859-1"))
#bd_remuneracoes <- readr::read_delim("Remuneracoes-2023-04.csv", locale = readr::locale(encoding = "UTF-8"))

bd_remuneracoes <- read.csv("Remuneracoes-2023-04.csv", sep = ";", fileEncoding = "UTF-8", stringsAsFactors = TRUE)

# Ler arquivo Excel
enem_anomalias <- readxl::read_excel("EMEM_2021_ANOMALIAS.xlsx")

#Usando o pacote Skimr

pacotes <- c("skimr")

instalar_carregar_pacotes(pacotes)

# Use skim para sumarizar seus dados
resumo_candidatos_enem <- skim(bd_candidatos_enem)
resumo_ibge_municipios <- skim(bd_ibge_municipios)
resumo_unidade_federacao <- skim(bd_unidade_federacao)
resumo_municipio_enem_pib <- skim(municipio_enem_pib)
resumo_bd_remuneracoes <- skim(bd_remuneracoes)

resumo_candidatos_enem
resumo_ibge_municipios
resumo_unidade_federacao
resumo_municipio_enem_pib
resumo_bd_remuneracoes

# Comando Glimpse para verificar os tipos de variáveis

glimpse(bd_candidatos_enem)
glimpse(bd_ibge_municipios)
glimpse(bd_unidade_federacao)
glimpse(municipio_enem_pib)
glimpse(bd_remuneracoes)

#ANALISTA DO EXECUTIVO

# Converter VALOR para Numérico

bd_remuneracoes <- bd_remuneracoes %>%
  mutate(Valor = as.numeric(gsub(",", ".", Valor)))

# Filtrar a base e calcular a média
media_analistas <- bd_remuneracoes %>% 
  filter(Cargo == 'ANALISTA DO EXECUTIVO') %>%
  summarize(media_analistas = mean(Valor, na.rm = TRUE))

# Exibir a média
print(round(media_analistas,2))

# FREQUENCIA DE CARGOS

bd_remuneracoes %>%
  count(Cargo) %>%
  arrange(desc(n))

bd_remuneracoes %>%
  group_by(Cargo) %>%
  summarise(media_valor = mean(Valor, na.rm = TRUE)) %>%
  arrange(desc(media_valor)) %>%
  print(n=20)

rodrigo <- bd_remuneracoes |> 
  filter(Nome == 'RODRIGO DEL FIUME ZAMBON')

mean(bd_remuneracoes$Valor, na.rm = TRUE)

#CALCULO DO SALARIO

calcular_salario <- function(nome) {
  salario <- bd_remuneracoes %>%
    filter(Nome == nome) %>%
    mutate(salario = sum(ifelse(VantagemDesconto == "V", Valor, -Valor), na.rm = TRUE))
  
  return(salario$salario[1])
}

calcular_salario("RODRIGO DEL FIUME ZAMBON")
