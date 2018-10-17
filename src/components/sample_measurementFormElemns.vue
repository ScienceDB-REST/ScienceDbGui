<template>
  <div id="sample_measurement-form-elemns-div">

  <input type="hidden" v-model="sample_measurement.id"/>
  
  
    <div id="sample_measurement-variable-div" class="form-group">
            <label>variable</label>
      
  <input type="text" v-model="sample_measurement.variable" class="form-control"/>


      <div id="sample_measurement-variable-err" v-if="validationError('variable')" class="alert alert-danger">
        {{validationError('variable').message}}
      </div>
    </div>

  
    <div id="sample_measurement-value-div" class="form-group">
            <label>value</label>
      
  <input type="text" v-model="sample_measurement.value" class="form-control"/>


      <div id="sample_measurement-value-err" v-if="validationError('value')" class="alert alert-danger">
        {{validationError('value').message}}
      </div>
    </div>

  
    <div id="sample_measurement-unit-div" class="form-group">
            <label>unit</label>
      
  <input type="text" v-model="sample_measurement.unit" class="form-control"/>


      <div id="sample_measurement-unit-err" v-if="validationError('unit')" class="alert alert-danger">
        {{validationError('unit').message}}
      </div>
    </div>

  
    <div id="sample_measurement-CAS_number-div" class="form-group">
            <label>CAS_number</label>
      
  <input type="text" v-model="sample_measurement.CAS_number" class="form-control"/>


      <div id="sample_measurement-CAS_number-err" v-if="validationError('CAS_number')" class="alert alert-danger">
        {{validationError('CAS_number').message}}
      </div>
    </div>

  
      
    <div id="sample_measurement-sample-div" class="form-group">
      <label>sample</label>
      <foreign-key-form-element
        :searchUrl = "this.$baseUrl() + '/samples'"
        v-model:foreignKey="sample_measurement.sample_id"
        label="id"
                subLabel="material"
                valueKey="name"
        v-bind:initialInput="sampleInitialLabel">
      </foreign-key-form-element>
    </div>

  

  
  
  </div>
</template>

<script>
import Vue from 'vue'

import foreignKeyFormElement from './foreignKeyFormElement.vue'

Vue.component('foreign-key-form-element', foreignKeyFormElement)


export default {
  props: [ 'sample_measurement', 'errors' ],
  computed: {
          sampleInitialLabel: function () {
      var x = this.sample_measurement.sample
      if (x !== null && typeof x === 'object' &&
          x['id'] !== null &&
          typeof x['id'] !== 'undefined') {
        return x['id']
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
