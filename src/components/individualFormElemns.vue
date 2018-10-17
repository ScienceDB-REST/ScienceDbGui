<template>
  <div id="individual-form-elemns-div">

  <input type="hidden" v-model="individual.id"/>
  
  
    <div id="individual-name-div" class="form-group">
            <label>name</label>
      
  <input type="text" v-model="individual.name" class="form-control"/>


      <div id="individual-name-err" v-if="validationError('name')" class="alert alert-danger">
        {{validationError('name').message}}
      </div>
    </div>

  
    <div id="individual-sowing_date-div" class="form-group">
            <label>sowing_date</label>
      
  <input v-model="individual.sowing_date" class="datepicker" />


      <div id="individual-sowing_date-err" v-if="validationError('sowing_date')" class="alert alert-danger">
        {{validationError('sowing_date').message}}
      </div>
    </div>

  
    <div id="individual-harvest_date-div" class="form-group">
            <label>harvest_date</label>
      
  <input v-model="individual.harvest_date" class="datepicker" />


      <div id="individual-harvest_date-err" v-if="validationError('harvest_date')" class="alert alert-danger">
        {{validationError('harvest_date').message}}
      </div>
    </div>

  
    <div id="individual-developmental_state-div" class="form-group">
            <label>developmental_state</label>
      
  <input type="text" v-model="individual.developmental_state" class="form-control"/>


      <div id="individual-developmental_state-err" v-if="validationError('developmental_state')" class="alert alert-danger">
        {{validationError('developmental_state').message}}
      </div>
    </div>

  
    <div id="individual-life_cycle_phase-div" class="form-group">
            <label>life_cycle_phase</label>
      
  <input type="text" v-model="individual.life_cycle_phase" class="form-control"/>


      <div id="individual-life_cycle_phase-err" v-if="validationError('life_cycle_phase')" class="alert alert-danger">
        {{validationError('life_cycle_phase').message}}
      </div>
    </div>

  
    <div id="individual-location_type-div" class="form-group">
            <label>location_type</label>
      
  <input type="text" v-model="individual.location_type" class="form-control"/>


      <div id="individual-location_type-err" v-if="validationError('location_type')" class="alert alert-danger">
        {{validationError('location_type').message}}
      </div>
    </div>

  
      
    <div id="individual-cultivar-div" class="form-group">
      <label>cultivar</label>
      <foreign-key-form-element
        :searchUrl = "this.$baseUrl() + '/cultivars'"
        v-model:foreignKey="individual.cultivar_id"
        label="genotype"
                subLabel="description"
                valueKey="id"
        v-bind:initialInput="cultivarInitialLabel">
      </foreign-key-form-element>
    </div>

      
    <div id="individual-field_plot-div" class="form-group">
      <label>field_plot</label>
      <foreign-key-form-element
        :searchUrl = "this.$baseUrl() + '/field_plots'"
        v-model:foreignKey="individual.field_plot_id"
        label="field_name"
                subLabel="location_code"
                valueKey="id"
        v-bind:initialInput="field_plotInitialLabel">
      </foreign-key-form-element>
    </div>

      
    <div id="individual-pot-div" class="form-group">
      <label>pot</label>
      <foreign-key-form-element
        :searchUrl = "this.$baseUrl() + '/pots'"
        v-model:foreignKey="individual.pot_id"
        label="pot"
                subLabel="greenhouse"
                valueKey="id"
        v-bind:initialInput="potInitialLabel">
      </foreign-key-form-element>
    </div>

  

  
  
  </div>
</template>

<script>
import Vue from 'vue'

import foreignKeyFormElement from './foreignKeyFormElement.vue'

Vue.component('foreign-key-form-element', foreignKeyFormElement)


export default {
  props: [ 'individual', 'errors' ],
  computed: {
          cultivarInitialLabel: function () {
      var x = this.individual.cultivar
      if (x !== null && typeof x === 'object' &&
          x['genotype'] !== null &&
          typeof x['genotype'] !== 'undefined') {
        return x['genotype']
      } else {
        return ''
      }
    }
        ,
              field_plotInitialLabel: function () {
      var x = this.individual.field_plot
      if (x !== null && typeof x === 'object' &&
          x['field_name'] !== null &&
          typeof x['field_name'] !== 'undefined') {
        return x['field_name']
      } else {
        return ''
      }
    }
        ,
              potInitialLabel: function () {
      var x = this.individual.pot
      if (x !== null && typeof x === 'object' &&
          x['pot'] !== null &&
          typeof x['pot'] !== 'undefined') {
        return x['pot']
      } else {
        return ''
      }
    }
        },
  methods: {
    validationError(modelField) {
      if (this.errors == null) return false;
      return this.errors.find(function (el) {
        return el.path === modelField
      })
    }
  },
	mounted: function() {
    let el = this;
    $(document).ready(function(){
      $('.datepicker').datepicker({
        format: el.$defaultDateFormat(),
        dateFormat: el.$defaultDateFormat()
      })
    })
	}
}
</script>
