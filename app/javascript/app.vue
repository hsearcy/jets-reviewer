<template>
  <div id="app">
    <section class="hero is-dark is-bold">
      <div class="hero-body">
        <div class="container">
          <h1 class="title is-1">General Porpoise Reviewer</h1>
        </div>
        <nav class="navbar" role="navigation" aria-label="main navigation">
          <div class="navbar-brand">
            <router-link class="navbar-item" to="/">Home</router-link>
            <router-link class="navbar-item" v-if="!isLoggedIn" to="/login">Login</router-link>
            <router-link class="navbar-item" v-if="!isLoggedIn" to="/register">Register</router-link>
            <span class="navbar-item" v-if="isLoggedIn"> <a @click="logout">Logout {{user}}</a></span>
          </div>
        </nav>
      </div>
    </section>
    <router-view />
  </div>
</template>

<script>
export default {
  name: "App",
  computed: {
    isLoggedIn() {
      return this.$store.getters.isLoggedIn;
    },
    user() {
      return this.$store.getters.user;
    }
  },
  created() {
    this.$http.interceptors.response.use(undefined, async err => {
      if (err.status === 401 && err.config && !err.config.__isRetryRequest) {
        await this.$store.dispatch(logout);
      }
      throw err;
    });
  },
  methods: {
    async logout() {
      await this.$store.dispatch("logout");
      this.$router.push("/login");
    }
  }
};
</script>

<style>
</style>