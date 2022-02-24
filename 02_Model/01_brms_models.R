
####### BRMS Models #######

#### Frequency Models ####

get_freq_model_fit1 =
  function(freq_data){
    brm(
      count ~ 1,
      data = freq_data,
      family = poisson(),
      chains = 4,
      iter = 1000,
      backend = "cmdstanr"
    )
  }

get_freq_model_fit2 =
  function(freq_data){
    brm(
      count ~ 1 + 1|region,
      data = freq_data,
      family = poisson(),
      chains = 4,
      iter = 1000,
      backend = "cmdstanr"
    )
  }
