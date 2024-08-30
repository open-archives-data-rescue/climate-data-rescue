<!--
 -->
<template>
  <b-container
    class="pages-table-wrapper mb-3"
    fluid
  >
    <b-row>
      <b-col>
        <search-vue
          class="w-75"
          :value="filter"
          @change="onSearchChanged"
          :columns="columns"
          :filters="filters"
          ref="table-search"
        >
        </search-vue>
      </b-col>
    </b-row>

    <b-row class="pagination-row">
      <b-col>
        <b-input-group
          class="mb-0 page-size-group"
          prepend="Per page"
        >
          <b-form-select
            v-model="perPage"
            :options="pageOptions"
            class="page-size-selector"
            name="page_size"
          />
        </b-input-group>
      </b-col>
      <b-col>
        <b-pagination
          v-model="currentPage"
          class="my-0"
          align="right"
          :total-rows="totalRows"
          :per-page="perPage"
        />
      </b-col>
    </b-row>
    <b-row>
      <b-col>
        <b-table
          ref="table"
          class="vue-table"
          selectable responsive striped hover
          no-local-sorting no-footer-sorting no-sort-reset
          sticky-header="55vh"
          primary-key="id"
          :items="sortedCollection"
          :fields="tableColumns"

          :sort-by="sortBy"
          :sort-desc="sortDesc"

          @row-selected="onRowSelected"
          @sort-changed="onSortChanged"
        >
          <slot v-for="(_, name) in $slots" :name="name" />
          <template v-for="(_, name) in $slots" v-slot:[name]="slotData">
            <slot :name="name" v-bind="slotData" />
          </template>
        </b-table>
      </b-col>
    </b-row>
    <b-row
      class="pagination-row"
    >
      <b-col>
        <b-input-group
          class="mb-0 page-size-group"
          prepend="Per page"
        >
          <b-form-select
            v-model="perPage"
            :options="pageOptions"
            class="page-size-selector"
            name="page_size"
          />
        </b-input-group>
      </b-col>
      <b-col>
        <b-pagination
          v-model="currentPage"
          class="my-0"
          align="right"
          :total-rows="totalRows"
          :per-page="perPage"
        />
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import modelMixin from '../store/model.mixin';
import tableMixin from '../store/table.mixin';
import SearchVue from './search_vue.vue'


export default {
  name: 'TableVue',
  components: {
    SearchVue
  },
  mixins: [
    modelMixin,
    tableMixin
  ],
  data () {
    return {
      // perPage: 10,
      pageOptions: [10, 15, 20, 25, 50, 100],
    }
  },
  props : {
    columns : { type: Array },
    filters : { type: Array }
  },
  computed: {
    tableColumns () {
      return this.columns
    },
  },
  methods: {
    onRowSelected (rows) {
      // Set the selected data to the rows
      this.selected = rows

      this.selectAll = this.selected.length === this.pages.length
    },
    onSortChanged(ctx) {
      this.editable_ids = []
      this.sortBy = ctx.sortBy;
      this.sortDesc = ctx.sortDesc;
    },
    onSearchChanged(arg) {
      this.filter = arg
    }
  },
  watch: {
    currentPage(nv,ov) {
      if (ov != nv) {
        // page was changed so we clear our selected
        this.selected_items = []
        this.editable_ids = []
        this.keep = false
        this.selecedRowNbr = -1
      }
    }
  },
  // mounted () {
  // },
}
</script>

<style lang="scss">
  .pagination-row {
    padding-top: 0.5em;
    padding-bottom: 0.5em;
  }

  .b-table-sticky-header > table.b-table > thead > tr > th {
    position: sticky !important;
  }

  .vue-table {
    ::v-deep th {
      vertical-align: top;

      &.selected {
        width: 105px;
        text-align: center;
      }

      &.id {
        width: 75px;

        input {
          text-align: right;
        }
      }

      > .filter {
        select {
          margin-top: 0 !important;
          min-width: 50px;
        }
      }
    }

    ::v-deep td {

      &.number {
        text-align: right;
      }

      &.selected {
        text-align: center;
      }

      &.page-days {
        min-width: 150px;
      }

      &.transcriptions {
        min-width: 120px;
      }
    }
  }

  // .filter {
  //   > .input-group-append {
  //     > button.btn-outline-secondary {
  //       border: 1px solid #ced4da;
  //
  //       &:hover {
  //         background-color: #ced4da;
  //         color: #6c757d;
  //       }
  //     }
  //   }
  // }

  .page-size-group {
    width: 200px;

    .page-size-selector {
      text-align: right;
      text-align-last: right;

      ::v-deep option {
        direction: rtl;
      }
    }
  }

  .pagination {
    li.page-item.disabled {
      span.page-link {
        padding: .4rem .9rem !important;
      }
    }
  }
</style>
