<template>
  <section class="section">
    <section class="section is-small">
      <div class="container">
        <div class="card column is-half is-centered">
          <div class="card-header-title is-centered">Login</div>
          <div class="card-content">
            <form @submit.prevent="login" class="form-inline">
              <div class="field">
                <label class="label">Username</label>
                <div class="control">
                  <input class="input" type="text" v-model="loginData.username" required />
                </div>
              </div>
              <div class="field">
                <label class="label">Password</label>
                <div class="control">
                  <input class="input" type="password" v-model="loginData.password" required />
                </div>
              </div>
              <div class="control">
                <button class="button is-primary" type="submit">Login</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </section>
  </section>
</template>

<script>
import axios from "../plugins/axios";
export default {
  name: "Login",
  data: () => {
    return {
      loginData: {
        username: "",
        password: "",
      }
    };
  },
  methods: {
    async login() {
      try {
        await this.$store.dispatch("login", this.loginData);
        this.$router.push("/");
      } catch (err) {
        console.log(err);
      }
    }
  }
};
</script>

<style scoped>
</style>
