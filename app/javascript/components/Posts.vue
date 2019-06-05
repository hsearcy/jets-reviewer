<template>
  <section class="section">
    <section class="section">
      <div class="container">
        <div class="card column is-half is-centered">
          <div class="card-header-title is-centered">Add a new post</div>
          <div class="card-content">
            <form v-on:submit.prevent="onSubmit" class="form-inline">
              <div class="field">
                <label class="label">Title</label>
                <div class="control">
                  <input class="input" type="text" v-model="postData.title" required>
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
    <section class="section">
      <div class="container">
        <table class="table is-striped is-hoverable">
          <thead>
            <tr>
              <th>All Posts</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="post in posts" v-bind:key="post.id">
              <td>{{post.title}}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </section>
  </section>
</template>

<script>
import axios from "axios";
export default {
  name: "Posts",
  data: function() {
    return {
      posts: [],
      postData: {
        title: ""
      }
    };
  },
  async created() {
    await this.getPosts();
  },
  methods: {
    async getPosts() {
      const response = await axios.get("http://localhost:8888/api/posts");
      this.posts = response.data;
    },
    async onSubmit() {
      await axios.post("http://localhost:8888/api/posts", {
        post: this.postData
      });
      this.postData.title = "";
      await this.getPosts();
    }
  }
};
</script>

<style scoped>
p {
  font-size: 2.1em;
  text-align: center;
}
</style>
