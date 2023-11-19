#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
##
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(plotly)
library(DT)
library(dplyr)
library(tidyr)
library(reshape)
library(stringr)
library(deSolve)
library(plyr)
library(leaflet)

providers<-read.csv("data/providers.csv")
patients<-read.csv("data/person_records_BDandpostcodebase.csv")

# Define UI for application 
ui <- fluidPage(
  fluidRow(
    h2("Personalized Mental Health Resource Finder")
  ),

  hr(),
  
  fluidRow(
    column(3,
           textInput("ln", "Last Name", "Ruta"),
           #verbatimTextOutput("last_name"),
           textInput("fn", "First Name", "Graciela"),
           #verbatimTextOutput("first_name"),
           dateInput("date3", "Date:", format = "mm/dd/yy"),
           textInput("mrn", "Medical Record Number", ""),
           verbatimTextOutput("medicalrecordnumber"), 
           DT::dataTableOutput("patient_record")
    ),
    column(9,
           leafletOutput("provider_map"),
           DT::dataTableOutput("provider_list")
    )
  ),
  hr()
)

# Define server logic 
server <- function(input, output) {
  
  patient.data <- reactive({
    patient_record<-patients%>%filter(Last.Name==input$ln)%>%dplyr::select(-12,-13)
    pn<-t(patient_record)
    #rn<-rownames(pn)
    #combo<-data.frame(rn,pn)
    #names(combo)<-c("","")
    #return(combo)
    return(pn)
  }) #closing reactive data
  
  output$patient_record <-DT::renderDataTable(patient.data(), 
                                              colnames="Patient Details",
                                              rownames=c("First Name",
                                                         "Last Name",
                                                         "Address",
                                                         "Date of Birth",
                                                         "Gender",
                                                         "MRN",
                                                         "Phone 1",
                                                         "Phone 2",
                                                         "Email",
                                                         "Insurance",
                                                         "Conditions"),
               options=list(iDisplayLength=20,                    # initial number of records
                           aLengthMenu=c(5,10),                  # records/page options
                           bLengthChange=0,                       # show/hide records per page dropdown
                           bFilter=0,                                    # global search box on/off
                           bInfo=0)
  )

  output$provider_map <- renderLeaflet({
    leaflet(providers) %>% setView(lng = -118.36, lat = 34.07, zoom = 13)%>%
      addMarkers(~lon,~lat, popup=paste(sep = "<br/>",
                                        providers$provider_name,
                                        providers$provider_practice_name,
                                        providers$provider_address,
                                        paste0("<b>Gender: </b>",providers$gender),
                                        paste0("<b> Language: </b>", providers$language),
                                        paste0("<b> Insurance: </b>",providers$insurance),
                                        paste0("<b> Conditions Treated: </b>",providers$conditions)))%>%
    addTiles()
  })
  
  output$provider_list <-DT::renderDataTable(providers%>%dplyr::select(-4,-5), 
                                             colnames=c("Provider Name", 
                                                        "Provider Address",
                                                        "Provider Practice",
                                                        "Accepted Insurance",
                                                        "Provider Gender",
                                                        "Provider Language",
                                                        "Conditions Treated"))
  
  
} 
# Run the application 
shinyApp(ui = ui, server = server)



#    http://shiny.rstudio.com/
#
