import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import '@/stylesheets/theme.scss'
import Vue from 'vue'
import { createApp } from 'vue';
import {store} from '@/store/model.store'

import DataEntryAudits from '@/data_entry_audits/DataEntryAudits.vue'

Vue.use(BootstrapVue)
Vue.use(IconsPlugin)

const app = createApp(DataEntryAudits)

app.use(store)
app.mount('#data-entry-audits-app')
