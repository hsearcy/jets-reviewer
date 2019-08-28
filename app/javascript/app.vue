<template>
  <div id="app">
    <section class="hero is-dark is-bold">
      <div class="hero-body">
        <div class="container">
          <h1 class="title is-1">Posts</h1>
        </div>
        <nav class="navbar" role="navigation" aria-label="main navigation">
          <div class="navbar-brand">
            <router-link class="navbar-item" to="/">Home</router-link>
            <router-link class="navbar-item" to="/login">Login</router-link>
            <router-link class="navbar-item" to="/register">Register</router-link>
            <router-link class="navbar-item" to="/logout">Logout</router-link>
          </div>
        </nav>
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