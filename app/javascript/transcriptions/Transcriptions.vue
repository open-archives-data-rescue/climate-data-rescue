
<template>
  <div>
    <b-container fluid class="mb-3">
      <b-row>
        <b-col>
          <h1>Transcriptions</h1>
          <b-form-checkbox
            switch size="lg"
            v-model="forReview"
            @change="toggleForReview"
          >
          Show Ready for Review
          </b-form-checkbox>
        </b-col>
      </b-row>
    </b-container>
    <transcriptions-table
      :where="where"
    ></transcriptions-table>
  </div>
</template>

<script>
import TranscriptionsTable from './transcriptions_table.vue'
import UrlHelpers from '../mixins/UrlHelpers'

export default {
  name: 'Transcriptions',
  components: {
    TranscriptionsTable
  },
  mixins: [UrlHelpers],
  data: () => ({
    where: null,
    forReview: false
  }),
  methods: {
    toggleForReview(arg) {
      if (arg) {
        this.where = "review_transcriptions"
      } else {
        this.where = null
      }
    }
  }
}
</script>

<style scoped lang="scss">

</style>
