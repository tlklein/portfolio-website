import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vitejs.dev/config/
// vue-resume-template/ - old base folder name 
// trinity-klein-resume/ - possible future base folder name
export default defineConfig({
    base: '/', 
    plugins: [vue()],
    css: {
        preprocessorOptions: {
            scss: {
                silenceDeprecations: ["mixed-decls", "color-functions", "global-builtin", "import"],
            },
        },
    }
})