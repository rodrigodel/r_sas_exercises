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

# Ler arquivo Excel
enem_anomalias <- readxl::read_excel("EMEM_2021_ANOMALIAS.xlsx")
