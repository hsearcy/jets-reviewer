<template>
  <section class="section">
    <section class="section is-small">
      <div class="container">
        <div class="card column is-half is-centered">
          <div class="card-header-title is-centered">Add a new post</div>
          <div class="card-content">
            <form v-on:submit.prevent="onSubmit" class="form-inline">
              <div class="field">
                <label class="label">Email</label>
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
              <div class="field">
                <label class="label">Username</label>
                <div class="control">
                  <input class="input" type="text" v-model="registerData.username" required>
                </div>
              </div>
              <div class="control">
                <button class="button is-primary" type="submit">Add</button>
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
  data: () => {
    return {
      registerData: {
        email: "",
        password: "",
        username: ""
      }
    };
  },
  async created() {
    await this.getPosts();
  },
  methods: {
    async onSubmit() {
      await axios.post("api/register", {
        post: this.registerData
      });
    },
  }
};
</script>

<style scoped>
</style>
