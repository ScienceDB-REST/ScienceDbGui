admin_gui_gen . --baseUrl '//api.reconstructdb.org' --name taxon --attributes 'name:string, taxonomic_level:string' --belongsTos 'taxon:parent_id:id:name:taxonomic_level:parent'

admin_gui_gen . --baseUrl '//api.reconstructdb.org' --name field_plot --attributes 'field_name:string, latitude:double, longitude:double, location_code:string, soil_treatment:string'

admin_gui_gen . --baseUrl '//api.reconstructdb.org' --name pot --attributes 'pot:string, greenhouse:string, climate_chamber:string, conditions:string'

admin_gui_gen . --baseUrl '//api.reconstructdb.org' --name cultivar --attributes 'description:string, genotype:string' --belongsTos 'taxon:taxon_id:id:name:taxonomic_level'

admin_gui_gen . --baseUrl '//api.reconstructdb.org' --name individual --attributes 'name:string, sowing_date:date, harvest_date:date, developmental_state:string, life_cycle_phase:string, location_type:string' --belongsTos 'cultivar:cultivar_id:id:genotype:description, field_plot:field_plot_id:id:field_name:location_code, pot:pot_id:id:pot:greenhouse'

admin_gui_gen . --baseUrl '//api.reconstructdb.org' --name sample --attributes 'name:string, material:string, life_cycle_phase:string, description:string, harvest_date:date, library:string, barcode_number:integer, barcode_sequence:string' --belongsTos 'individual:individual_id:id:name:harvest_date, field_plot:field_plot_id:id:field_name:location_code, pot:pot_id:id:pot:greenhouse, parent:parent_id:id:name:material'

admin_gui_gen . --baseUrl '//api.reconstructdb.org' --name microbiome_otu --attributes 'otu_id:string, sample_desc:string, count:integer, experiment:string, version:integer, kingdom:string, createdAt:date, updatedAt:date, reference_sequence:string' --belongsTos 'parent:parent_id:id:sample_desc:experiment, sample:sample_id:id:name:material, taxon:taxon_id:id:name:taxonomic_level'

admin_gui_gen . --baseUrl '//api.reconstructdb.org' --name sample_measurement --attributes 'variable:string, value:numeric, unit:string, CAS_number:string' --belongsTos 'sample:sample_id:name:id:material'

admin_gui_gen . --baseUrl '//api.reconstructdb.org' --name plant_measurement --belongsTos 'individual:individual_id:id:name:sowing_date' --attributes 'variable:string, value:numeric, unit:string'

admin_gui_gen . --baseUrl '//api.reconstructdb.org' --name transcript_count --attributes 'gene:string, variable:string, count:numeric, tissue_or_condition:string' --belongsTos 'individual:individual_id:id:name:sowing_date'
