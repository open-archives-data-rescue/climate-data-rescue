import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import FullReload from 'vite-plugin-full-reload'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  resolve: {
    alias: {
      vue: '@vue/compat'
    }
  },
  // logLevel: 'error',
  plugins: [
    RubyPlugin(),
    FullReload(['config/routes.rb', 'app/views/**/*'], { delay: 200 }),
    vue({
      template: {
        compilerOptions: {
          compatConfig: {
            MODE: 2
          }
        }
      }
    })
  ],
})

// see https://v3-migration.vuejs.org/migration-build.html#compat-configuration
// resolve: {
//   extensions: ['.js', '.mjs']
// }

// {
//   "compilerOptions": {
//     "module": "ESNext",
//       "target": "es2017",
//         "lib": ["ESNext", "DOM"],
//           "esModuleInterop": true,
//             "strict": true,
//               "strictNullChecks": true,
//                 "moduleResolution": "Node",
//                   "resolveJsonModule": true,
//                     "skipLibCheck": true,
//                       "paths": {
//       "@/*": ["./app/javascript/*"],
//         "~/*": ["./app/javascript/*"]
//     }
//   },
//   "exclude": [
//     "**/dist",
//     "**/node_modules",
//     "**/test"
//   ]
// }