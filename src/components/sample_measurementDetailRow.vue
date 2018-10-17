<template>
  <div @click="onClick">
    <div class="inline field">
      <label>id: </label>
      <span>{{rowData.id}}</span>
    </div>
          <div class="inline field">
        <label>variable:</label>
        <span>{{rowData.variable}}</span>
      </div>
          <div class="inline field">
        <label>value:</label>
        <span>{{rowData.value}}</span>
      </div>
          <div class="inline field">
        <label>unit:</label>
        <span>{{rowData.unit}}</span>
      </div>
          <div class="inline field">
        <label>CAS_number:</label>
        <span>{{rowData.CAS_number}}</span>
      </div>
    
      
    <div id="sample_measurement-sample-div">
      <div class="inline field">
        <label>sample:</label>
        <span>{{sampleInitialLabel}}</span>
      </div>
    </div>

  
  
  </div>
</template>

<script>
export default {
  props: {
    rowData: {
      type: Object,
      required: true
    },
    rowIndex: {
      type: Number
    }
  },
  computed: {
          sampleInitialLabel: function () {
      var x = this.rowData.sample
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
    onClick (event) {
      console.log('my-detail-row: on-click', event.target)
    }
  }
}
</script>
