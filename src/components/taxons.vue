<template>
  <div class="ui container">   
    <collapse accordion>
      <collapse-item title="Search" actived>
        <filter-bar></filter-bar>
      </collapse-item>
      <collapse-item title="Add/Delete/Export" actived>
        <div class="column is-3">          
          <router-link v-bind:to="'taxon'" class="button is-primary">
            <button class="button is-primary">Add taxon</button>
          </router-link>
          <button class="button is-primary" v-on:click="onDelete">Delete</button>
          <button class="button is-primary" v-on:click="onCsvExport">CSV</button>
        </div>       
      </collapse-item>
      <collapse-item title="Advanced search">
        <extended-search-bar :fields="fields"></extended-search-bar>
      </collapse-item>
    </collapse>    
    
    <vuetable ref="vuetable"
      api-url="http://localhost:3000/taxons/vue_table"
      :fields="fields"
      pagination-path=""
      :per-page="20"
      detail-row-component="taxon-detail-row"
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
import taxonCustomActions from './taxonCustomActions.vue'
import taxonDetailRow from './taxonDetailRow.vue'
import FilterBar from './FilterBar.vue'

import ExtendedSearchBar from './ExtendedSearchBar.vue'

import axios from 'axios'

import Vue from 'vue'
import VueEvents from 'vue-events'
Vue.use(VueEvents)

Vue.component('taxon-custom-actions', taxonCustomActions)
Vue.component('taxon-detail-row', taxonDetailRow)
Vue.component('filter-bar', FilterBar)

Vue.component('extended-search-bar', ExtendedSearchBar)

export default {
  components: {
    Vuetable,
    VuetablePagination,
    VuetablePaginationInfo,
    taxonDetailRow
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
            name: 'taxonomic_level',
            sortField: 'taxonomic_level'
          },
                {
          name: '__component:taxon-custom-actions',
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
      this.$refs.vuetable.toggleDetailRow(data.id)
    },
    onFilterSet(filterText) {
      this.moreParams = {
        'filter': filterText.trim()
      }
      Vue.nextTick(() => this.$refs.vuetable.refresh())
    },
    onExtendedFilterSet(filterText) {
      this.moreParams = {
        'filter': JSON.stringify(filterText)
      }
      Vue.nextTick(() => this.$refs.vuetable.refresh())
    },
    onFilterReset() {
      this.moreParams = {}
      Vue.nextTick(() => this.$refs.vuetable.refresh())
    },
    onDelete() {
      if (window.confirm("Do you really want to delete taxons of ids '" + this.$refs.vuetable.selectedTo.join("; ") + "'?")) {
        var t = this;
        var url = 'http://localhost:3000/taxon/' + this.$refs.vuetable.selectedTo.join("/")
        axios.delete(url).then(function(response) {
          t.$refs.vuetable.refresh()
        }).catch(function(error) {
          t.error = error
        })
      }

    },
    onCsvExport() {
      var t = this;
      var url = 'http://localhost:3000/taxons/example_csv' + '?excel=true' + '&array=[' + this.$refs.vuetable.selectedTo.join(",") + ']'
      axios.get(url).then(function(response) {
        var a = document.createElement("a");        
        document.body.appendChild(a);
        a.style = "display: none";
        var blob = new Blob([response.data], {type: "octet/stream"});
        var url = window.URL.createObjectURL(blob);
        a.href = url;
        a.download = 'taxon' + '.csv';
        a.click();
        window.URL.revokeObjectURL(url);
      }).catch(function(error) {
        t.error = error
      })
    }
  },
  mounted() {
    this.$events.$on('filter-set', eventData => this.onFilterSet(eventData))
    this.$events.$on('filter-reset', e => this.onFilterReset())

    this.$events.$on('extended-filter-set', eventData => this.onExtendedFilterSet(eventData))
  }
}
</script>
