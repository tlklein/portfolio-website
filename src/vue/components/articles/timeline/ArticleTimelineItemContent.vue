<template>
    <div class="timeline-item-content">
        <div class="timeline-item-content-header">
            <div class="timeline-item-content-header-title">
                <h4 class="fw-bold"
                    v-html="title"/>

                <InlineInfoList :items="infoListItems"/>
            </div>

            <div class="timeline-item-content-header-date-badge-wrapper" v-if="dateString">
                <InfoBadge  
                    class="date-badge"
                    fa-icon="fa-regular fa-calendar"
                    :value="dateString"
                />
            </div>
        </div>

        <div class="timeline-item-content-body">
            <p class="text-4 text-default description m-0"
               v-html="description"/>

            <p v-if="list && list.title"
               class="text-4 text-default list-title m-0 mt-2"
               v-html="list.title"/>

            <ul v-if="list && list.items && list.items.length"
                class="text-4 list-items m-0 mt-2">
                <li v-for="item in list.items"
                    v-html="item" />
            </ul>

            <div class="tags-wrapper mt-2 pt-1 mt-md-3">
                <Tags v-if="parsedTags && parsedTags.length"
                      :tags="parsedTags"/>
            </div>

        </div>
    </div>
</template>

<script setup>
import {computed, inject} from "vue"
import InlineInfoList from "/src/vue/components/widgets/InlineInfoList.vue"
import InfoBadge from "/src/vue/components/widgets/InfoBadge.vue"
import Tags from "/src/vue/components/widgets/Tags.vue"
import ArticleWidgetLinkList from "/src/vue/components/articles/base/ArticleWidgetLinkList.vue"

const props = defineProps({
    title: String,
    formattedDateStart: String,
    formattedDateEnd: String,
    province: String,
    country: String,
    institution: String,
    description: String,
    list: Object|null,
    tags: Object|String,
    links: {
        type: Array,
        default: () => []
  }
})

/** @type {{value: Boolean}} */
const isScreenXlOrLarger = inject("isScreenXlOrLarger")

const parsedTags = computed(() => {
    if(Array.isArray(props.tags))
        return props.tags
    return []
})

const dateString = computed(() => {
  return props.formattedDateEnd
    ? props.formattedDateStart +
        '<i class="mx-2 fa-solid fa-arrow-right-long" style="font-size: 10px; opacity: 0.85"></i>' +
        props.formattedDateEnd
    : props.formattedDateStart
})

const locationString = computed(() => {
    if(!props.province && !props.country)
        return null

    return `
        ${props.province ?? ''}
        ${props.province && props.country ? '-' : ''}
        ${props.country ?? ''}
    `
})

const institutionString = computed(() => {
    if(isScreenXlOrLarger.value)
        return props.institution

    const shortenedLocation = props.province || props.country

    if(!props.institution && shortenedLocation)
        return locationString.value
    if(!shortenedLocation && props.institution)
        return props.institution

    return `${props.institution}
        <span class="mx-1 opacity-50">·</span>
        ${shortenedLocation}
    `
})

const linksString = computed(() => {
  if (!props.links.length) return ''

  return props.links
    .filter(link => link?.href && link?.stringKey)
    .map(link => {
      // Remove underscore from stringKey 
      const formattedText = link.stringKey
        .split('_')
        .map(word => word.charAt(0).toUpperCase() + word.slice(1))
        .join(' ')

      return `<a href="${link.href}" target="_blank" rel="noopener">
                ${formattedText}
              </a>`
    })
    .join(' ')
})



const infoListItems = computed(() => {
    const compress = !isScreenXlOrLarger.value

    return [
        {
            faIcon: `fa-solid fa-clock`,
            value: dateString.value,
            visibility: ['mobile']
        },

        {
            faIcon: `fa-solid fa-building me-lg-2`,
            value: institutionString.value,
            visibility: ['desktop', 'mobile']
        },

        {
            faIcon: `fa-solid fa-font-awesome`,
            value: locationString.value,
            visibility: ['desktop']
        },

        {
            faIcon: `fa-solid fa-link me-lg-2`,
            value: linksString.value,
            visibility: ['desktop', 'mobile']
        },

    ].filter(item => item.value).filter(item => item.visibility.includes(compress ? 'mobile' : 'desktop'))
})

const links = computed(() => {
    return props.item.links
})

</script>

<style lang="scss" scoped>
@import "/src/scss/_theming.scss";

div.timeline-item-content {
    flex-grow: 1;
    margin-left: 20px;
    @include media-breakpoint-down(md) {
        margin-left: 16px;
    }
    @include media-breakpoint-down(sm) {
        margin-left: 12px;
    }
}

div.timeline-item-content-header {
    display: flex;
    padding-top: 1rem;
    width: 100%;
    @include media-breakpoint-down(md) {
        padding-top: 0.7rem;
    }
    @include media-breakpoint-down(sm) {
        padding-top: 0.4rem;
    }

    &-title {
        flex-grow: 1;
    }

    @include media-breakpoint-down($navigation-sidebar-breakpoint) {
        flex-direction: column;
    }
}

.date-badge {
    margin-left: 30px;
    min-width: 185px;

    @include media-breakpoint-down(xl) {
        display: none!important;
    }
}

div.timeline-item-content-body {
    margin-top: 20px;
    @include media-breakpoint-down(xl) {
        margin-top: 10px;
    }
    @include media-breakpoint-down(md) {
        margin-top: 5px;
    }
}

ul.list-items {
    @include media-breakpoint-down(md) {
        padding-left: 28px;
    }
}
</style>