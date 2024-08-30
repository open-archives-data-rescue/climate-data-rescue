<template>
  <table-vue
    :model="model"
    :columns="columns"
    ref="transcriptions-table"
    :filters="filters"
    :where="where"
  >
    <template #cell(page_image)="{ item }">
      <b-link
        :href="item.admin_page_url"
        v-b-tooltip.hover title="View Details"
      >
        <b-img :src="item.page_image_url"></b-img>
      </b-link>
    </template>
    <template #cell(created_at)="{ item }">
      {{DateTime.fromISO(item.created_at).toFormat("DDD, t ZZZZ")}}
    </template>
    <template #cell(updated_at)="{ item }">
      {{DateTime.fromISO(item.updated_at).toFormat("DDD, t ZZZZ")}}
    </template>
    <template #cell(page.page_type_id)="{ item }">
      <b-link
        v-if="item.page.page_type"
        :href="item.page.page_type.admin_detail_url"
      >
        {{ item.page.page_type.title }}
      </b-link>
    </template>
    <template #cell(user)="{ item }">
      <b-link
        :href="item.user.user_url"
      >
        {{ item.user.display_name }}
      </b-link>
    </template>
    <template #cell(complete)="{ item }">
      <span v-if="item.complete">✔</span>
    </template>
    <template #cell(actions)="{ item }">
      <b-button
        block
        variant="info"
        :href="item.admin_edit_url"
      >Edit Transcription</b-button>
      <b-button
        block
        variant="primary"
        :href="item.admin_detail_url"
      >View Details</b-button>
      <b-dropdown right text="Download" variant="light" block v-if="item.complete">
        <b-dropdown-item target='_blank' :href="item.download_csv_url">Download CSV</b-dropdown-item>
        <b-dropdown-item target='_blank' :href="item.download_json_url">Download JSON</b-dropdown-item>
      </b-dropdown>
    </template>
  </table-vue>
</template>

<script>
import { transcriptionModel as model } from '@/store/transcription.store'
import TableVue from '../components/table_vue.vue';
import { transcription_columns as columns } from './transcription_columns';
import { DateTime } from 'luxon';

export default {
  name: 'TranscriptionsTable',
  components: {
    TableVue,
  },
  props: {
    where: {
      type: String,
      default: null
    }
  },
  data: () => ({
    columns,
    model,
    DateTime,
    filters: [
      'id', 'title', 'user.display_name'
    ]
  }),
  mounted() {
    this.$refs['transcriptions-table'].fetchPaged()
  }
}
</script>
