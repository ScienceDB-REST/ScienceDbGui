<template>
  <div class="ui container">
    <filter-bar></filter-bar>
    <div class="inline field pull-left">
      <router-link v-bind:to="'microbiome_sample'"><button class="ui primary button">Add microbiome_sample</button></router-link>
      <button class="ui primary button" v-on:click="onDelete">Delete</button>
      <button class="ui primary button" v-on:click="onCsvExport">CSV</button>
    </div>
    <vuetable ref="vuetable"
      api-url="http://localhost:3000/microbiome_samples/vue_table"
      :fields="fields"
      pagination-path=""
      :per-page="20"
      detail-row-component="microbiome_sample-detail-row"
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
import microbiome_sampleCustomActions from './microbiome_sampleCustomActions.vue'
import microbiome_sampleDetailRow from './microbiome_sampleDetailRow.vue'
import FilterBar from './FilterBar.vue'

import axios from 'axios'

import Vue from 'vue'
import VueEvents from 'vue-events'
Vue.use(VueEvents)

Vue.component('microbiome_sample-custom-actions', microbiome_sampleCustomActions)
Vue.component('microbiome_sample-detail-row', microbiome_sampleDetailRow)
Vue.component('filter-bar', FilterBar)

export default {
  components: {
    Vuetable,
    VuetablePagination,
    VuetablePaginationInfo,
    microbiome_sampleDetailRow
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
            name: 'material',
            sortField: 'material'
          },
                  {
            name: 'life_cycle_phas',
            sortField: 'life_cycle_phas'
          },
                  {
            name: 'barcode_tag',
            sortField: 'barcode_tag'
          },
                  {
            name: 'description',
            sortField: 'description'
          },
                  {
            name: 'harvest_date',
            sortField: 'harvest_date'
          },
                {
          name: '__component:microbiome_sample-custom-actions',
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
      if (window.confirm("Do you really want to delete microbiome_samples of ids '" + this.$refs.vuetable.selectedTo.join("; ") + "'?")) {
        var t = this;
        var url = this.$baseUrl() + '/microbiome_sample/' + this.$refs.vuetable.selectedTo.join("/")
        axios.delete(url).then(function (response) {
          t.$refs.vuetable.refresh()
        }).catch(function (error) {
          t.error = error
        })
      }
    },
    onCsvExport () {
      var t = this;
      var url = this.$baseUrl() + '/microbiome_samples/example_csv' + '?array=[' + this.$refs.vuetable.selectedTo.join(",") + ']'
      
      axios.get(url).then(function (response) {

        var a = document.createElement("a");        
        document.body.appendChild(a);
        a.style = "display: none";
        var blob = new Blob([response.data], {type: "octet/stream"});
        var url = window.URL.createObjectURL(blob);
        a.href = url;
        a.download = 'microbiome_sample' + '.csv';
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
