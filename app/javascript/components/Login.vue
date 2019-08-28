<template>
  <section class="section">
    <section class="section is-small">
      <div class="container">
        <div class="card column is-half is-centered">
          <div class="card-header-title is-centered">Login</div>
          <div class="card-content">
            <form v-on:submit.prevent="onSubmit" class="form-inline">
              <div class="field">
                <label class="label">Username</label>
                <div class="control">
                  <input class="input" type="text" v-model="registerData.email" required>
                </div>
              </div>
              <div class="field">
                <label class="label">password</label>
                <div class="control">
                  <input class="input" type="password" v-model="registerData.password" required>
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
        email: "",
        password: "",
        username: ""
      }
    };
  },
  async created() {
  },
  methods: {
    async onSubmit() {
      
    },
  }
};
</script>

<style scoped>
</style>
