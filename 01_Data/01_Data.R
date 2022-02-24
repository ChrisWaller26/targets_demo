
####### Data #######

#### Create Dummy Data ####

get_freq_data =
  function(pseudo_pars, pseudo_n = 2000){

    freq_data =
      tibble(
        pol_id = seq(pseudo_n),
        region = sample(pseudo_pars$region, pseudo_n, TRUE)
      ) %>%
      left_join(
        pseudo_pars,
        by = "region"
      ) %>%
      mutate(
        count = rpois(n(), lambda)
      )

    return(freq_data)

  }

get_sev_data = function(freq_data, pseudo_pars){

  sev_data =
    sapply(
      seq(pseudo_n),
      function(i){

        if(freq_data$count[i] > 0){

          data.frame(
            pol_id = rep(i, freq_data$count[i])
          )

        }

      }
    ) %>%
    bind_rows() %>%
    inner_join(
      freq_data,
      by = "pol_id"
    ) %>%
    mutate(
      loss = rlnorm(n(), mu, sigma),
      claim_id = row_number()
    )

  return(sev_data)

}
