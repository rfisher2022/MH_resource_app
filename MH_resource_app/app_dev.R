library(dplyr)
library(tidyr)
library(reshape)
library(stringr)
library(plyr)
library(leaflet)



providers<-read.csv("MH_resource_app/data/providers.csv")
patients<-read.csv("MH_resource_app/data/person_records_BDandpostcodebase.csv")
str(providers)
str(patients)

m <- leaflet() %>% setView(lng = -118.36, lat = 34.06, zoom = 14)
m# %>% addTiles()
m %>% addProviderTiles(providers$CartoDB.Positron)
#m %>% 
  
m2<-leaflet(providers) %>% setView(lng = -118.36, lat = 34.07, zoom = 13)%>%
  addMarkers(~lon,~lat, popup=paste(sep = "<br/>",
      providers$provider_name,
      providers$provider_practice_name,
      providers$provider_address,
      paste0("<b>Gender: </b>",providers$gender),
      paste0("<b> Language: </b>", providers$language),
      paste0("<b> Insurance: </b>",providers$insurance),
      paste0("<b> Conditions Treated: </b>",providers$conditions)))
     
m2 %>% addTiles()
icons <- awesomeIcons(
  icon = 'home',
  iconColor = 'black',
  library = 'ion',
  markerColor = 'red'
)
m3<-leaflet(patients) %>% setView(lng = -118.36, lat = 34.07, zoom = 13)%>%
  addAwesomeMarkers(~lon,~lat, icon=icons, 
             popup=paste(sep = "<br/>",
                         patients$first_name,
                         patients$last_name,
                         patients$DOB))

m3 %>% addTiles()


m4<-leaflet() %>% 
  setView(lng = -118.36, lat = 34.07, zoom = 13)%>%
  addMarkers(~lon,~lat, popup=paste(sep = "<br/>",
                                    providers$provider_name,
                                    providers$provider_practice_name,
                                    providers$provider_address,
                                    paste0("<b>Gender: </b>",providers$gender),
                                    paste0("<b> Language: </b>", providers$language),
                                    paste0("<b> Insurance: </b>",providers$insurance),
                                    paste0("<b> Conditions Treated: </b>",providers$conditions)))%>%
  leaflet() %>% 
  addAwesomeMarkers(~lon,~lat, icon=icons, 
                    popup=paste(sep = "<br/>",
                                patients$first_name,
                                patients$last_name,
                                patients$DOB))

m4 %>% addTiles()

onepatient<-patients%>%filter(last_name=="Butt")
onepatient_t<-t(onepatient)

cn<-colnames(patients)
rn<-rownames(onepatient_t)
str(rn)
print(rn)
combo<-data.frame(rn,onepatient_t)
names(combo)<-c("","")

#m2 %>% addProviderTiles(providers$CartoDB.Positron)
