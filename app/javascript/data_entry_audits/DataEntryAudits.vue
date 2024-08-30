
<template>
  <div>
    <b-container fluid class="mb-3">
      <b-row>
        <b-col>
          <h1>Data Entry Audit</h1>
        </b-col>
      </b-row>
    </b-container>
    <data-entry-audits-table></data-entry-audits-table>
  </div>
</template>

<script>
import DataEntryAuditsTable from './data_entry_audits_table.vue'
// import UrlHelpers from '../mixins/UrlHelpers'

export default {
  name: 'DataEntryAudits',
  components: {
    DataEntryAuditsTable
  },
  // mixins: [UrlHelpers],
  data: () => ({
  }),
  methods: {
  }
}
</script>

<style scoped lang="scss">

</style>
