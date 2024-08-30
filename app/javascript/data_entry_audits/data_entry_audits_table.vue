<template>
  <table-vue
    :model="model"
    :columns="columns"
    ref="data-entry-audits-table"
    :filters="filters"
    defaultSortBy="change_time"
    defaultSortDesc="true"
  >
    <!-- <template #cell(observation_date)="{ item }">
      {{DateTime.fromISO(item.observation_date).toFormat("DDD, t ZZZZ")}}
    </template> -->
    <template #cell(change_time)="{ item }">
      {{DateTime.fromISO(item.change_time).toFormat("DDD, t ZZZZ")}}
    </template>
  </table-vue>
</template>


<script>
import { dataEntryAuditModel as model } from '@/store/data_entry_audit.store'
import TableVue from '../components/table_vue.vue';
import { data_entry_audit_columns as columns } from './data_entry_audit_columns';
import { DateTime } from 'luxon';

export default {
  name: 'DataEntryAuditsTable',
  components: {
    TableVue,
  },
  props: {
  },
  data: () => ({
    columns,
    model,
    DateTime,
    filters: [
      'page_title', 'who_name', 'event'
    ]
  }),
  mounted() {
    this.$refs['data-entry-audits-table'].fetchPaged()
  }
}
</script>
