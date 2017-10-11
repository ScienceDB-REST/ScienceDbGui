<template>  
  <div class="control is-horizontal"
    <div class="control is-grouped">
      <p class="control is-expanded" v-for="field in fields" v-if="field.sortField">
        <input class="input" type="text" :name=field.name :placeholder=field.name>
      </p>
      <p class="control is-expanded">
        <datepicker placeholder="range..." :options="{mode: 'range'}" v-model="dataSelected"></datepicker>
      </p>
      <p class="control is-expanded">
        <button class="button is-primary" @click="doFilter">Search</button>
      </p>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      filterText: ''
    }
  },
  props: [
    'fields'
  ],
  methods: {
    doFilter () {
      var extendedSearchValues = {};

      for(var i = 0; i < this.fields.length; i++){
        if(this.fields[i].sortField){
          var fieldValue = document.getElementsByName(this.fields[i].name)[0].value
          if(fieldValue){
            extendedSearchValues[this.fields[i].name] = fieldValue;
          }          
        }
      }

      if(this.dataSelected){
        var dates = this.dataSelected.split(" to ");
        extendedSearchValues['dateFrom'] = dates[0];
        extendedSearchValues['dateTo'] = dates[1];
      }

      this.filterText = {}
      this.filterText['extended'] = extendedSearchValues;
      this.$events.fire('extended-filter-set', this.filterText);

    },
    resetFilter () {
      this.filterText = ''
      this.$events.fire('filter-reset')
    }
  }
}
</script>
