<template>
    <three v-if="id && parts[0]" :parts="parts" />
    <template v-else>
        <template v-if="!id">
            <h1 class="error">Missing Id</h1>
        </template>
        <template v-if="!parts[0] && id">
            <h1 class="error">Invalid ID</h1>
        </template>
    </template>
</template>

<script lang="ts" setup>
const route = useRoute();

const id = route.query.id ? route.query.id as string : false;

let parts: any = [];
if (id) {
    const { data } = await useFetch(`/api/models?id=${id}`);
    if (data.value?.body?.parts) {
        parts = JSON.parse(data.value?.body?.parts)
    }
}
</script>

<style>
body {
    margin: 0;
    height: 100vh;
    overflow: hidden;
    background: black;
}

.error {
    display: flex;
    justify-content: center;
    align-items: center;
    background: rgba(220, 0, 0, 0.75);
    padding: 20vh;
    color: white;
    font-size: 5rem;
    font-family: 'Roboto', sans-serif;
}
</style>