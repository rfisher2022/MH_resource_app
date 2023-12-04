# MH_resource_app for BE227

This application was developed as a prototype demonstration for UCLA BE227 Final Project.

Code by: Rebecca Fisher

## Data Sources: 
Provider data pulled from: 
* ZocDoc (Provider names resource. Able to filter by location, insurance, gender, but not by specific diagnoses)
* Psychology Today (Provider names resource. Able to filter by location, insurance, gender, diagnoses. Has some support group information but very limited)
* Neighborhood Navigator (https://www.aafp.org/family-physician/patient-care/the-everyone-project/neighborhood-navigator.html) 
* Community resources navigation tool
* Maternal Mental Health Now Maternal Mental Health Resource Directory (maternalmentalhealthnow.org)
* Los Angeles Maternal Mental Health Resource Directory

Patient Data is all fake generated data. 

Development Process:
For the application prototype development, we generated a dataset of providers and resources via the below sites for the use case patient (Gabreiela Ruta).  

Prototype was developed in R shiny, with Github integration for version control.  Data included the provider list described above, and a list of fake patients with relevant attributes including one record for our use case patient, Gabriela Ruta.  The application features a patient search, a patient details table, a map of the providers and the selected patient’s address with a 1 mile radius, and a searchable table of all of the providers. 

In order to develop the application in alignment with the proposed architecture design, several critical components would need to be enabled.  In the fully developed application, all of the UI features including the patient record, the map, and the matching provider table, would be dynamically reactive with real-time filtering. The data driving the content in the UI would be generated through FHIR messaging and API integrations, and would be integrated with the EPIC (or other) EHR.  
