import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import '@/stylesheets/theme.scss'
import Vue from 'vue'
import { createApp } from 'vue';
import {store} from '@/store/model.store'

import Pages from '@/pages/pages.vue'

Vue.use(BootstrapVue)
Vue.use(IconsPlugin)

const app = createApp(Pages)

app.use(store)
app.mount('#pages-app')
