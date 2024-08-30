
<template>
  <b-navbar
    id="header-nav"
    class="py-0"
    toggleable="lg"
    type="dark"
    variant="dark"
  >
    <b-navbar-brand href="/">
      <b-img
        id="header-draw-logo"
        alt="DRAW"
        fluid
        :src="localizedLogo"
      />
      Manager
    </b-navbar-brand>

    <b-navbar-nav class="ml-auto">
      <b-nav-item-dropdown
        :text="locale.toUpperCase()"
        right
      >
        <b-dropdown-item
          v-if="locale != 'en'"
          :to="{ name: currentRouteName, params: { locale: 'en' }}"
        >
          EN
        </b-dropdown-item>
        <b-dropdown-item
          v-if="locale != 'fr'"
          :to="{ name: currentRouteName, params: { locale: 'fr' }}"
        >
          FR
        </b-dropdown-item>
      </b-nav-item-dropdown>

      <b-nav-item-dropdown
        text="Admin"
        right
      >
        <b-dropdown-item :to="{ name: 'pages', params: { locale: locale } }">
          Pages
        </b-dropdown-item>
        <b-dropdown-item :href="localizedPath('/admin/transcriptions')">
          Transcriptions
        </b-dropdown-item>
        <b-dropdown-divider />

        <b-dropdown-item :href="localizedPath('/admin/page_types')">
          Schemas
        </b-dropdown-item>
        <b-dropdown-item :href="localizedPath('/admin/field_groups')">
          Field Groups
        </b-dropdown-item>
        <b-dropdown-item :href="localizedPath('/admin/fields')">
          Fields
        </b-dropdown-item>
        <b-dropdown-item :href="localizedPath('/admin/field_options')">
          Field Values
        </b-dropdown-item>
        <b-dropdown-divider />

        <b-dropdown-item :href="localizedPath('/admin/data_entry_audit')">
          Data Entry Audit
        </b-dropdown-item>
        <b-dropdown-divider />

        <b-dropdown-item :href="localizedPath('/admin/static_pages')">
          Custom Pages
        </b-dropdown-item>
        <b-dropdown-item :href="localizedPath('/admin/content_images')">
          Content Images
        </b-dropdown-item>
        <b-dropdown-divider />

        <b-dropdown-item :href="localizedPath('/admin/users')">
          Users
        </b-dropdown-item>
      </b-nav-item-dropdown>

      <b-nav-item-dropdown right>
        <!-- Using 'button-content' slot -->
        <template #button-content>
          <em>User</em>
        </template>
        <b-dropdown-item :href="localizedPath('/my-profile')">
          Profile
        </b-dropdown-item>
        <b-dropdown-item
          href="/users/sign_out"
          data-method="DELETE"
        >
          Sign Out
        </b-dropdown-item>
      </b-nav-item-dropdown>
    </b-navbar-nav>
  </b-navbar>
</template>

<script>
import DrawLogoEn from '../images/drawlogo_en.png'
import DrawLogoFr from '../images/drawlogo_fr.png'
import UrlHelpers from '../mixins/UrlHelpers'

export default {
  name: 'Header',
  mixins: [UrlHelpers],
  computed: {
    currentRouteName () {
      return this.$route.name
    },
    localizedLogo () {
      return this.locale === 'en' ? DrawLogoEn : DrawLogoFr
    }
  }
}
</script>

<style scoped lang="scss" scoped>
  // @import 'stylesheets/draw-variables';

  #admin-app {
    #header-draw-logo {
      height: 100%;
      display: inline-block;
    }

    .bg-dark {
      background: rgba(0, 0, 0, 0.8) !important;
    }

    #header-nav {
      ::v-deep a {
        color: #ffffff;

        &:not(.navbar-brand):hover,
        &.router-link-active {
          background-color: $accent-color;
        }

        &.dropdown-item, {
          color: #2c3e50;

          &:hover {
            color: #ffffff;
          }
        }
      }

      ::v-deep .dropdown-menu {
        background: rgba(0, 0, 0, 0.8);

        a {
          color: #ffffff;

          &:hover {
            background-color: $accent-color;
          }
        }
      }
    }
  }

</style>
