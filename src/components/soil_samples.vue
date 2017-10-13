<template>
  <div class="ui container">
    <filter-bar></filter-bar>
    <div class="inline field pull-left">
      <router-link v-bind:to="'soil_sample'"><button class="ui primary button">Add soil_sample</button></router-link>
      <button class="ui primary button" v-on:click="onDelete">Delete</button>
      <button class="ui primary button" v-on:click="onCsvExport">CSV</button>
    </div>
    <vuetable ref="vuetable"
      api-url="http://localhost:3000/soil_samples/vue_table"
      :fields="fields"
      pagination-path=""
      :per-page="20"
      detail-row-component="soil_sample-detail-row"
      :appendParams="moreParams"
      @vuetable:pagination-data="onPaginationData"
      @vuetable:cell-clicked="onCellClicked"
    ></vuetable>
    <div class="vuetable-pagination ui basic segment grid">
      <vuetable-pagination-info ref="paginationInfo"
      ></vuetable-pagination-info>
      <vuetable-pagination ref="pagination"
        @vuetable-pagination:change-page="onChangePage"
      ></vuetable-pagination>
    </div>
  </div>
</template>

<script>
import Vuetable from 'vuetable-2/src/components/Vuetable.vue'
import VuetablePagination from 'vuetable-2/src/components/VuetablePagination.vue'
import VuetablePaginationInfo from 'vuetable-2/src/components/VuetablePaginationInfo.vue'
import soil_sampleCustomActions from './soil_sampleCustomActions.vue'
import soil_sampleDetailRow from './soil_sampleDetailRow.vue'
import FilterBar from './FilterBar.vue'

import axios from 'axios'

import Vue from 'vue'
import VueEvents from 'vue-events'
Vue.use(VueEvents)

Vue.component('soil_sample-custom-actions', soil_sampleCustomActions)
Vue.component('soil_sample-detail-row', soil_sampleDetailRow)
Vue.component('filter-bar', FilterBar)

export default {
  components: {
    Vuetable,
    VuetablePagination,
    VuetablePaginationInfo,
    soil_sampleDetailRow
  },
  data() {
    return {
      fields: [{
          name: '__sequence',
          title: '#',
          titleClass: 'center aligned',
          dataClass: 'right aligned'
        },
        {
          name: '__checkbox',
          titleClass: 'center aligned',
          dataClass: 'center aligned'
        },
                  {
            name: 'name',
            sortField: 'name'
          },
                  {
            name: 'harvest_date',
            sortField: 'harvest_date'
          },
                {
          name: '__component:soil_sample-custom-actions',
          title: 'Actions',
          titleClass: 'center aligned',
          dataClass: 'center aligned'
        }
      ],
      moreParams: {}
    }
  },
  methods: {
    onPaginationData(paginationData) {
      this.$refs.pagination.setPaginationData(paginationData)
      this.$refs.paginationInfo.setPaginationData(paginationData)
    },
    onChangePage(page) {
      this.$refs.vuetable.changePage(page)
    },
    onCellClicked(data, field, event) {
      console.log('cellClicked: ', field.name)
      this.$refs.vuetable.toggleDetailRow(data.id)
    },
    onFilterSet(filterText) {
      this.moreParams = {
        'filter': filterText.trim()
      }
      Vue.nextTick(() => this.$refs.vuetable.refresh())
    },
    onFilterReset() {
      this.moreParams = {}
      Vue.nextTick(() => this.$refs.vuetable.refresh())
    },
    onDelete () {
      if (window.confirm("Do you really want to delete soil_samples of ids '" + this.$refs.vuetable.selectedTo.join("; ") + "'?")) {
        var t = this;
        var url = this.$baseUrl() + '/soil_sample/' + this.$refs.vuetable.selectedTo.join("/")
        axios.delete(url).then(function (response) {
          t.$refs.vuetable.refresh()
        }).catch(function (error) {
          t.error = error
        })
      }
    },
    onCsvExport () {
      var t = this;
      var url = this.$baseUrl() + '/soil_samples/example_csv' + '?array=[' + this.$refs.vuetable.selectedTo.join(",") + ']'
      
      axios.get(url).then(function (response) {

        var a = document.createElement("a");        
        document.body.appendChild(a);
        a.style = "display: none";
        var blob = new Blob([response.data], {type: "octet/stream"});
        var url = window.URL.createObjectURL(blob);
        a.href = url;
        a.download = 'soil_sample' + '.csv';
        a.click();
        window.URL.revokeObjectURL(url);
      }).catch(function (error) {
        t.error = error
      })
    }
  },
  mounted() {
    this.$events.$on('filter-set', eventData => this.onFilterSet(eventData))
    this.$events.$on('filter-reset', e => this.onFilterReset())
  }
}
</script>
