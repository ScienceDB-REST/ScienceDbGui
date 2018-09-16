<template>
  <div class="col-sm-7 col-sm-offset-7">
    <h2>Welcome to Reconstruct-DB</h2>
    <p>
      This page provides documentation and help to the usage of
      Reconstruct-DB.
    </p>

      <h3>How to access Reconstruct-DB from your analyses scripts?</h3>
      <p>
        A <em>complete manual of the implemented API</em> can be downloaded
        <a href="/static/reconstruct_db_api.pdf">here</a>.
				The following is an example in R, of how to login and load all
				available data of model <code>Plant-Measurement</code>.
      </p>
      <pre>
        <code>
# Load dependencies
require(httr)

# Obtain all Plant-Measurements including Individuals and Genotypes
plantMeasurements.lst <-
  content(POST(
    url,
    encode = 'form',
    body = list(
      query = '{
        allPlantMeasurements {
          nodes {
            id
            variable
            value
            unit
            individualByIndividualId {
              name
              cultivarByCultivarId {
                genotype
              }
            }
          }
        }
      }')))$data$allPlantMeasurements$nodes

# Convert them to a data.frame
plantMeasurements.df <-
  Reduce(rbind, lapply(plantMeasurements.lst, function(pm.json) {
    data.frame(
      id = pm.json$id,
      variable = pm.json$variable,
      value = pm.json$value,
      unit = pm.json$unit,
      individual.name = pm.json$individualByIndividualId$name,
      individual.cultivar.genotype = pm.json$individualByIndividualId$cultivarByCultivarId$genotype,
      stringsAsFactors = FALSE
    )
  }))
        </code>
      </pre>
    </p>
  </div>
</template>
  
<script>
export default {
}
</script>
