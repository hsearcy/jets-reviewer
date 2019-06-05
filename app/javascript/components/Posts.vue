<template>
  <div class="posts">
    <h1>Posts</h1>
    <div class="card column is-half">
      <div class="card-header-title">Add a new post</div>
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
    <div v-for="post in posts" v-bind:key="post.id">
      <p>{{post.title}}</p>
    </div>
    <p>{{ message }}</p>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "Posts",
  data: function() {
    return {
      message: "Hello Vue!",
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
