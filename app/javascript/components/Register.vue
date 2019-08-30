<template>
  <section class="section">
    <section class="section is-small">
      <div class="container">
        <div class="card column is-half is-centered">
          <div class="card-header-title is-centered">Register</div>
          <div class="card-content">
            <form @submit.prevent="register" class="form-inline">
              <div class="field">
                <label class="label">Username</label>
                <div class="control">
                  <input class="input" type="text" v-model="registerData.username" required />
                </div>
              </div>
              <div class="field">
                <label class="label">Email</label>
                <div class="control">
                  <input class="input" type="email" v-model="registerData.email" required />
                </div>
              </div>
              <div class="field">
                <label class="label">Password</label>
                <div class="control">
                  <input class="input" type="password" v-model="registerData.password" required />
                </div>
              </div>
              <div class="field">
                <label class="label">Confirm Password</label>
                <div class="control">
                  <input class="input" type="password" v-model="password_confirmation" required />
                </div>
              </div>
              <div class="control">
                <button class="button is-primary" type="submit">Register</button>
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
  name: "Register",
  data() {
    return {
      registerData: {
        email: "",
        password: "",
        username: ""
      },
      password_confirmation: ""
    };
  },
  methods: {
    async register() {
      try {
        console.log("Register data = ", await this.registerData);
        await this.$store.dispatch("register", this.registerData);
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
