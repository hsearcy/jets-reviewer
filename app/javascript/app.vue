<template>
  <div id="app">
    <section class="hero is-dark is-bold">
      <div class="hero-body">
        <div class="container">
          <h1 class="title is-1">Posts</h1>
        </div>
      </div>
    </section>
    <router-view/>
  </div>
</template>

<script>
export default {
  name: "App"
};
</script>

<style>
</style>