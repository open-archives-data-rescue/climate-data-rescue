import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import '@/stylesheets/theme.scss'
import Vue from 'vue'
import { createApp } from 'vue';
import {store} from '@/store/model.store'

import Transcriptions from '@/transcriptions/Transcriptions.vue'

Vue.use(BootstrapVue)
Vue.use(IconsPlugin)

const app = createApp(Transcriptions)

app.use(store)
app.mount('#transcriptions-app')
