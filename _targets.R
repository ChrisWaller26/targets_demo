library(targets)

#### Load Functions and Parameters ####

tar_source()

#### Targets ####

list(

  #### Load Data ####

  tar_target(
    pseudo_pars_file,
    "R/01_Data/pseudo_pars.csv",
    format = "file"
  ),

  tar_target(
    pseudo_pars,
    read.csv(pseudo_pars_file)
  ),

  #### Process Data ####

  tar_target(
    freq_data,
    get_freq_data(pseudo_pars, pseudo_n = 2000)
  ),
  tar_target(
    sev_data,
    get_sev_data(freq_data, pseudo_pars)
  ),

  #### Run Models ####

  tar_target(
    freq_model_fit1,
    get_freq_model_fit1(freq_data)
  ),

  tar_target(
    freq_model_fit2,
    get_freq_model_fit2(freq_data)
  ),

  #### Validation ####

  tar_target(
    validation_doc,
    rmarkdown::render(
      input = "R/03_Validation/01_Validation.Rmd",
      output_file = "R/03_Validation/Validation.pdf",
      params =
        list(freq_model_fit1,
             freq_model_fit2)
    )
  )
)
