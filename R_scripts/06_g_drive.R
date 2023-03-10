# Download data created by GEE to Drive----

library(googledrive)
googledrive::drive_auth() #dar acessso desde o navegador

## Criando a pasta para não sobreescrever processed_data:----
#dir.create("drive_data")#run only once


## Look up landform variety and download by id----
## with a function so we don't copy code
download_results <- function(pattern = "landform_variety") {
  lf_var <- drive_find(pattern = pattern)
  #Download from drive using the ids: 
  for (i in seq_along(lf_var$id)) {
    id <- lf_var$id[i]
    googledrive::drive_download(file = as_id(id),
                                path = paste0("drive_data/",pattern,"_", i),
                                overwrite = TRUE)
    }
}
download_results("landform_variety")# default
download_results("Brazil_landform_types")
download_results("elevation_range_residual")
download_results("soil_diversity")
# aqui falta agua pelo asset do Lucas. ----
drive_find("wetlands")
download_results("wetlands_density-")#o tracinho é para diferenciar de _1000
download_results("wetlands_density_1000")

# NOTE: We have to ignore this folder to avoid UPLOADING back to GEE. It will kill our quota. 

# environmental rasters for validation
drive_find("Brazil_")
download_results("slope")
download_results("Brazil_moisture_index")
download_results("Brazil_flow_acc")
download_results("Brazil_aspect")
download_results("Brazil_TPI")
download_results("Brazil_DEM")
