<template>
  <table-vue
    :model="model"
    :columns="columns"
    ref="pages-table"
    :filters="filters"
  >
    <template #cell(actions)="{ item }">
      <b-button
        block
        variant="primary"
        :href="item.admin_edit_url"
      >Edit</b-button>
      <b-button
        block
        variant="danger"
        :href="item.admin_delete_url"
        data-method="DELETE"
        :data-confirm="`Are you sure you want to delete page #${item.id}: ${item.title}?`"
      >Delete</b-button>
    </template>
    <template #cell(id)="{ item }">
      <b-link :href="item.admin_detail_url">
        {{ item.id }}
      </b-link>
    </template>
    <template #cell(title)="{ item }">
      <b-link :href="item.admin_detail_url">
        {{ item.title }}
      </b-link>
    </template>
    <template #cell(visible)="{ item }">
      <span v-if="item.visible">✔</span>
    </template>
    <template #cell(done)="{ item }">
      <span v-if="item.done">✔</span>
    </template>
    <template #cell(transcriptions)="{ item }">
      <div v-for="transcription in item.transcriptions" :key="transcription.id">
        <b-link :href="transcription.admin_detail_url">
          #{{ transcription.id }} ({{ transcription.percent_complete }}%)
        </b-link>
      </div>
    </template>
    <template #cell(page_days)="{ item }">
      <div v-for="page_day in item.page_days" :key="page_day.id">
        {{ page_day.date_datestring }} ({{ page_day.num_observations }})
      </div>
    </template>
    <template #cell(page_type_id)="{ item }">
      <b-link
        v-if="item.page_type"
        :href="item.page_type.admin_detail_url"
      >
        {{ item.page_type.title }}
      </b-link>
    </template>
    <template #cell(created_at)="{ item }">
      {{DateTime.fromISO(item.created_at).toFormat("DDD, t ZZZZ")}}
    </template>
    <template #cell(updated_at)="{ item }">
      {{DateTime.fromISO(item.updated_at).toFormat("DDD, t ZZZZ")}}
    </template>
  </table-vue>
</template>

<script>
import { pageModel as model } from '@/store/page.store'
import TableVue from '../components/table_vue.vue';
import { page_columns as columns } from './page_columns';
import { DateTime } from 'luxon';

export default {
  name: 'PagesTable',
  components: {
    TableVue,
  },
  data: () => ({
    columns,
    model,
    DateTime,
    filters: [
      'end_date', 'id', 'image_file_name', 'start_date', 'title'
    ]
  }),
  mounted() {
    this.$refs['pages-table'].fetchPaged()
  }
}
</script>
